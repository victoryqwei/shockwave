// update

import SwiftUI
import CoreBluetooth

struct DeviceView: View {
    @StateObject private var viewModel: DeviceViewModel
    @State private var didAppear = false

    //MARK: - Lifecycle
    
    init(peripheral: CBPeripheral) {
        let viewModel = DeviceViewModel(peripheral: peripheral)
        _viewModel = .init(wrappedValue: viewModel)
    }
    
    var body: some View {
        content()
            .onAppear {
                guard didAppear == false else {
                    return
                }
                didAppear = true
                viewModel.connect()
                viewModel.startMonitoring()
            }
    }

    //MARK: - Private
    
    @ViewBuilder
    private func content() -> some View {
        if viewModel.isReady {
            MainView(shockLevel: $viewModel.state.shockLevel, vibrateLevel: $viewModel.state.vibrateLevel)
        }
        else {
            Text("Not connected...")
        }
    }
}

//    @State private var modeSelectionIsPresented = false

//            .actionSheet(isPresented: $modeSelectionIsPresented) {
//                var buttons: [ActionSheet.Button] = ArduinoData.Mode.allCases.map { mode in
//                    ActionSheet.Button.default(Text("\(mode.title)")) {
//                        viewModel.state.mode = mode
//                    }
//                }
//                buttons.append(.cancel())
//                return ActionSheet(title: Text("Select Mode"), message: nil, buttons: buttons)
//            }

//                        modeSelectionIsPresented.toggle()

//                Toggle("On", isOn: $viewModel.state.isOn)
//                ColorPicker("Change Arduino color",
//                            selection: $viewModel.state.color,
//                            supportsOpacity: false)
//                HStack {
//                    Text("Mode")
//                    Spacer()
//                    Button(viewModel.state.mode?.title ?? "Solid Color") {
//                        modeSelectionIsPresented.toggle()
//                    }.foregroundColor(.accentColor)
//                }
//                HStack {
//                    Text("Speed")
//                    Slider(value: $viewModel.state.speed, in: 0...1)
//                }
