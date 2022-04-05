// Copyright © 2022 Brian Drelling. All rights reserved.

import SwiftUI

extension UXTextView: TextFormatting {
//    @objc
//    func toggleBold() {
//        let range = self.selectedRange
//
//        // Only allow toggling of bold when there is a selection.
//        guard range.length > 0 else {
//            return
//        }
//
//        let newText: NSMutableAttributedString = .init(attributedString: self.attributedText)
//
//        #warning("Use a better system size!")
//        newText.setAttributes([
//            .font: UIFont.boldSystemFont(ofSize: 16),
//        ], range: range)
//
//        self.attributedText = newText
//        self.selectedRange = range
//    }

    @objc
    func toggleSelectionBold() {
        #if canImport(AppKit)
            let range = self.selectedRange()
        #elseif canImport(UIKit)
            let range = self.selectedRange
        #endif

        // Only allow toggling of bold when there is a selection.
        guard range.length > 0 else {
            return
        }

        // We can only modify text if the textStorage property is valid.
        guard let textStorage = self.universalTextStorage else {
            return
        }

        Task {
            let results = await textStorage.enumerateAttribute(.font, in: range, options: [])
            let values = results.compactMap { $0.value as? UXFont }

            #if canImport(AppKit)
                let isAllTextBold = values.allSatisfy { $0.fontDescriptor.symbolicTraits.contains(.bold) }
            #elseif canImport(UIKit)
                let isAllTextBold = values.allSatisfy { $0.fontDescriptor.symbolicTraits.contains(.traitBold) }
            #endif

            if isAllTextBold {
                self.removeBold(in: range)
            } else {
                self.addBold(in: range)
            }

            // Required by iOS to ensure the selection doesn't change
            // self.selectedRange = range
        }
    }

    @objc
    func toggleSelectionItalics() {
        #if canImport(AppKit)
            let range = self.selectedRange()
        #elseif canImport(UIKit)
            let range = self.selectedRange
        #endif

        // Only allow toggling of bold when there is a selection.
        guard range.length > 0 else {
            return
        }

        // We can only modify text if the textStorage property is valid.
        guard let textStorage = self.universalTextStorage else {
            return
        }

        Task {
            let results = await textStorage.enumerateAttribute(.font, in: range, options: [])
            let values = results.compactMap { $0.value as? UXFont }

            #if canImport(AppKit)
                let isAllTextItalic = values.allSatisfy { $0.fontDescriptor.symbolicTraits.contains(.italic) }
            #elseif canImport(UIKit)
                let isAllTextItalic = values.allSatisfy { $0.fontDescriptor.symbolicTraits.contains(.traitItalic) }
            #endif

            if isAllTextItalic {
                self.removeItalics(in: range)
            } else {
                self.addItalics(in: range)
            }

            // Required by iOS to ensure the selection doesn't change
            // self.selectedRange = range
        }
    }

    @objc
    func toggleSelectionUnderline() {
        #if canImport(AppKit)
            let range = self.selectedRange()
        #elseif canImport(UIKit)
            let range = self.selectedRange
        #endif

        // Only allow toggling of bold when there is a selection.
        guard range.length > 0 else {
            return
        }

        // We can only modify text if the textStorage property is valid.
        guard let textStorage = self.universalTextStorage else {
            return
        }

        Task {
            let results = await textStorage.enumerateAttribute(.underlineStyle, in: range, options: [])
            let values = results.compactMap { $0.value as? Int }
            let isAllTextUnderlined = !values.isEmpty && values.allSatisfy { $0 != 0 }

            if isAllTextUnderlined {
                self.removeUnderline(in: range)
            } else {
                self.addUnderline(in: range)
            }

            // Required by iOS to ensure the selection doesn't change
            // self.selectedRange = range
        }
    }
}
