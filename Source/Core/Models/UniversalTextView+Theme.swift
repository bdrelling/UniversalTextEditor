// Copyright © 2022 Brian Drelling. All rights reserved.

import SwiftUI

public extension UniversalTextView {
    struct Theme {
        public let colors: ColorCollection
        public let fonts: FontCollection
        public let paragraphStyle: NSParagraphStyle

        let defaultTextAttributes: TextAttributes
        private(set) var markdownFormatters: [TextFormatter] = []

        public init(
            colors: ColorCollection = .default,
            fonts: FontCollection = .default,
            paragraphStyle: NSParagraphStyle? = nil
        ) {
            self.colors = colors
            self.fonts = fonts
            self.paragraphStyle = paragraphStyle ?? .default

            self.defaultTextAttributes = [
                .font: fonts.body,
                .paragraphStyle: paragraphStyle ?? .default,
            ]

            self.markdownFormatters = Self.markdownFormatters(for: self)
        }
    }
}

// MARK: - Supporting Types

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

    struct ColorCollection {
        public let background: UXColor
        public let body: UXColor

        public let blockQuote: UXColor
        public let blockQuoteStripe: UXColor
        public let code: UXColor
        public let codeBlockBackground: UXColor
        public let emphasis: UXColor
        public let heading1: UXColor
        public let heading2: UXColor
        public let heading3: UXColor
        public let heading4: UXColor
        public let heading5: UXColor
        public let heading6: UXColor
        public let link: UXColor
        public let strikethrough: UXColor
        public let strong: UXColor

        public init(
            background: UXColor = .white,
            body: UXColor = .black,
            blockQuote: UXColor = .darkGray,
            blockQuoteStripe: UXColor = .darkGray,
            code: UXColor = .black,
            codeBlockBackground: UXColor = .lightGray,
            emphasis: UXColor = .black,
            heading1: UXColor = .black,
            heading2: UXColor = .black,
            heading3: UXColor = .black,
            heading4: UXColor = .black,
            heading5: UXColor = .black,
            heading6: UXColor = .black,
            link: UXColor = .blue,
            strikethrough: UXColor = .darkGray,
            strong: UXColor = .black
        ) {
            self.background = background
            self.body = body
            self.blockQuote = blockQuote
            self.blockQuoteStripe = blockQuoteStripe
            self.code = code
            self.codeBlockBackground = codeBlockBackground
            self.emphasis = emphasis
            self.heading1 = heading1
            self.heading2 = heading2
            self.heading3 = heading3
            self.heading4 = heading4
            self.heading5 = heading5
            self.heading6 = heading6
            self.link = link
            self.strikethrough = strikethrough
            self.strong = strong
        }
    }
}

// MARK: - Convenience

public extension UniversalTextView.Theme {
    static let `default`: Self = .init(
        colors: .default,
        fonts: .default
    )

    static let debug: Self = .init(
        colors: .debug,
        fonts: .default
    )
}

public extension UniversalTextView.Theme.ColorCollection {
    static let `default`: Self = .init()

    static let debug: Self = .init(
        background: .black,
        body: .white,
        blockQuote: .purple,
        blockQuoteStripe: .purple,
        code: .orange,
        codeBlockBackground: .lightGray,
        emphasis: .yellow,
        heading1: .green,
        heading2: .green,
        heading3: .green,
        heading4: .green,
        heading5: .green,
        heading6: .green,
        link: .blue,
        strikethrough: .red,
        strong: .blue
    )
}

public extension UniversalTextView.Theme.FontCollection {
    static let `default`: Self = .init(
        body: .systemFont(ofSize: 17),
        code: .monospacedSystemFont(ofSize: 17, weight: .regular),
        heading1: .boldSystemFont(ofSize: 48),
        heading2: .boldSystemFont(ofSize: 36),
        heading3: .boldSystemFont(ofSize: 30),
        heading4: .boldSystemFont(ofSize: 24),
        heading5: .systemFont(ofSize: 20),
        heading6: .systemFont(ofSize: 18)
    )
}

// MARK: - Extensions

extension UniversalTextView.Theme {
    static func markdownFormatters(for theme: UniversalTextView.Theme) -> [TextFormatter] {
        [
            .blockQuote(with: [
                .foregroundColor: theme.colors.blockQuote,
            ]),
            .codeBlock(with: [
                .backgroundColor: theme.colors.codeBlockBackground,
                .font: theme.fonts.body.with(traits: .monoSpace),
                .foregroundColor: theme.colors.code,
            ]),
            .codeInline(with: [
                .font: theme.fonts.body.with(traits: .monoSpace),
                .foregroundColor: theme.colors.code,
            ]),
            .emphasis(with: [
                .font: theme.fonts.body.with(traits: .universalItalic),
                .foregroundColor: theme.colors.emphasis,
            ]),
            .h1(with: [
                .font: theme.fonts.heading1,
                .foregroundColor: theme.colors.heading1,
            ]),
            .h2(with: [
                .font: theme.fonts.heading2,
                .foregroundColor: theme.colors.heading2,
            ]),
            .h3(with: [
                .font: theme.fonts.heading3,
                .foregroundColor: theme.colors.heading3,
            ]),
            .h4(with: [
                .font: theme.fonts.heading4,
                .foregroundColor: theme.colors.heading4,
            ]),
            .h5(with: [
                .font: theme.fonts.heading5,
                .foregroundColor: theme.colors.heading5,
            ]),
            .h6(with: [
                .font: theme.fonts.heading6,
                .foregroundColor: theme.colors.heading6,
            ]),
            .strikethrough(with: [
                .strikethroughStyle: NSUnderlineStyle.single.rawValue,
                .foregroundColor: theme.colors.strikethrough,
            ]),
            .strong(with: [
                .font: theme.fonts.body.with(traits: .universalBold),
                .foregroundColor : theme.colors.strong,
            ]),
        ]
    }
}

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
