// update

import CoreBluetooth
import Combine
import UIKit

final class DeviceViewModel: ObservableObject {
    @Published var isReady = false
    @Published var state: ArduinoState = .init()

    private enum Constants {
        static let readServiceUUID: CBUUID = .init(string: "FFE0")
        static let writeServiceUUID: CBUUID = .init(string: "FFE0")
        static let serviceUUIDs: [CBUUID] = [readServiceUUID, writeServiceUUID]
        static let readCharacteristicUUID: CBUUID = .init(string: "FFE1")
        static let writeCharacteristicUUID: CBUUID = .init(string: "FFE1")
    }

    private lazy var manager: BluetoothManager = .shared
    private lazy var cancellables: Set<AnyCancellable> = .init()

    private let peripheral: CBPeripheral
    private var readCharacteristic: CBCharacteristic?
    private var writeCharacteristic: CBCharacteristic?
    
    private var proximityMonitoringAvailable = false

    //MARK: - Lifecycle

    init(peripheral: CBPeripheral) {
        self.peripheral = peripheral
        
        NotificationCenter.default.publisher(for: UIDevice.proximityStateDidChangeNotification)
            .sink { (notification) in
                guard let device = notification.object as? UIDevice else { return }

                if device.proximityState {
                    self.state.counter += 1
                }
            }
            .store(in: &cancellables)
    }

    deinit {
        cancellables.cancel()
    }

    func connect() {
        manager.servicesSubject
            .map { $0.filter { Constants.serviceUUIDs.contains($0.uuid) } }
            .sink { [weak self] services in
                services.forEach { service in
                    self?.peripheral.discoverCharacteristics(nil, for: service)
                }
            }
            .store(in: &cancellables)

        manager.characteristicsSubject
            .filter { $0.0.uuid == Constants.readServiceUUID }
            .compactMap { $0.1.first(where: \.uuid == Constants.readCharacteristicUUID) }
            .sink { [weak self] characteristic in
                self?.readCharacteristic = characteristic
                self?.update(ArduinoData.state(from: characteristic.value))
            }
            .store(in: &cancellables)

        manager.characteristicsSubject
            .filter { $0.0.uuid == Constants.writeServiceUUID }
            .compactMap { $0.1.first(where: \.uuid == Constants.writeCharacteristicUUID) }
            .sink { [weak self] characteristic in
                self?.writeCharacteristic = characteristic
            }
            .store(in: &cancellables)

        manager.connect(peripheral)
    }
    
    func startMonitoring() {
        UIDevice.current.isProximityMonitoringEnabled = true

        guard UIDevice.current.isProximityMonitoringEnabled else {
            print("Proximity monitoring unavailable")
            return
        }

        proximityMonitoringAvailable = true

        print("Enabled proximity monitoring")
    }

    private func update(_ state: ArduinoState) {
        let counterPublisher = state.$counter
            .combineLatest(state.$isOn, state.$mode)
            .map { ArduinoData.counterData(counter: $0, isOn: $1, mode: $2)}
        
        let isOnPublisher = state.$isOn
            .combineLatest(state.$mode)
            .map { ArduinoData.isOnData(isOn: $0, mode: $1) }
        
        let modePublisher = state.$mode
            .map { ArduinoData.modeData(mode: $0) }
        
        let shockPublisher = state.$shockLevel
            .map { ArduinoData.shockData(shockLevel: $0) }
        
        let vibratePublisher = state.$vibrateLevel
            .map { ArduinoData.vibrateData(vibrateLevel: $0) }
        
        counterPublisher.merge(with: isOnPublisher, modePublisher, shockPublisher, vibratePublisher)
            .sink { [weak self] in self?.write($0) }
            .store(in: &cancellables)
        
        self.state = state
        self.isReady = true
    }

    private func write(_ data: Data) {
        guard let characteristic = writeCharacteristic else {
            return
        }
        peripheral.writeValue(data, for: characteristic, type: .withoutResponse)
    }
}

func ==<Root, Value: Equatable>(lhs: KeyPath<Root, Value>, rhs: Value) -> (Root) -> Bool {
    { $0[keyPath: lhs] == rhs }
}

func ==<Root, Value: Equatable>(lhs: KeyPath<Root, Value>, rhs: Value?) -> (Root) -> Bool {
    { $0[keyPath: lhs] == rhs }
}

//        let onPublisher = state.$isOn
//            .map { ArduinoData.powerData(isOn: $0) }
//
//        let colorPublisher = state.$color
//            .compactMap { try? ArduinoData.staticColorData(from: $0) }
//
//        let modePublisher = state.$mode
//            .compactMap { $0 }
//            .combineLatest(state.$speed)
//            .map { ArduinoData.modeData(with: $0, speed: $1) }
//
//        onPublisher.merge(with: colorPublisher, modePublisher)
//            .dropFirst(3)
//            .sink { [weak self] in self?.write($0) }
//            .store(in: &cancellables)
