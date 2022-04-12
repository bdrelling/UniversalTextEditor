// Copyright © 2022 Brian Drelling. All rights reserved.

import Foundation
import SwiftUI

struct TextFormatter {
    let pattern: Pattern
    let attributes: TextAttributes

    init(pattern: Pattern, attributes: TextAttributes) {
        self.pattern = pattern
        self.attributes = attributes
    }
}

// MARK: - Factory Methods

extension TextFormatter {
    static func blockQuote(with attributes: TextAttributes) -> Self {
        .init(pattern: .blockQuote, attributes: attributes)
    }
    
    static func codeBlock(with attributes: TextAttributes) -> Self {
        .init(pattern: .codeBlock, attributes: attributes)
    }
    
    static func codeInline(with attributes: TextAttributes) -> Self {
        .init(pattern: .codeInline, attributes: attributes)
    }
    
    static func emphasis(with attributes: TextAttributes) -> Self {
        .init(pattern: .emphasis, attributes: attributes)
    }
    
    static func h1(with attributes: TextAttributes) -> Self {
        .init(pattern: .h1, attributes: attributes)
    }
    
    static func h2(with attributes: TextAttributes) -> Self {
        .init(pattern: .h2, attributes: attributes)
    }
    
    static func h3(with attributes: TextAttributes) -> Self {
        .init(pattern: .h3, attributes: attributes)
    }
    
    static func h4(with attributes: TextAttributes) -> Self {
        .init(pattern: .h4, attributes: attributes)
    }
    
    static func h5(with attributes: TextAttributes) -> Self {
        .init(pattern: .h5, attributes: attributes)
    }
    
    static func h6(with attributes: TextAttributes) -> Self {
        .init(pattern: .h6, attributes: attributes)
    }

    static func strikethrough(with attributes: TextAttributes) -> Self {
        .init(pattern: .strikethrough, attributes: attributes)
    }

    static func strikethrough(style: NSUnderlineStyle = .single) -> Self {
        .strikethrough(with: [
            .strikethroughStyle: style.rawValue,
        ])
    }
    
    static func strong(with attributes: TextAttributes) -> Self {
        .init(pattern: .strong, attributes: attributes)
    }
}

// MARK: - Extensions

extension Array where Element == TextFormatter {
    static func markdownFormatters(for theme: UniversalTextView.Theme) -> Self {
        [
            .blockQuote(with: [
                .foregroundColor : UXColor.purple,
            ]),
            .codeBlock(with: [
                .font: theme.fonts.body.with(traits: .monoSpace),
                .foregroundColor : UXColor.orange,
            ]),
            .codeInline(with: [
                .font: theme.fonts.body.with(traits: .monoSpace),
                .foregroundColor : UXColor.orange,
            ]),
            .emphasis(with: [
                .font: theme.fonts.body.with(traits: .universalItalic),
                .foregroundColor : UXColor.yellow,
            ]),
            .h1(with: [
                .font: theme.fonts.heading1,
                .foregroundColor : UXColor.green,
            ]),
            .h2(with: [
                .font: theme.fonts.heading2,
                .foregroundColor : UXColor.green,
            ]),
            .h3(with: [
                .font: theme.fonts.heading3,
                .foregroundColor : UXColor.green,
            ]),
            .h4(with: [
                .font: theme.fonts.heading4,
                .foregroundColor : UXColor.green,
            ]),
            .h5(with: [
                .font: theme.fonts.heading5,
                .foregroundColor : UXColor.green,
            ]),
            .h6(with: [
                .font: theme.fonts.heading6,
                .foregroundColor : UXColor.green,
            ]),
            .strikethrough(with: [
                .strikethroughStyle: NSUnderlineStyle.single.rawValue,
                .foregroundColor : UXColor.red,
            ]),
            .strong(with: [
                .font: theme.fonts.body.with(traits: .universalBold),
//                .foregroundColor : UXColor.blue,
            ]),
        ]
    }
}

extension UXFont {
    func adjusted(for textStyle: TextStyle) -> UXFont {
        let preferredFont = UXFont.preferredFont(forTextStyle: textStyle)
        
        if let fontFamily = self.familyName {
            let themeFontDescriptor = preferredFont.fontDescriptor.withFamily(fontFamily)
            return UXFont(descriptor: themeFontDescriptor, size: preferredFont.pointSize) ?? preferredFont
        } else {
            return preferredFont
        }
    }
}
