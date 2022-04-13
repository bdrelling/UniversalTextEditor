// Copyright © 2022 Brian Drelling. All rights reserved.

import Down
import SwiftUI

open class UniversalTextView: UXTextView {
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
        let textContainer = NSTextContainer()
        textContainer.widthTracksTextView = true
        textContainer.heightTracksTextView = true

        let layoutManager = MarkdownLayoutManager(displayMode: displayMode, theme: theme)
        layoutManager.addTextContainer(textContainer)

        let textStorage = MarkdownTextStorage(displayMode: displayMode, theme: theme)
        textStorage.addLayoutManager(layoutManager)

        self.init(frame: frame, textContainer: textContainer)
        
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

    public extension UniversalTextView {
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

// MARK: - Previews

struct UniversalTextView_Previews: PreviewProvider {
    private static let data = [
        "**Strong!**",
        "_Emphasis_",
        "~~Strikethrough~~",
        "# Heading 1",
        "## Heading 2",
        "### Heading 3",
        "#### Heading 4",
        "##### Heading 5",
        "###### Heading 6",
    ]
    
    static var previews: some View {
        ForEach(self.data, id: \.self) { markdown in
            HStack {
                self.textView(markdown: markdown)
                self.downView(markdown: markdown)
            }
            .frame(maxWidth: .infinity, maxHeight: 100)
            .previewLayout(.sizeThatFits)
        }
    }
    
    private static func textView(markdown: String) -> PreviewTextView {
        let textView = UniversalTextView(displayMode: .stylizedMarkdown)
        textView.text = markdown
        
        return .init(textView)
    }
    
    private static func downView(markdown: String) -> PreviewTextView {
        let textView = UXTextView(frame: .zero)
        textView.font = UniversalTextView.Theme.default.fonts.body
        
        do {
            textView.textStorage?.attributedText = try Down(markdownString: markdown).toAttributedString()
        } catch {
            textView.text = "Error rendering DownView for markdown string: \(markdown)"
        }
        
        return .init(textView)
    }
}


