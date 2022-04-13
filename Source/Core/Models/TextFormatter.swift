// Copyright © 2022 Brian Drelling. All rights reserved.

import Foundation
import SwiftUI

struct TextFormatter {
    let pattern: Pattern
    let attributes: TextAttributes

    init(pattern: Pattern, attributes: NullableTextAttributes) {
        self.pattern = pattern
        self.attributes = attributes.compactMapValues { $0 }
    }
}

// MARK: - Factory Methods

extension TextFormatter {
    static func blockQuote(with attributes: NullableTextAttributes) -> Self {
        .init(pattern: .blockQuote, attributes: attributes)
    }

    static func codeBlock(with attributes: NullableTextAttributes) -> Self {
        .init(pattern: .codeBlock, attributes: attributes)
    }

    static func codeInline(with attributes: NullableTextAttributes) -> Self {
        .init(pattern: .codeInline, attributes: attributes)
    }

    static func emphasis(with attributes: NullableTextAttributes) -> Self {
        .init(pattern: .emphasis, attributes: attributes)
    }

    static func h1(with attributes: NullableTextAttributes) -> Self {
        .init(pattern: .h1, attributes: attributes)
    }

    static func h2(with attributes: NullableTextAttributes) -> Self {
        .init(pattern: .h2, attributes: attributes)
    }

    static func h3(with attributes: NullableTextAttributes) -> Self {
        .init(pattern: .h3, attributes: attributes)
    }

    static func h4(with attributes: NullableTextAttributes) -> Self {
        .init(pattern: .h4, attributes: attributes)
    }

    static func h5(with attributes: NullableTextAttributes) -> Self {
        .init(pattern: .h5, attributes: attributes)
    }

    static func h6(with attributes: NullableTextAttributes) -> Self {
        .init(pattern: .h6, attributes: attributes)
    }

    static func strikethrough(with attributes: NullableTextAttributes) -> Self {
        .init(pattern: .strikethrough, attributes: attributes)
    }

    static func strong(with attributes: NullableTextAttributes) -> Self {
        .init(pattern: .strong, attributes: attributes)
    }
}

// MARK: - Supporting Types

/// Stifles warnings for null values being coerced to Any.
/// This can be turned into a standard `TextAttributes` array by calling `.compactMapValues { $0 }`.
typealias NullableTextAttributes = [NSAttributedString.Key: Any?]

// MARK: - Extensions

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
