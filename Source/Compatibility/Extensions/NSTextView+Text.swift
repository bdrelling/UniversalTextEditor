// Copyright © 2022 Brian Drelling. All rights reserved.

#if canImport(AppKit)

    import AppKit

    extension NSTextView {
        var text: String {
            get {
                self.string
            }
            set {
                self.string = newValue
            }
        }
    }

#endif
