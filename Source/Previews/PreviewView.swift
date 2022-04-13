// Copyright © 2022 Brian Drelling. All rights reserved.

import SwiftUI

struct PreviewView {
    private let view: View

    init(_ view: View) {
        self.view = view
    }

    func makeView(context: Context) -> View {
        self.view.setContentHuggingPriority(.required, for: .horizontal)
        self.view.setContentHuggingPriority(.required, for: .vertical)

        return self.view
    }

    func updateView(_ view: View, context: Context) {}
}

#if canImport(AppKit)

    extension PreviewView: NSViewRepresentable {
        typealias View = NSView

        func makeNSView(context: Context) -> View {
            self.makeView(context: context)
        }

        func updateNSView(_ view: View, context: Context) {
            self.updateView(view, context: context)
        }
    }

#elseif canImport(UIKit)

    extension PreviewView: UIViewRepresentable {
        typealias View = UIView

        func makeUIView(context: Context) -> View {
            self.makeView(context: context)
        }

        func updateUIView(_ textView: View, context: Context) {
            self.updateView(textView, context: context)
        }
    }

#endif
