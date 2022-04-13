// Copyright © 2022 Brian Drelling. All rights reserved.

@testable import UniversalTextEditor
import XCTest

final class TextFormatterPatternTests: XCTestCase {
    // MARK: - Block Quote

    func testBlockQuotePattern() throws {
        throw XCTSkip("Not yet implemented.")
    }

    // MARK: - Code Block

    func testCodeBlockPattern() throws {
        throw XCTSkip("Not yet implemented.")
    }

    // MARK: - Code Inline

    func testCodeInlinePattern() throws {
        // Create the test data with expected number of matches.
        let data: TestDataCollection = [
            // Single Match
            ("`Lorem`", matches: 1),
            ("`Lorem ipsum dolor sit amet`", matches: 1),
            ("`1234`", matches: 1),
            ("` Lorem `", matches: 1),
            ("`Lorem `", matches: 1),
            ("` Lorem`", matches: 1),
            // Multiple Matches
            ("`Lorem `and` 1234`", matches: 2),
            ("`Lorem` and `1234`", matches: 2),
            ("`Lorem`and`1234`", matches: 2),
        ]

        try self.evaluate(pattern: .codeInline, using: data)
    }

    // MARK: - Emphasis

    func testEmphasisPattern() throws {
        // Create the test data with expected number of matches.
        let data = self.inlinePatternData(using: "_") + [
            // No additional data.
        ]

        try self.evaluate(pattern: .emphasis, using: data)
    }

    // MARK: - Headings

    func testH1Pattern() throws {
        try self.evaluate(pattern: .h1, using: self.headingPatternData(using: "#"))
    }

    func testH2Pattern() throws {
        try self.evaluate(pattern: .h2, using: self.headingPatternData(using: "##"))
    }

    func testH3Pattern() throws {
        try self.evaluate(pattern: .h3, using: self.headingPatternData(using: "###"))
    }

    func testH4Pattern() throws {
        try self.evaluate(pattern: .h4, using: self.headingPatternData(using: "####"))
    }

    func testH5Pattern() throws {
        try self.evaluate(pattern: .h5, using: self.headingPatternData(using: "#####"))
    }

    func testH6Pattern() throws {
        try self.evaluate(pattern: .h6, using: self.headingPatternData(using: "######"))
    }

    // MARK: - Strikethrough

    func testStrikethroughPattern() throws {
        // Create the test data with expected number of matches.
        let data = self.inlinePatternData(using: "~~") + [
            // No Matches
            ("~Lorem~", matches: 0),
        ]

        try self.evaluate(pattern: .strikethrough, using: data)
    }

    // MARK: - Strong

    func testStrongPattern() throws {
        // Create the test data with expected number of matches.
        let data = self.inlinePatternData(using: "**") + [
            // No Matches
            ("*Lorem*", matches: 0),
        ]

        try self.evaluate(pattern: .strong, using: data)
    }

    // MARK: - Sandbox

    func testExclusionRules() throws {
        // Test that the excluded text is being stripped out when pattern matching,
        // which will help to identify the string attribution as well.
        throw XCTSkip("Not yet implemented.")
    }

    // MARK: - Utilities

    private func evaluate(pattern: TextFormatter.Pattern, using data: TestDataCollection, numberOfCaptureGroups: Int = 1) throws {
        let regex = try pattern.regex()

        // The pattern should have one distinct capture group.
        XCTAssertEqual(regex.numberOfCaptureGroups, numberOfCaptureGroups)

        for (text, expectedNumberOfMatches) in data {
            let numberOfMatches = regex.numberOfMatches(in: text)
            XCTAssertEqual(
                numberOfMatches,
                expectedNumberOfMatches,
                "\(numberOfMatches) matches for string '\(text)', expected \(expectedNumberOfMatches)."
            )
        }
    }

    private func inlinePatternData(using symbols: String) -> TestDataCollection {
        [
            // Single Match
            ("\(symbols)Lorem\(symbols)", matches: 1),
            ("\(symbols)Lorem ipsum dolor sit amet\(symbols)", matches: 1),
            ("\(symbols)1234\(symbols)", matches: 1),
            ("\(symbols)Lorem \(symbols)and\(symbols) 1234\(symbols)", matches: 1),
            // Multiple Matches
            ("\(symbols)Lorem\(symbols) and \(symbols)1234\(symbols)", matches: 2),
            ("\(symbols)Lorem\(symbols)and\(symbols)1234\(symbols)", matches: 2),
            // No Matches
            ("\(symbols) Lorem \(symbols)", matches: 0),
            ("\(symbols)Lorem \(symbols)", matches: 0),
            ("\(symbols) Lorem\(symbols)", matches: 0),
        ]
    }

    #warning("Re-enable the below data points when the initial data set is successfully passing.")
    private func headingPatternData(using symbols: String) -> TestDataCollection {
        [
            // Single Match
            ("\(symbols) Lorem", matches: 1),
//            ("\(symbols) Lorem#", matches: 1),
//            ("\(symbols) Lorem #", matches: 1),
//            ("\(symbols) **Lorem**", matches: 1),
//            ("\(symbols) *Lorem*", matches: 1),
//            ("\(symbols) _Lorem_", matches: 1),
//            ("\(symbols) ~~Lorem~~", matches: 1),
//            ("\(symbols) `Lorem`", matches: 1),
//            // No Matches
//            ("\(symbols)Lorem", matches: 0),
            // Multi-line Matches
            ("""
            \(symbols) Lorem Ipsum
            """, matches: 1),
        ]
    }
}

// MARK: - Supporting Types

extension TextFormatterPatternTests {
    typealias TestDataCollection = [(String, matches: Int)]
}

// MARK: - Extensions

extension NSRegularExpression {
    func hasMatch(in string: String) -> Bool {
        self.numberOfMatches(in: string) != 0
    }

    func numberOfMatches(in string: String) -> Int {
        self.numberOfMatches(in: string, range: string.fullRange)
    }
}

extension String {
    var fullRange: NSRange {
        .init(location: 0, length: self.utf8.count)
    }
}
