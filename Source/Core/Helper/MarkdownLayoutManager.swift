// Copyright © 2022 Brian Drelling. All rights reserved.

import SwiftUI

final class MarkdownLayoutManager: NSLayoutManager {
    // MARK: Properties
    
    public var displayMode: UniversalTextView.DisplayMode = .default
    public var theme: UniversalTextView.Theme = .default
    
    // MARK: Initializers
    
    init(displayMode: UniversalTextView.DisplayMode = .default, theme: UniversalTextView.Theme = .default) {
        self.displayMode = displayMode
        self.theme = theme
        super.init()
        self.delegate = self
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.delegate = self
    }
}

// MARK: - Extensions

extension MarkdownLayoutManager: NSLayoutManagerDelegate {
    func layoutManager(_ layoutManager: NSLayoutManager, shouldGenerateGlyphs glyphs: UnsafePointer<CGGlyph>, properties props: UnsafePointer<NSLayoutManager.GlyphProperty>, characterIndexes charIndexes: UnsafePointer<Int>, font aFont: UXFont, forGlyphRange glyphRange: NSRange) -> Int {
        guard self.displayMode == .stylizedHiddenMarkdown else {
            return 0
        }
        
        // Make mutableProperties an optional to allow checking if it gets allocated
        var mutableProperties: UnsafeMutablePointer<NSLayoutManager.GlyphProperty>?

        // Check the attributes value only at charIndexes.pointee, where this glyphRange begins
        if let attribute = layoutManager.textStorage?.attribute(.displayType, at: charIndexes.pointee, effectiveRange: nil) as? DisplayType, attribute == .excluded {
//        if let attribute = textView.textStorage.attribute(.displayType, at: charIndexes.pointee, effectiveRange: nil) as? DisplayType, attribute == .excluded {

            // Allocate mutableProperties
            mutableProperties = .allocate(capacity: glyphRange.length)
            // Initialize each element of mutableProperties
            for index in 0 ..< glyphRange.length { mutableProperties?[index] = .null }
        }

        // Update only if mutableProperties was allocated
        if let mutableProperties = mutableProperties {
            layoutManager.setGlyphs(glyphs, properties: mutableProperties, characterIndexes: charIndexes, font: aFont, forGlyphRange: glyphRange)

            // Clean up this UnsafeMutablePointer
            mutableProperties.deinitialize(count: glyphRange.length)
            mutableProperties.deallocate()

            return glyphRange.length

        } else { return 0 }
    }
}
