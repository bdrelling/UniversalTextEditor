// Copyright © 2022 Brian Drelling. All rights reserved.

@testable import UniversalTextEditor
import XCTest

final class TextReplacementPatternTests: XCTestCase {
    // MARK: - Bold

    func testBoldPattern() throws {
        let pattern: TextFormatter.Pattern = .bold
        let regex = try pattern.regex()

        // The pattern should have no distinct capture groups.
        XCTAssertEqual(regex.numberOfCaptureGroups, 0)
    }

    func testBoldMatches() throws {
        let pattern: TextFormatter.Pattern = .bold
        let regex = try pattern.regex()

        let data = [
            // Single Match
            ("**Lorem**", matches: 1),
            ("**Lorem ipsum dolor sit amet**", matches: 1),
            ("**1234**", matches: 1),
            ("**Lorem **and** 1234**", matches: 1),
            // Multiple Matches
            ("**Lorem** and **1234**", matches: 2),
            // No Matches
            ("** Lorem **", matches: 0),
            ("**Lorem **", matches: 0),
            ("** Lorem**", matches: 0),
            ("*Lorem*", matches: 0),
        ]

        for (text, expectedNumberOfMatches) in data {
            let numberOfMatches = regex.numberOfMatches(in: text)
            XCTAssertEqual(
                numberOfMatches,
                expectedNumberOfMatches,
                "\(numberOfMatches) matches for string '\(text)', expected \(expectedNumberOfMatches)."
            )
        }
    }

    func testRegex() throws {
        let pattern = #"\*[\w]+\*"#
        let text = "*Hello*"
        let regex = try NSRegularExpression(pattern: pattern)

//        let firstMatch = try XCTUnwrap()

        XCTAssertNotNil(regex.firstMatch(in: text, range: text.fullRange))
    }
}

extension NSRegularExpression {
    func hasMatch(in string: String) -> Bool {
        self.numberOfMatches(in: string) != 0
    }

    func numberOfMatches(in string: String) -> Int {
        self.numberOfMatches(in: string, range: string.fullRange)
    }
}

// MARK: - Extensions

extension String {
    var fullRange: NSRange {
        .init(location: 0, length: self.utf8.count)
    }
}
