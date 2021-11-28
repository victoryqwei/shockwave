// update

import Foundation
import CoreGraphics
import UniformTypeIdentifiers

struct ArduinoData {
    static func modeData(mode: Mode) -> Data {
        let output = mode.rawValue
        return output.data(using: .utf8)!
    }
    
    static func shockData(shockLevel: Int) -> Data {
        let output = "s" + String(Int(shockLevel))
        return output.data(using: .utf8)!
    }
    
    static func vibrateData(vibrateLevel: Int) -> Data {
        let output = "v" + String(Int(vibrateLevel))
        return output.data(using: .utf8)!
    }

    static func state(from data: Data?) -> ArduinoState {
        let state = ArduinoState()
        
//        guard let data = data else {
//            return state
//        }
        
//        let values = data
//        if let mode = Mode(rawValue: String(values[0])) {
//            state.mode = mode
//        }
//        state.shockLevel = Int(String(values[1]).suffix(1))!
//        state.vibrateLevel = Int(String(values[2]).suffix(1))!
        
        return state
    }
}

extension ArduinoData {
    enum Mode: String, CaseIterable {
        case off = ""
        case shock = "s"
        case vibrate = "v"
        
        var title: String {
            switch self {
            case .off:
                return "Off"
            case .shock:
                return "Shock"
            case .vibrate:
                return "Vibrate"
            }
        }
    }
}

// https://github.com/madhead/saberlight/blob/master/protocols/Triones/protocol.md

//    enum ArduinoDataError: Error {
//        case noColorComponents
//    }
//
//    static func powerData(isOn: Bool) -> Data {
//        Data([0xCC, isOn ? 0x23 : 0x24, 0x33])
//    }
//
//    static func staticColorData(from color: CGColor) throws -> Data {
//        guard let components = color.components else {
//            throw ArduinoDataError.noColorComponents
//        }
//        let red = UInt8(components[0] * 255)
//        let green = UInt8(components[1] * 255)
//        let blue = UInt8(components[2] * 255)
//        return Data([0x56, red, green, blue, 0x00, 0xF0, 0xAA])
//    }
//
//    static func modeData(with mode: Mode, speed: Float) -> Data {
//        Data([0xBB, mode.rawValue, UInt8((1 - speed) * 255), 0x44])
//    }

//        guard let data = data else {
//            return state
//        }
//        let values = [UInt8](data)
//        state.isOn = values[2] == 0x23
//        state.color = CGColor(red: CGFloat(values[6]),
//                              green: CGFloat(values[7]),
//                              blue: CGFloat(values[8]),
//                              alpha: 1)
//        if let mode = Mode(rawValue: values[3]) {
//            state.mode = mode
//        }
//        state.speed = Float(values[5])

//extension ArduinoData {
//
//    enum Mode: UInt8, CaseIterable {
//
//        case pulsatingRainbow = 0x25
//        case pulsatingRed = 0x26
//        case pulsatingGreen = 0x27
//        case pulsatingBlue = 0x28
//        case pulsatingYellow = 0x29
//        case pulsatingCyan = 0x2A
//        case pulsatingPurple = 0x2B
//        case pulsatingWhite = 0x2C
//        case pulsatingRedGreen = 0x2D
//        case pulsatingRedBlue = 0x2E
//        case pulsatingGreenBlue = 0x2F
//        case rainbowStrobe = 0x30
//        case redStrobe = 0x31
//        case greenStrobe = 0x32
//        case blueStrobe = 0x33
//        case yellowStrobe = 0x34
//        case cyanStrobe = 0x35
//        case purpleStrobe = 0x36
//        case whiteStrobe = 0x37
//        case rainbowJumpingChange = 0x38
//
//        var title: String {
//            switch self {
//            case .pulsatingRainbow:
//                return "Pulsating rainbow"
//            case .pulsatingRed:
//                return "Pulsating red"
//            case .pulsatingGreen:
//                return "Pulsating green"
//            case .pulsatingBlue:
//                return "Pulsating blue"
//            case .pulsatingYellow:
//                return "Pulsating yellow"
//            case .pulsatingCyan:
//                return "Pulsating cyan"
//            case .pulsatingPurple:
//                return "Pulsating purple"
//            case .pulsatingWhite:
//                return "Pulsating white"
//            case .pulsatingRedGreen:
//                return "Pulsating red/green"
//            case .pulsatingRedBlue:
//                return "Pulsating red/blue"
//            case .pulsatingGreenBlue:
//                return "Pulsating green/blue"
//            case .rainbowStrobe:
//                return "Rainbow strobe"
//            case .redStrobe:
//                return "Reds strobe"
//            case .greenStrobe:
//                return "Green strobe"
//            case .blueStrobe:
//                return "Blue strobe"
//            case .yellowStrobe:
//                return "Yellow strobe"
//            case .cyanStrobe:
//                return "Cyan strobe"
//            case .purpleStrobe:
//                return "Purple strobe"
//            case .whiteStrobe:
//                return "White strobe"
//            case .rainbowJumpingChange:
//                return "Rainbow jumping change"
//            }
//        }
//    }
//}
