import SwiftUI

final class MarkdownTextLayoutManager: NSTextLayoutManager {
    override init() {
        super.init()
        
        self.delegate = self
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension MarkdownTextLayoutManager: NSTextLayoutManagerDelegate {
//    func textLayoutManager(_ textLayoutManager: NSTextLayoutManager, textLayoutFragmentFor location: NSTextLocation, in textElement: NSTextElement) -> NSTextLayoutFragment { }
//    
//    func textLayoutManager(_ textLayoutManager: NSTextLayoutManager, shouldBreakLineBefore location: NSTextLocation, hyphenating: Bool) -> Bool { }
//
//    func textLayoutManager(_ textLayoutManager: NSTextLayoutManager, renderingAttributesForLink link: Any, at location: NSTextLocation, defaultAttributes renderingAttributes: [NSAttributedString.Key : Any] = [:]) -> [NSAttributedString.Key : Any]? { }
}
