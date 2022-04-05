// Copyright © 2022 Brian Drelling. All rights reserved.

import Down
import SwiftUI

#if DEBUG
import Combine
#endif

open class UniversalTextView2: UXTextView {
    public typealias DisplayMode = UniversalTextView.DisplayMode
    
    @available(*, unavailable)
    open override var layoutManager: NSLayoutManager? {
        return nil
    }

    public private(set) var hasMenuEnabled: Bool = true
    
    #if DEBUG
    private var subscriptions = Set<AnyCancellable>()
    #endif

    private let keyboardShortcuts: [KeyboardShortcut] = [
        .init(characters: "b", modifierFlags: [.command], action: #selector(toggleSelectionBold)),
        .init(characters: "i", modifierFlags: [.command], action: #selector(toggleSelectionItalics)),
        .init(characters: "u", modifierFlags: [.command], action: #selector(toggleSelectionUnderline)),
    ]

    public convenience init(frame: CGRect, displayMode: DisplayMode) {
        switch displayMode {
        case .plainText:
            self.init(frame: frame)
        case .stylizedMarkdown, .stylizedHiddenMarkdown:
            let textContainer = NSTextContainer()
            textContainer.widthTracksTextView = true
            textContainer.heightTracksTextView = true
            
            let textLayoutManager = MarkdownTextLayoutManager()
            textLayoutManager.textContainer = textContainer
            
            let textContentStorage = MarkdownTextContentStorage()
            textContentStorage.addTextLayoutManager(textLayoutManager)

            self.init(frame: frame, textContainer: textContainer)
        }
        
        #if DEBUG
        NotificationCenter.default.publisher(for: NSTextView.didSwitchToNSLayoutManagerNotification)
            .sink { notification in
                print("Did switch to TextKit 1!")
            }
            .store(in: &self.subscriptions)
        #endif
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
