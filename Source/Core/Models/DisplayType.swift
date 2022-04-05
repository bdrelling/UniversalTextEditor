// Copyright © 2022 Brian Drelling. All rights reserved.

import Foundation

enum DisplayType {
    case excluded
}

extension NSAttributedString.Key {
    static let displayType = NSAttributedString.Key(rawValue: "displayType")
}
