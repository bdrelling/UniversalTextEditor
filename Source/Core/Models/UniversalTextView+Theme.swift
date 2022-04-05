// Copyright © 2022 Brian Drelling. All rights reserved.

import SwiftUI

public extension UniversalTextView {
    struct Theme {
        public let fonts: FontCollection
        public let paragraphStyle: NSParagraphStyle

        public let defaultTextAttributes: TextAttributes

        public init(
            fonts: FontCollection,
            paragraphStyle: NSParagraphStyle? = nil
        ) {
            self.fonts = fonts
            self.paragraphStyle = paragraphStyle ?? .default

            self.defaultTextAttributes = [
                .font: fonts.body,
                .paragraphStyle: paragraphStyle ?? .default,
            ]
        }
    }
}

public extension UniversalTextView.Theme {
    struct FontCollection {
        public let body: UXFont
        public let code: UXFont
        public let heading1: UXFont
        public let heading2: UXFont
        public let heading3: UXFont
        public let heading4: UXFont
        public let heading5: UXFont
        public let heading6: UXFont
    }
}

// MARK: - Convenience

public extension UniversalTextView.Theme {
    static let `default`: Self = .init(
        fonts: .init(
            body: .systemFont(ofSize: 17),
            code: .monospacedSystemFont(ofSize: 17, weight: .regular),
            heading1: .boldSystemFont(ofSize: 48),
            heading2: .boldSystemFont(ofSize: 36),
            heading3: .boldSystemFont(ofSize: 30),
            heading4: .boldSystemFont(ofSize: 24),
            heading5: .systemFont(ofSize: 20),
            heading6: .systemFont(ofSize: 18)
        )
    )
}

// MARK: - Extensions

private extension NSParagraphStyle {
    static var `default`: NSParagraphStyle {
        let style = NSMutableParagraphStyle()
//        style.lineSpacing = 20
        style.firstLineHeadIndent = 0
        style.paragraphSpacing = 12
        style.lineBreakMode = .byWordWrapping

        return style
    }
}
