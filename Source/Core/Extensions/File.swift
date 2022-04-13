// Copyright © 2022 Brian Drelling. All rights reserved.

import Foundation
import SwiftUI

extension NSTextStorage {
    var attributedText: NSAttributedString {
        get {
            self
        }
        set {
            self.replaceCharacters(
                in: NSMakeRange(0, self.length),
                with: newValue
            )
        }
    }
}
