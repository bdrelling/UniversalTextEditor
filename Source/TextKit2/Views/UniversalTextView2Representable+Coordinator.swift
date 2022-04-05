//// Copyright © 2022 Brian Drelling. All rights reserved.
//
//import SwiftUI
//
//public extension UniversalTextView2Representable {
//    class Coordinator: NSObject {
//        public var attributedText: Binding<NSAttributedString>
//
//        public init(attributedText: Binding<NSAttributedString>) {
//            self.attributedText = attributedText
//        }
//    }
//}
//
//// MARK: - Extensions
//
//extension UniversalTextView2Representable.Coordinator {}
//
//#if canImport(AppKit)
//
//    extension UniversalTextView2Representable.Coordinator: NSTextViewDelegate {
//        public func textDidChange(_ notification: Notification) {
//            guard let textView = notification.object as? UXTextView else {
//                return
//            }
//            
//            self.attributedText.wrappedValue = textView.textContentStorage?.attributedString ?? NSMutableAttributedString(string: textView.string)
//        }
//
//        public func textDidBeginEditing(_ notification: Notification) {}
//
//        public func textDidEndEditing(_ notification: Notification) {}
//    }
//
//#elseif canImport(UIKit)
//
//    extension UniversalTextView2Representable.Coordinator: UITextViewDelegate {
//        public func textViewDidChange(_ textView: UXTextView) {
//            self.text.wrappedValue = NSMutableAttributedString(string: textView.text)
//        }
//
//        public func textViewDidBeginEditing(_ textView: UXTextView) {
//            MenuManager.enableMenu(for: textView)
//        }
//
//        public func textViewDidEndEditing(_ textView: UXTextView) {
//            MenuManager.disableMenu()
//        }
//    }
//
//#endif
