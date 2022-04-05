//// Copyright © 2022 Brian Drelling. All rights reserved.
//
//import SwiftUI
//
//public struct UniversalTextView2Representable {
//    public typealias View = UniversalTextView2
//    public typealias DisplayMode = UniversalTextView.DisplayMode
//
//    @State public private(set) var displayMode: DisplayMode
//    @Binding public private(set) var text: String
//
//    private let attributedText: Binding<NSAttributedString>
//
//    public init(displayMode: DisplayMode, text: Binding<String>) {
//        self.displayMode = displayMode
//        self._text = text
//        
//        self.attributedText = .init(
//            get: {
//                .init(string: text.wrappedValue)
//            }, set: {
//                text.wrappedValue = $0.string
//            }
//        )
//    }
//
//    private func makeView(context: Context) -> View {
//        let textView = View(frame: .zero, displayMode: self.displayMode)
//        textView.delegate = context.coordinator
//        textView.isEditable = true
//        textView.isSelectable = true
//
//        textView.setContentHuggingPriority(.required, for: .horizontal)
//        textView.setContentHuggingPriority(.required, for: .vertical)
//
//        return textView
//    }
//
//    private func updateView(_ textView: View, context: Context) {
//        guard let textContentStorage = textView.textContentStorage else {
//            assertionFailure("\(View.className()).textContentStorage property is nil.")
//            textView.text = self.text
//            return
//        }
//        
//        #warning("Not sure what to do here!")
//        print("Trying to update view.")
//        
////        textContentStorage.attributedString = self.attributedText.wrappedValue
//        
//        guard let textStorage = textContentStorage.textStorage else {
//            assertionFailure("\(View.className()).textContentStorage.textStorage property is nil.")
//            textView.text = self.text
//            return
//        }
//        
//        #warning("This causes the app to crash")
////        // Replace the entire range of characters with the text.
//        textStorage.replaceCharacters(
//            in: NSMakeRange(0, textStorage.length),
//            with: self.attributedText.wrappedValue
//        )
//    }
//
//    public func makeCoordinator() -> Coordinator {
//        Coordinator(attributedText: self.attributedText)
//    }
//}
//
//#if canImport(AppKit)
//
//    extension UniversalTextView2Representable: NSViewRepresentable {
//        public func makeNSView(context: Context) -> NSScrollView {
//            let textView = self.makeView(context: context)
//            textView.usesAdaptiveColorMappingForDarkAppearance = true
//            textView.autoresizingMask = [.width, .height]
//            textView.allowsUndo = true
//            textView.textContainerInset = .init(width: 16, height: 16)
//
//            let scrollView = NSTextView.scrollableTextView()
//            scrollView.hasVerticalScroller = true
//            scrollView.documentView = textView
//
//            return scrollView
//        }
//
//        public func updateNSView(_ scrollView: NSScrollView, context: Context) {
//            guard let textView = scrollView.documentView as? View else {
//                return
//            }
//
//            self.updateView(textView, context: context)
//        }
//    }
//
//#elseif canImport(UIKit)
//
//    extension UniversalTextView2Representable: UIViewRepresentable {
//        public func makeUIView(context: Context) -> View {
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
//        public func updateUIView(_ textView: View, context: Context) {
//            self.updateView(textView, context: context)
//        }
//    }
//
//#endif
//
//// MARK: - Previews
//
//struct UniversalTextView2Representable_Previews: PreviewProvider {
//    private static let warningMessage = """
//    Please note that UITextViews or NSTextViews running in previews within
//    the SwiftUI canvas (iOS) or XCPreviewAgent (macOS) are prone to quirky behaviors.
//
//    For example, bolding text that is partially bold on a real device will bold all the text, as expected,
//    but bolding text that is partially bold on a preview view will reset all the text to un-bold.
//    """
//
//    static var previews: some View {
//        ForEach(UniversalTextView.DisplayMode.allCases, id: \.self) { mode in
//            UniversalTextView2Representable(displayMode: mode, text: .constant(self.warningMessage))
//        }
//    }
//}
