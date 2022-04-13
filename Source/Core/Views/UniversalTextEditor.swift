// Copyright © 2022 Brian Drelling. All rights reserved.

import SwiftUI

public struct UniversalTextEditor: View {
    public typealias DisplayMode = UniversalTextView.DisplayMode
    public typealias Theme = UniversalTextView.Theme
    
    @Binding var text: NSAttributedString
    @Binding private var displayMode: DisplayMode
    @Binding private var theme: Theme

    public var body: some View {
        UniversalTextViewRepresentable(text: self.$text, displayMode: self.$displayMode, theme: self.$theme)
            .background(.blue)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    public init(
        text: Binding<NSAttributedString>,
        displayMode: Binding<DisplayMode> = .constant(.stylizedMarkdown),
        theme: Binding<Theme> = .constant(.default)
    ) {
        self._text = text
        self._displayMode = displayMode
        self._theme = theme
    }

    public init(
        text: Binding<String>,
        displayMode: Binding<DisplayMode> = .constant(.stylizedMarkdown),
        theme: Binding<Theme> = .constant(.default)
    ) {
        self._displayMode = displayMode
        self._theme = theme

        self._text = .init(
            get: {
                .init(string: text.wrappedValue)
            }, set: {
                text.wrappedValue = $0.string
            }
        )
    }

    public init(
        text: Binding<String>,
        displayMode: DisplayMode = .stylizedMarkdown,
        theme: Theme = .default
    ) {
        self.init(text: text, displayMode: .constant(displayMode), theme: .constant(theme))
    }
}

// MARK: - Previews

struct UniversalTextEditor_Previews: PreviewProvider {
    private static let warningMessage = """
    Please note that UITextViews or NSTextViews running in previews within
    the SwiftUI canvas (iOS) or XCPreviewAgent (macOS) are prone to quirky behaviors.

    For example, bolding text that is partially bold on a real device will bold all the text, as expected,
    but bolding text that is partially bold on a preview view will reset all the text to un-bold.
    """

    static var previews: some View {
        ForEach(UniversalTextView.DisplayMode.allCases, id: \.self) { mode in
            UniversalTextEditor(text: .constant(self.warningMessage), displayMode: mode)
        }
    }
}
