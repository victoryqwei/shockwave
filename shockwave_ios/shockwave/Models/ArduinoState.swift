// update

import Foundation
import CoreGraphics

final class ArduinoState: ObservableObject {
    @Published var mode = ArduinoData.Mode(rawValue: "")
    @Published var shockLevel: Double = 1;
    @Published var vibrateLevel: Double = 1;
}

//    @Published var isOn = false
//    @Published var color: CGColor = .init(red: 0, green: 0, blue: 0, alpha: 1)
//    @Published var mode: ArduinoData.Mode?
//    @Published var speed: Float = 0
