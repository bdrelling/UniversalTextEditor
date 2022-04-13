// Copyright © 2022 Brian Drelling. All rights reserved.

import SwiftUI

struct PreviewTextView {
    private let textView: View
    
    init(_ textView: View) {
        self.textView = textView
    }
    
    func makeView(context: Context) -> View {
        self.textView.setContentHuggingPriority(.required, for: .horizontal)
        self.textView.setContentHuggingPriority(.required, for: .vertical)
        
        return self.textView
    }
    
    func updateView(_ textView: View, context: Context) { }
}

#if canImport(AppKit)

extension PreviewTextView: NSViewRepresentable {
    typealias View = NSTextView
    
    func makeNSView(context: Context) -> NSScrollView {
        let textView = self.makeView(context: context)
        textView.usesAdaptiveColorMappingForDarkAppearance = true
        textView.autoresizingMask = [.width, .height]
        textView.textContainerInset = .init(width: 16, height: 16)

        let scrollView = NSTextView.scrollableTextView()
        scrollView.hasVerticalScroller = true
        scrollView.documentView = textView

        return scrollView
    }

    func updateNSView(_ scrollView: NSScrollView, context: Context) {
        guard let textView = scrollView.documentView as? View else {
            return
        }

        self.updateView(textView, context: context)
    }
}

#elseif canImport(UIKit)

extension SimpleTextView: UIViewRepresentable {
    typealias View = UITextView
    
    func makeUIView(context: Context) -> View {
        self.makeView(context: context)
    }
    
    func updateUIView(_ textView: View, context: Context) {
        self.updateView(textView, context: context)
    }
}

#endif
