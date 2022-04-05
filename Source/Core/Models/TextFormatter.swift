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
    static func bold(with attributes: TextAttributes) -> Self {
        .init(pattern: .bold, attributes: attributes)
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

    static func italic(with attributes: TextAttributes) -> Self {
        .init(pattern: .italic, attributes: attributes)
    }

    static func strikethrough(with attributes: TextAttributes) -> Self {
        .init(pattern: .strikethrough, attributes: attributes)
    }

    static func strikethrough(style: NSUnderlineStyle = .single) -> Self {
        .strikethrough(with: [
            .strikethroughStyle: style.rawValue,
        ])
    }
}

// MARK: - Extensions

extension Array where Element == TextFormatter {
    static func markdownFormatters(for theme: UniversalTextView.Theme) -> Self {
        [
            .bold(with: [
                .font: theme.fonts.body.with(traits: .universalBold),
            ]),
            .h1(with: [
                .font: theme.fonts.heading1,
            ]),
            .h2(with: [
                .font: theme.fonts.heading2,
            ]),
            .h3(with: [
                .font: theme.fonts.heading3,
            ]),
            .h4(with: [
                .font: theme.fonts.heading4,
            ]),
            .h5(with: [
                .font: theme.fonts.heading5,
            ]),
            .h6(with: [
                .font: theme.fonts.heading6,
            ]),
            .italic(with: [
                .font: theme.fonts.body.with(traits: .universalItalic),
            ]),
            .strikethrough(),
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
