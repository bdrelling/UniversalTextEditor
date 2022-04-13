// Copyright © 2022 Brian Drelling. All rights reserved.

import SwiftUI

public extension UniversalTextViewRepresentable {
    class Coordinator: NSObject {
        public var text: Binding<NSAttributedString>

        public init(text: Binding<NSAttributedString>) {
            self.text = text
        }
    }
}

// MARK: - Extensions

extension UniversalTextViewRepresentable.Coordinator {}

#if canImport(AppKit)

    extension UniversalTextViewRepresentable.Coordinator: NSTextViewDelegate {
        public func textDidChange(_ notification: Notification) {
            guard let textView = notification.object as? UXTextView else {
                return
            }
            
            self.text.wrappedValue = textView.textContentStorage?.attributedString ?? NSMutableAttributedString(string: textView.string)
        }

        public func textDidBeginEditing(_ notification: Notification) {}

        public func textDidEndEditing(_ notification: Notification) {}
    }

#elseif canImport(UIKit)

    extension UniversalTextViewRepresentable.Coordinator: UITextViewDelegate {
        public func textViewDidChange(_ textView: UXTextView) {
            self.text.wrappedValue = NSMutableAttributedString(string: textView.text)
        }

        public func textViewDidBeginEditing(_ textView: UXTextView) {
            MenuManager.enableMenu(for: textView)
        }

        public func textViewDidEndEditing(_ textView: UXTextView) {
            MenuManager.disableMenu()
        }
    }

#endif
