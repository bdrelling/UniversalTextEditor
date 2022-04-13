// Copyright © 2022 Brian Drelling. All rights reserved.

import SwiftUI

public struct UniversalTextEditor: View {
    @Binding private var displayMode: UniversalTextView.DisplayMode
    @Binding var text: NSAttributedString

    public var body: some View {
        UniversalTextViewRepresentable(displayMode: self.$displayMode, text: self.$text)
            .background(.blue)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    public init(displayMode: Binding<UniversalTextView.DisplayMode>, text: Binding<NSAttributedString>) {
        self._displayMode = displayMode
        self._text = text
    }

    public init(displayMode: Binding<UniversalTextView.DisplayMode>, text: Binding<String>) {
        self._displayMode = displayMode

        self._text = .init(
            get: {
                .init(string: text.wrappedValue)
            }, set: {
                text.wrappedValue = $0.string
            }
        )
    }

    public init(displayMode: UniversalTextView.DisplayMode, text: Binding<String>) {
        self.init(displayMode: .constant(displayMode), text: text)
    }

    public init(text: Binding<String>) {
        self.init(displayMode: .plainText, text: text)
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
            UniversalTextEditor(displayMode: mode, text: .constant(self.warningMessage))
        }
    }
}
