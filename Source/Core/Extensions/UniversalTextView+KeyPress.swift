// Copyright © 2022 Brian Drelling. All rights reserved.

import SwiftUI

#if canImport(AppKit)

    public extension UniversalTextView {
        override func keyDown(with event: NSEvent) {
            switch event.keyCode {
            case KeyCode.b where event.modifierFlags.contains(.command):
                self.toggleSelectionBold()
            case KeyCode.i where event.modifierFlags.contains(.command):
                self.toggleSelectionItalics()
            case KeyCode.u where event.modifierFlags.contains(.command):
                self.toggleSelectionUnderline()
            default:
                super.keyDown(with: event)
            }
        }
    }

#elseif canImport(UIKit)

    public extension UniversalTextView {
        override func pressesBegan(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
            guard let pressedKey = presses.first?.key else {
                super.pressesBegan(presses, with: event)
                return
            }

//            let characters = pressedKey.charactersIgnoringModifiers

            switch pressedKey.keyCode {
            case .keyboardB where pressedKey.modifierFlags.contains(.command):
                self.toggleSelectionBold()
            case .keyboardI where pressedKey.modifierFlags.contains(.command):
                self.toggleSelectionItalics()
            case .keyboardU where pressedKey.modifierFlags.contains(.command):
                self.toggleSelectionUnderline()
            default:
                super.pressesBegan(presses, with: event)
            }
        }
    }

#endif
