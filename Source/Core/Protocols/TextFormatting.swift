// Copyright © 2022 Brian Drelling. All rights reserved.

import Foundation
import SwiftUI

// TODO: This could all live as NSMutableAttributedString extension?
protocol TextFormatting: UXTextView {
    func toggleSelectionBold()
    func addBold(in range: NSRange)
    func removeBold(in range: NSRange)

    func toggleSelectionItalics()
    func addItalics(in range: NSRange)
    func removeItalics(in range: NSRange)

    func toggleSelectionUnderline()
    func addUnderline(in range: NSRange)
    func removeUnderline(in range: NSRange)

    func addAttribute(_ name: NSAttributedString.Key, value: Any, range: NSRange)
    func removeAttribute(_ name: NSAttributedString.Key, range: NSRange)
    func setAttributes(_ attributes: [NSAttributedString.Key: Any]?, range: NSRange)
}

// MARK: - Extensions

extension UXFont {
    static var defaultSystemFont: UXFont {
        UXFont.systemFont(ofSize: UXFont.systemFontSize)
    }

    func with(traits: UXFontDescriptor.SymbolicTraits) -> UXFont {
        #if canImport(AppKit)

            let descriptor = self.fontDescriptor.withSymbolicTraits(traits)

            return UXFont(descriptor: descriptor, size: 0) ?? .defaultSystemFont

        #elseif canImport(UIKit)

            guard let descriptor = self.fontDescriptor.withSymbolicTraits(traits) else {
                return .defaultSystemFont
            }

            return UXFont(descriptor: descriptor, size: 0)

        #endif
    }

    func adding(traits: UXFontDescriptor.SymbolicTraits) -> UXFont {
        var traits = traits
        let currentTraits = self.fontDescriptor.symbolicTraits
        traits.update(with: currentTraits)

        return self.with(traits: traits)
    }

    func removing(traits: UXFontDescriptor.SymbolicTraits) -> UXFont {
        let traits = traits
        var currentTraits = self.fontDescriptor.symbolicTraits
        currentTraits.remove(traits)

        return self.with(traits: currentTraits)
    }

    func bold() -> UXFont {
        #if canImport(AppKit)
            return self.with(traits: .bold)
        #elseif canImport(UIKit)
            return self.with(traits: .traitBold)
        #endif
    }

    func italic() -> UXFont {
        #if canImport(AppKit)
            return self.with(traits: .italic)
        #elseif canImport(UIKit)
            return self.with(traits: .traitItalic)
        #endif
    }
}

extension TextFormatting {
    func addBold(in range: NSRange) {
        self.add(traits: .universalBold, in: range)
    }

    func removeBold(in range: NSRange) {
        self.remove(traits: .universalBold, in: range)
    }

    func addItalics(in range: NSRange) {
        self.add(traits: .universalItalic, in: range)
    }

    func removeItalics(in range: NSRange) {
        self.remove(traits: .universalItalic, in: range)
    }

    private func add(traits: UXFontDescriptor.SymbolicTraits, in range: NSRange) {
        self.universalTextStorage?.enumerateAttribute(.font, in: range) { value, innerRange, _ in
            guard let currentFont = value as? UXFont else {
                return
            }

            let newFont = currentFont.adding(traits: traits)

            self.addAttribute(.font, value: newFont, range: innerRange)
        }
    }

    private func remove(traits: UXFontDescriptor.SymbolicTraits, in range: NSRange) {
        self.universalTextStorage?.enumerateAttribute(.font, in: range) { value, innerRange, _ in
            guard let currentFont = value as? UXFont else {
                return
            }

            let newFont = currentFont.removing(traits: traits)

            self.addAttribute(.font, value: newFont, range: innerRange)
        }
    }

    func addUnderline(in range: NSRange) {
        self.addAttribute(.underlineStyle, value: 1, range: range)
    }

    func removeUnderline(in range: NSRange) {
        self.removeAttribute(.underlineStyle, range: range)
    }

    func addAttribute(_ name: NSAttributedString.Key, value: Any, range: NSRange) {
        self.universalTextStorage?.addAttribute(name, value: value, range: range)
    }

    func removeAttribute(_ name: NSAttributedString.Key, range: NSRange) {
        self.universalTextStorage?.removeAttribute(name, range: range)
    }

    func setAttributes(_ attributes: [NSAttributedString.Key: Any]?, range: NSRange) {
        self.universalTextStorage?.setAttributes(attributes, range: range)
    }
}
