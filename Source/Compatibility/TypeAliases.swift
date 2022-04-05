// Copyright © 2022 Brian Drelling. All rights reserved.

import SwiftUI

#if canImport(AppKit)
    public typealias UXColor = NSColor
    public typealias UXFont = NSFont
    public typealias UXFontDescriptor = NSFontDescriptor
    public typealias UXTextView = NSTextView
    public typealias UXTextViewDelegate = NSTextViewDelegate
    public typealias UXView = NSView
    public typealias UXViewRepresentable = NSViewRepresentable
#elseif canImport(UIKit)
    public typealias UXColor = UIColor
    public typealias UXFont = UIFont
    public typealias UXFontDescriptor = UIFontDescriptor
    public typealias UXTextView = UITextView
    public typealias UXTextViewDelegate = UITextViewDelegate
    public typealias UXView = UIView
    public typealias UXViewRepresentable = UIViewRepresentable
#else
    #error("No valid UI library detected!")
#endif
