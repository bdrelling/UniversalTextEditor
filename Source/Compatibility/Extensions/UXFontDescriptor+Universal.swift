// Copyright © 2022 Brian Drelling. All rights reserved.

extension UXFontDescriptor {
    #if canImport(AppKit)
        static func preferredFontDescriptor(withTextStyle textStyle: UXFont.TextStyle) -> UXFontDescriptor {
            self.preferredFontDescriptor(forTextStyle: textStyle)
        }
    #endif
}

extension UXFontDescriptor.SymbolicTraits {
    static var universalBold: Self {
        #if canImport(AppKit)
            return .bold
        #elseif canImport(UIKit)
            return .traitBold
        #endif
    }

    static var universalItalic: Self {
        #if canImport(AppKit)
            return .italic
        #elseif canImport(UIKit)
            return .traitItalic
        #endif
    }
}
