// Copyright © 2022 Brian Drelling. All rights reserved.

import Down
import SwiftUI

open class UniversalTextView2: UXTextView {
    public typealias DisplayMode = UniversalTextView.DisplayMode
    public typealias Theme = UniversalTextView.Theme
    
    // MARK: Properties

    public private(set) var hasMenuEnabled: Bool = true

    public var displayMode: DisplayMode = .default {
        didSet {
            (self.layoutManager as? MarkdownLayoutManager)?.displayMode = self.displayMode
            (self.textStorage as? MarkdownTextStorage)?.displayMode = self.displayMode
        }
    }

    public var theme: Theme = .default {
        didSet {
            (self.layoutManager as? MarkdownLayoutManager)?.theme = self.theme
            (self.textStorage as? MarkdownTextStorage)?.theme = self.theme
        }
    }

    private let keyboardShortcuts: [KeyboardShortcut] = [
        .init(characters: "b", modifierFlags: [.command], action: #selector(toggleSelectionBold)),
        .init(characters: "i", modifierFlags: [.command], action: #selector(toggleSelectionItalics)),
        .init(characters: "u", modifierFlags: [.command], action: #selector(toggleSelectionUnderline)),
    ]

    // MARK: Initializers

    public convenience init(displayMode: DisplayMode = .default, theme: Theme = .default) {
        self.init(frame: .zero, displayMode: displayMode, theme: theme)
    }

    public convenience init(frame: CGRect, displayMode: DisplayMode = .default, theme: Theme = .default) {
        // If using a custom NSTextContainer, this view becomes unscrollable.
        // Therefore we initialize this view first, then pass its textContainer into the layoutManager.
        self.init(frame: frame)
        
        let textContainer = NSTextContainer()
        textContainer.widthTracksTextView = true
        textContainer.heightTracksTextView = true
        
        let layoutManager = MarkdownTextLayoutManager()
        layoutManager.textContainer = textContainer

        let textStorage = MarkdownTextContentStorage()
        textStorage.addTextLayoutManager(layoutManager)

        self.displayMode = displayMode
        self.theme = theme
    }

    #if os(macOS)
        override private init(frame: CGRect) {
            super.init(frame: frame)
        }

    #elseif os(iOS)
        private init(frame: CGRect) {
            super.init(frame: frame, textContainer: .init())
        }
    #endif

    override private init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

// MARK: - Extensions

#if canImport(UIKit)

    public extension UniversalTextView2 {
        override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
            guard self.hasMenuEnabled else {
                return false
            }

            //        // Examples:
            //        switch action {
            //        case #selector(cut):
            //            return false
            //        case #selector(paste(_:)):
            //            return false
            //        case #selector(select):
            //            return false
            //        default:
            //            break
            //        }

            return super.canPerformAction(action, withSender: sender)
        }
    }

#endif
