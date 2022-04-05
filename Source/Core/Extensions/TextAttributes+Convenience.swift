// Copyright © 2022 Brian Drelling. All rights reserved.

import Foundation

public typealias TextAttributes = [NSAttributedString.Key: Any]

extension TextAttributes {
    static var displayExcluded: Self = [
        .displayType: DisplayType.excluded,
    ]
}
