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
    static let bold: Self = .words(wrappedWith: #"\*\*"#)
    static let italic: Self = .words(wrappedWith: #"_"#)
    static let strikethrough: Self = .words(wrappedWith: #"~~"#)
    static let h1: Self = .init(#"# +.+\n?"#, excluding: "# +")
    static let h2: Self = .words(startingWith: #"## +"#, endingWith: #"\n"#)
    static let h3: Self = .words(startingWith: #"### +"#, endingWith: #"\n"#)
    static let h4: Self = .words(startingWith: #"#### +"#, endingWith: #"\n"#)
    static let h5: Self = .words(startingWith: #"##### +"#, endingWith: #"\n"#)
    static let h6: Self = .words(startingWith: #"###### +"#, endingWith: #"\n"#)

    static var allMarkdownPatterns: [Self] {
        [
            .bold,
            .italic,
            .strikethrough,
            .h1,
            .h2,
            .h3,
            .h4,
            .h5,
            .h6,
        ]
    }
}

// MARK: - Extensions

extension TextFormatter.Pattern: ExpressibleByStringLiteral {
    init(stringLiteral value: String) {
        self.init(value)
    }
}
