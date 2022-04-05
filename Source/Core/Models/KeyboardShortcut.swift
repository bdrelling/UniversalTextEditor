// Copyright © 2022 Brian Drelling. All rights reserved.

import Foundation
import SwiftUI

struct KeyboardShortcut {
    let characters: String
    let modifierFlags: [ModifierFlag]
    let action: Selector
}

enum ModifierFlag {
    case option
    case capsLock
    case command
    case control
    case function
    case help
    case numericPad
    case shift
}

#if canImport(AppKit)

    extension ModifierFlag {
        var platformSafeFlag: NSEvent.ModifierFlags? {
            switch self {
            case .option:
                return .option
            case .capsLock:
                return .capsLock
            case .command:
                return .command
            case .control:
                return .control
            case .function:
                return .function
            case .help:
                return .help
            case .numericPad:
                return .numericPad
            case .shift:
                return .shift
            }
        }
    }

#elseif canImport(UIKit)

    extension ModifierFlag {
        var platformSafeFlag: UIKeyModifierFlags? {
            switch self {
            case .option:
                return .alternate
            case .capsLock:
                return .alphaShift
            case .command:
                return .command
            case .control:
                return .control
            case .function:
                return nil
            case .help:
                return nil
            case .numericPad:
                return .numericPad
            case .shift:
                return .shift
            }
        }
    }

#endif
