// Copyright © 2022 Brian Drelling. All rights reserved.

public extension UniversalTextView {
    enum DisplayMode: String, CaseIterable {
        case plainText
        case stylizedMarkdown
        case stylizedHiddenMarkdown

        public static let `default`: Self = .stylizedMarkdown
    }
}
