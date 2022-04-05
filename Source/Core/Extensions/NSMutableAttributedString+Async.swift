// Copyright © 2022 Brian Drelling. All rights reserved.

import Foundation

extension NSAttributedString {
    public typealias AttributeEnumerationResult = (value: Any?, range: NSRange)
    public typealias AttributesEnumerationResult = (values: [Key: Any], range: NSRange)

    open func enumerateAttribute(
        _ attrName: NSAttributedString.Key,
        in enumerationRange: NSRange,
        options: NSAttributedString.EnumerationOptions = []
    ) async -> [AttributeEnumerationResult] {
        await withCheckedContinuation { continuation in
            // Source: https://www.biteinteractive.com/swift-5-5-asynchronous-looping-with-async-await/
            let group = DispatchGroup()
            var results: [AttributeEnumerationResult] = []

            self.enumerateAttribute(attrName, in: enumerationRange, options: options) { value, range, _ in
                group.enter()
                results.append((value, range))
                group.leave()
            }

            group.notify(queue: .main) {
                continuation.resume(returning: results)
            }
        }
    }

    open func enumerateAttributes(
        in enumerationRange: NSRange,
        options: NSAttributedString.EnumerationOptions = []
    ) async -> [AttributesEnumerationResult] {
        await withCheckedContinuation { continuation in
            // Source: https://www.biteinteractive.com/swift-5-5-asynchronous-looping-with-async-await/
            let group = DispatchGroup()
            var results: [AttributesEnumerationResult] = []

            self.enumerateAttributes(in: enumerationRange, options: options) { values, range, _ in
                group.enter()
                results.append((values, range))
                group.leave()
            }

            group.notify(queue: .main) {
                continuation.resume(returning: results)
            }
        }
    }
}
