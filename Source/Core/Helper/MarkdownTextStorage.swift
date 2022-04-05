// Copyright © 2022 Brian Drelling. All rights reserved.

import SwiftUI

public class MarkdownTextStorage: NSTextStorage {
    // MARK: Properties

    private let backingStore = NSMutableAttributedString()
    
    public var displayMode: UniversalTextView.DisplayMode = .default {
        didSet {
            self.update()
        }
    }
    
    public var theme: UniversalTextView.Theme = .default {
        didSet {
            self.update()
        }
    }

    override public var string: String {
        self.backingStore.string
    }
    
    private var formatters: [TextFormatter] {
        .markdownFormatters(for: self.theme)
    }

    // MARK: Initializers
    
    init(displayMode: UniversalTextView.DisplayMode, theme: UniversalTextView.Theme) {
        self.displayMode = displayMode
        self.theme = theme
        super.init()
    }

     required init?(coder aDecoder: NSCoder) {
         super.init(coder: aDecoder)
     }
    
     #if os(macOS)
         required init?(pasteboardPropertyList propertyList: Any, ofType type: NSPasteboard.PasteboardType) {
             super.init(pasteboardPropertyList: propertyList, ofType: type)
         }
     #endif

    // MARK: Overrides

    override public func attributes(at location: Int, effectiveRange range: NSRangePointer?) -> TextAttributes {
        self.backingStore.attributes(at: location, effectiveRange: range)
    }
    
    override public func processEditing() {
        self.performReplacementsForRange(changedRange: self.editedRange)
        super.processEditing()
    }

    override public func replaceCharacters(in range: NSRange, with str: String) {
        self.beginEditing()

        self.backingStore.replaceCharacters(in: range, with: str)
        self.edited(.editedCharacters, range: range, changeInLength: (str as NSString).length - range.length)

        self.endEditing()
    }

    override public func setAttributes(_ attrs: TextAttributes?, range: NSRange) {
        self.beginEditing()

        self.backingStore.setAttributes(attrs, range: range)
        self.edited(.editedAttributes, range: range, changeInLength: 0)

        self.endEditing()
    }

    // MARK: Utilities
    
    private func applyTextAttributes(of formatter: TextFormatter, to range: NSRange) {
        // Apply the text attributes to the range.
        self.addAttributes(formatter.attributes, range: range)

        // If the formatter has an exclusion pattern (eg. wrapping symbols to hide),
        // add the displayExcluded attributes to the matching ranges.
        // The MarkdownLayoutManager will use this attribute to hide the glyphs when rendering.
        formatter.pattern.exclusionRegex()?
            .matches(in: self.backingStore.string, range: range)
            .forEach { match in
                self.addAttributes(.displayExcluded, range: match.range)
            }

        #warning("I cannot figure out what this does!")
        // reset the style to the original
        let maxRange = range.location + range.length
        if maxRange + 1 < self.length {
            self.addAttributes(self.theme.defaultTextAttributes, range: NSMakeRange(maxRange, 1))
        }
    }

    private func processFormatters(in range: NSRange) throws {
        // Reset the range to the default before beginning.
        self.addAttributes(self.theme.defaultTextAttributes, range: range)
        
        // If the mose is plaintext, stop after resetting the text to the defaults.
        guard self.displayMode != .plainText else {
            return
        }
        
        // Iterate through each formatter and apply its text attributes to the matching ranges.
        for formatter in self.formatters {
            try formatter.pattern.regex()
                .matches(in: self.backingStore.string, range: range)
                .forEach { match in
                    self.applyTextAttributes(of: formatter, to: match.range)
                }
        }
    }
    
    private func tryProcessFormatters(in range: NSRange) {
        do {
            try self.processFormatters(in: range)
        } catch {
            self.report(error)
        }
    }

    private func performReplacementsForRange(changedRange: NSRange) {
        var extendedRange = NSUnionRange(
            changedRange,
            NSString(string: self.backingStore.string)
                .lineRange(for: NSMakeRange(changedRange.location, 0))
        )

        extendedRange = NSUnionRange(
            changedRange,
            NSString(string: self.backingStore.string)
                .lineRange(for: NSMakeRange(NSMaxRange(changedRange), 0))
        )

        self.tryProcessFormatters(in: extendedRange)
    }
    
    private func report(_ error: Error) {
        print(error.localizedDescription)
    }
    
    private func resetTextAttributes() {
        self.addAttributes(self.theme.defaultTextAttributes, range: NSMakeRange(0, self.length))
    }

    func update() {
        self.resetTextAttributes()
        self.tryProcessFormatters(in: NSMakeRange(0, self.length))
    }
}
