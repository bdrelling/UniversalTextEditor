// Copyright © 2022 Brian Drelling. All rights reserved.

import Foundation

#if canImport(UIKit)

    import UIKit

    final class MenuManager {
        private init() {}

        static func enableMenu(for textView: UXTextView & TextFormatting) {
            UIMenuController.shared.menuItems = [
                UIMenuItem(title: "Bold", action: #selector(textView.toggleSelectionBold)),
                UIMenuItem(title: "Italics", action: #selector(textView.toggleSelectionItalics)),
                UIMenuItem(title: "Underline", action: #selector(textView.toggleSelectionUnderline)),
            ]
        }

        static func disableMenu() {
            UIMenuController.shared.menuItems = nil
        }
    }

#endif
