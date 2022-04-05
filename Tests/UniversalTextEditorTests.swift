// Copyright © 2022 Brian Drelling. All rights reserved.

@testable import UniversalTextEditor
import XCTest

import Down

final class UniversalTextEditorTests: XCTestCase {
    func testMarkdownSample() throws {
        let markdownText = """
        This is some markdown.
        *Woo this is bold*
        _This is sad_
        ~~This is strikethroughed~~
        """

        let attributedString = try NSAttributedString(markdown: markdownText)

        print(attributedString)
    }

    func testAttributeEnumeration() async throws {
        let text = NSMutableAttributedString(string: "0123456789")
        let fullRange = NSRange(location: 0, length: text.length)

        text.addAttribute(.foregroundColor, value: UXColor.red, range: .init(location: 0, length: 4))
        text.addAttribute(.backgroundColor, value: UXColor.blue, range: .init(location: 2, length: 4))
        text.addAttribute(.underlineStyle, value: 1, range: .init(location: 4, length: 4))

        let attributes = await text.enumerateAttributes(in: fullRange)

        XCTAssertEqual(attributes.count, 5)
    }

    func testDown() throws {
        let markdownText = """
        # Heading
        ## Subheading

        This is some markdown.

        **Woo this is bold**

        _This is sad_

        ~~This is strikethroughed~~

        > blockquote

        [link](google.com)

        - Wow
        - This
        - Is
        - A
        - List
        """

//        let attributedString = try AttributedString(markdown: markdownText)
//        NSAttributedString(attributedString: attributedString)

//
        let down = Down(markdownString: markdownText)

        let attributedString = try down.toAttributedString()

        print("START")
        print("")

        attributedString.enumerateAttributes(in: .init(location: 0, length: attributedString.length)) { values, range, _ in

            print("--- \(range) ---")

            for pair in values {
                print("\(pair.key.rawValue): \(pair.value)")
            }

            print("")
        }

        print("")
        print("STOP")
//
//        let wow = Document(parsing: markdownText)

//        let attributedString = down.toAttributedString()
    }
}

// Keys:
// font
// link
// strikethroughStyle
//

// static let attachment: NSAttributedString.Key
// The attachment for the text.
// static let backgroundColor: NSAttributedString.Key
// The color of the background behind the text.
// static let baselineOffset: NSAttributedString.Key
// The vertical offset for the position of the text.
// static let cursor: NSAttributedString.Key
// The cursor object.
// static let expansion: NSAttributedString.Key
// The expansion factor of the text.
// static let font: NSAttributedString.Key
// The font of the text.
// static let foregroundColor: NSAttributedString.Key
// The color of the text.
// static let glyphInfo: NSAttributedString.Key
// The name of a glyph info object.
// static let kern: NSAttributedString.Key
// The kerning of the text.
// static let ligature: NSAttributedString.Key
// The ligature of the text.
// static let link: NSAttributedString.Key
// The link for the text.
// static let markedClauseSegment: NSAttributedString.Key
// The index of the marked clause segment.
// static let obliqueness: NSAttributedString.Key
// The obliqueness of the text.
// static let paragraphStyle: NSAttributedString.Key
// The paragraph style of the text.
// static let shadow: NSAttributedString.Key
// The shadow of the text.
// static let spellingState: NSAttributedString.Key
// The spelling state of the text.
// static let strikethroughColor: NSAttributedString.Key
// The color of the strikethrough.
// static let strikethroughStyle: NSAttributedString.Key
// The strikethrough style of the text.
// static let strokeColor: NSAttributedString.Key
// The color of the stroke.
// static let strokeWidth: NSAttributedString.Key
// The width of the stroke.
// static let superscript: NSAttributedString.Key
// The superscript of the text.
// static let textAlternatives: NSAttributedString.Key
// The alternatives for the text.
// static let textEffect: NSAttributedString.Key
// The text effect.
// static let toolTip: NSAttributedString.Key
// The tooltip text.
// static let underlineColor: NSAttributedString.Key
// The color of the underline.
// static let underlineStyle: NSAttributedString.Key
// The underline style of the text.
// static let verticalGlyphForm: NSAttributedString.Key
// The vertical glyph form of the text.
// static let writingDirection: NSAttributedString.Key
// The writing direction of the text.
