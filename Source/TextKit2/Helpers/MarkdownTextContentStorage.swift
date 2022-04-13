// Copyright © 2022 Brian Drelling. All rights reserved.

import SwiftUI

final class MarkdownTextContentStorage: NSTextContentStorage {
    override init() {
        super.init()

        self.delegate = self
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension MarkdownTextContentStorage: NSTextContentStorageDelegate {
    private var commentColor: NSColor {
        .white
    }

    private var commentFont: NSFont {
        var commentFont = NSFont.preferredFont(forTextStyle: .title3, options: [:])
        let commentFontDescriptor = commentFont.fontDescriptor.withSymbolicTraits(.italic)
        commentFont = NSFont(descriptor: commentFontDescriptor, size: commentFont.pointSize)!
        return commentFont
    }

    func textContentStorage(_ textContentStorage: NSTextContentStorage, textParagraphWith range: NSRange) -> NSTextParagraph? {
        // In this method, we'll inject some attributes for display, without modifying the text storage directly.
        var paragraphWithDisplayAttributes: NSTextParagraph?

        // First, get a copy of the paragraph from the original text storage.
        let originalText = textContentStorage.textStorage!.attributedSubstring(from: range)
        let textWithDisplayAttributes = NSMutableAttributedString(attributedString: originalText)
        // Use the display attributes for the text of the comment itself, without the reaction.
        // The last character is the newline, second to last is the attachment character for the reaction.
        let rangeForDisplayAttributes = NSRange(location: 0, length: textWithDisplayAttributes.length)

        textWithDisplayAttributes.addAttributes([.underlineStyle: NSUnderlineStyle.single.rawValue], range: rangeForDisplayAttributes)

        paragraphWithDisplayAttributes = NSTextParagraph(attributedString: textWithDisplayAttributes)

//        if origi
        // If the original paragraph wasn't a comment, this return value will be nil.
        // The text content storage will use the original paragraph in this case.
        return paragraphWithDisplayAttributes
//        return nil
    }
}

public extension NSAttributedString.Key {
    static var commentDepth: NSAttributedString.Key {
        NSAttributedString.Key("TK2DemoCommentDepth")
    }
}
