// Copyright © 2022 Brian Drelling. All rights reserved.

import Foundation

extension TextFormatter {
    struct Pattern {
        private static let defaultPhraseRegex = #"[^\s][\S ]+[^\s]"#

        let rawValue: String

        private let exclusionPattern: String?

        init(_ pattern: String, excluding exclusionPattern: String? = nil) {
            self.rawValue = pattern
            self.exclusionPattern = exclusionPattern
        }

        func regex() throws -> NSRegularExpression {
            try .init(pattern: self.rawValue)
        }

        func exclusionRegex() -> NSRegularExpression? {
            if let exclusionPattern = self.exclusionPattern {
                return try? .init(pattern: exclusionPattern)
            } else {
                return nil
            }
        }
    }
}

// MARK: - Factory Methods

extension TextFormatter.Pattern {
    static func words(wrappedWith pattern: String) -> Self {
        self.init("\(pattern)\(Self.defaultPhraseRegex)\(pattern)", excluding: pattern)
    }

    static func words(startingWith pattern: String) -> Self {
        self.init("\(pattern)\(Self.defaultPhraseRegex)", excluding: pattern)
    }

    static func words(endingWith pattern: String) -> Self {
        self.init("\(Self.defaultPhraseRegex)\(pattern)", excluding: pattern)
    }

    static func words(startingWith startingPattern: String, endingWith endingPattern: String) -> Self {
        self.init("\(startingPattern)\(Self.defaultPhraseRegex)\(endingPattern)", excluding: startingPattern)
    }
}

// MARK: - Convenience

extension TextFormatter.Pattern {
    static let blockQuote: Self = .init(.blockQuote, excluding: "> ")
    // TODO: Code block exclusion rule is non-trivial and needs updating.
    static let codeBlock: Self = .init(.codeBlock, excluding: "```")
    static let codeInline: Self = .init(.codeInline, excluding: "`")
    static let emphasis: Self = .init(.emphasis, excluding: "_")
    static let h1: Self = .init(.h1, excluding: "# ")
    static let h2: Self = .init(.h2, excluding: "## ")
    static let h3: Self = .init(.h3, excluding: "### ")
    static let h4: Self = .init(.h4, excluding: "#### ")
    static let h5: Self = .init(.h5, excluding: "##### ")
    static let h6: Self = .init(.h6, excluding: "###### ")
    static let strikethrough: Self = .init(.strikethrough, excluding: "~~")
    static let strong: Self = .init(.strong, excluding: "**")

    static var allMarkdownPatterns: [Self] {
        [
            .blockQuote,
            .codeBlock,
            .codeInline,
            .emphasis,
            .h1,
            .h2,
            .h3,
            .h4,
            .h5,
            .h6,
            .strikethrough,
            .strong,
        ]
    }
}

// MARK: - Extensions

extension TextFormatter.Pattern {
    init(_ element: MarkdownElement, excluding: String? = nil) {
        self.init(element.pattern, excluding: excluding)
    }
}

extension TextFormatter.Pattern: ExpressibleByStringLiteral {
    init(stringLiteral value: String) {
        self.init(value)
    }
}
