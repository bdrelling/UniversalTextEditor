// Copyright © 2022 Brian Drelling. All rights reserved.

public extension UniversalTextView {
    enum DisplayMode: String, CaseIterable {
        case plainText
        case stylizedMarkdown
        case stylizedHiddenMarkdown
        
        // TODO: Add a mode that will allow it to display as rendered. plainText currently resets attributes--we need one that ignores that.

        public static let `default`: Self = .stylizedMarkdown
    }
}
