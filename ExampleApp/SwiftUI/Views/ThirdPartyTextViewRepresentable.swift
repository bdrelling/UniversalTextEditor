// Copyright © 2022 Brian Drelling. All rights reserved.

//// Copyright © 2022 Brian Drelling. All rights reserved.
//
// import CodeEditor
// import MarkdownTextView
// import Notepad
// import SwiftUI
//
// struct ThirdPartyTextViewRepresentable {
//    typealias View = MarkdownTextView
//
//    @Binding public private(set) var text: String
////    @Binding var textStyle: UIFont.TextStyle
//
//    private var attributedText: Binding<NSMutableAttributedString> {
//        Binding<NSMutableAttributedString>(get: {
//            .init(string: self.text)
//        }, set: {
//            self.text = $0.string
//        })
//    }
//
//    public init(text: Binding<String>) {
//        self._text = text
//    }
//
//    private func makeView(context: Context) -> View {
//        let textView = View(frame: .zero)
//
//        textView.setContentHuggingPriority(.required, for: .horizontal)
//        textView.setContentHuggingPriority(.required, for: .vertical)
//
//        textView.delegate = context.coordinator
////        textView.font = UIFont.preferredFont(forTextStyle: textStyle)
//        textView.isEditable = true
//        textView.isSelectable = true
//
//        return textView
//    }
//
//    private func updateView(_ textView: View, context: Context) {
//        guard let textStorage = textView.universalTextStorage else {
//            assertionFailure("No text storage found on ThirdParty Text View.")
//
//            #if canImport(AppKit)
//                textView.string = self.text
//            #elseif canImport(UIKit)
//                textView.text = self.text
//            #endif
//
//            return
//        }
//
//        // Replace the entire range of characters with the text.
//        textStorage.replaceCharacters(
//            in: NSMakeRange(0, textStorage.length),
//            with: self.text
//        )
//    }
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self.attributedText)
//    }
// }
//
// #if canImport(AppKit)
//
//    extension ThirdPartyTextViewRepresentable: NSViewRepresentable {
//        func makeNSView(context: Context) -> NSScrollView {
//            let textView: NSTextView = self.makeView(context: context)
//            textView.usesAdaptiveColorMappingForDarkAppearance = true
//            textView.autoresizingMask = [.width, .height]
//            textView.allowsUndo = true
//            textView.textContainerInset = .init(width: 32, height: 32)
//
//            let scrollView = NSScrollView()
//            scrollView.hasVerticalScroller = true
//            scrollView.documentView = textView
//
//            return scrollView
//        }
//
//        func updateNSView(_ scrollView: NSScrollView, context: Context) {
//            guard let textView = scrollView.documentView as? ThirdPartyTextViewRepresentable.View else {
//                return
//            }
//
//            self.updateView(textView, context: context)
//        }
//    }
//
//    extension NSTextView {
//        var universalTextStorage: NSTextStorage? {
//            self.textStorage
//        }
//    }
//
// #elseif canImport(UIKit)
//
//    extension ThirdPartyTextViewRepresentable: UIViewRepresentable {
//        func makeUIView(context: Context) -> ThirdPartyTextViewRepresentable.View {
//            let textView = self.makeView(context: context)
//            textView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//            textView.autocapitalizationType = .none
//            textView.smartDashesType = .no
//            textView.autocorrectionType = .no
//            textView.spellCheckingType = .no
//            textView.smartQuotesType = .no
//
//            return textView
//        }
//
//        func updateUIView(_ textView: MarkdownTextView, context: Context) {
//            self.updateView(textView, context: context)
//        }
//    }
//
//    extension UITextView {
//        var universalTextStorage: NSTextStorage? {
//            self.textStorage
//        }
//    }
//
// #endif
//
//// MARK: - Previews
//
// struct ThirdPartyTextViewRepresentable_Previews: PreviewProvider {
//    private static let warningMessage = """
//    Please note that UITextViews or NSTextViews running in previews within
//    the SwiftUI canvas (iOS) or XCPreviewAgent (macOS) are prone to quirky behaviors.
//
//    For example, bolding text that is partially bold on a real device will bold all the text, as expected,
//    but bolding text that is partially bold on a preview view will reset all the text to un-bold.
//    """
//
//    static var previews: some View {
//        ThirdPartyTextViewRepresentable(text: .constant(self.warningMessage))
//    }
// }
//
// extension ThirdPartyTextViewRepresentable {
//    class Coordinator: NSObject {
//        var text: Binding<NSMutableAttributedString>
//
//        init(_ text: Binding<NSMutableAttributedString>) {
//            self.text = text
//        }
//    }
// }
//
//// MARK: - Extensions
//
// extension ThirdPartyTextViewRepresentable.Coordinator {}
//
// #if canImport(AppKit)
//
//    extension ThirdPartyTextViewRepresentable.Coordinator: NSTextViewDelegate {
//        func textDidChange(_ notification: Notification) {
//            guard let textView = notification.object as? NSTextView else {
//                return
//            }
//
//            self.text.wrappedValue = textView.textStorage ?? NSMutableAttributedString(string: textView.string)
//        }
//
//        func textDidBeginEditing(_ notification: Notification) {}
//
//        func textDidEndEditing(_ notification: Notification) {}
//    }
//
// #elseif canImport(UIKit)
//
//    extension ThirdPartyTextViewRepresentable.Coordinator: UITextViewDelegate {
//        func textViewDidChange(_ textView: UITextView) {
//            self.text.wrappedValue = NSMutableAttributedString(string: textView.text)
//        }
//
//        func textViewDidBeginEditing(_ textView: UITextView) {}
//
//        func textViewDidEndEditing(_ textView: UITextView) {}
//    }
//
// #endif
