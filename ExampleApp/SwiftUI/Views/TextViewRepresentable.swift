// Copyright © 2022 Brian Drelling. All rights reserved.

import SwiftUI
import UniversalTextEditor

public struct SimpleTextView {
    @Binding public private(set) var text: NSAttributedString
    
    func makeView(context: Context) -> View {
        let textView = View(frame: .zero)
        
        textView.setContentHuggingPriority(.required, for: .horizontal)
        textView.setContentHuggingPriority(.required, for: .vertical)
        
        return textView
    }
    
    func updateView(_ textView: View, context: Context) {
        #if canImport(AppKit)
        guard let textStorage = textView.textStorage else {
            assertionFailure("No text storage object found on UniversalTextView.")
            textView.string = self.text.string
            return
        }
        #elseif canImport(UIKit)
        let textStorage = textView.textStorage
        #endif

        // Replace the entire range of characters with the text.
        textStorage.replaceCharacters(
            in: NSMakeRange(0, textStorage.length),
            with: self.text
        )
    }
}

#if canImport(AppKit)

extension SimpleTextView: NSViewRepresentable {
    public typealias View = NSTextView
    
    public func makeNSView(context: Context) -> NSScrollView {
        let textView = self.makeView(context: context)
        textView.usesAdaptiveColorMappingForDarkAppearance = true
        textView.autoresizingMask = [.width, .height]
        textView.allowsUndo = true
        textView.textContainerInset = .init(width: 16, height: 16)

        let scrollView = NSTextView.scrollableTextView()
        scrollView.hasVerticalScroller = true
        scrollView.documentView = textView

        return scrollView
    }

    public func updateNSView(_ scrollView: NSScrollView, context: Context) {
        guard let textView = scrollView.documentView as? View else {
            return
        }

        self.updateView(textView, context: context)
    }
}

#elseif canImport(UIKit)

extension SimpleTextView: UIViewRepresentable {
    public typealias View = UITextView
    
    public func makeUIView(context: Context) -> View {
        self.makeView(context: context)
    }
    
    public func updateUIView(_ textView: View, context: Context) {
        self.updateView(textView, context: context)
    }
}

#endif
