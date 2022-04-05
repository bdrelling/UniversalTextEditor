import SwiftUI

final class MarkdownTextContentManager: NSTextContentManager {
    override init() {
        super.init()
        
        self.delegate = self
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension MarkdownTextContentManager: NSTextContentManagerDelegate {
    func textContentManager(_ textContentManager: NSTextContentManager,
                            shouldEnumerate textElement: NSTextElement,
                            options: NSTextContentManager.EnumerationOptions) -> Bool {
//        // The text content manager calls this method to determine whether each text element should be enumerated for layout.
//        // To hide comments, tell the text content manager not to enumerate this element if it's a comment.
//        if !showComments {
//            if let paragraph = textElement as? NSTextParagraph {
//                let commentDepthValue = paragraph.attributedString.attribute(.commentDepth, at: 0, effectiveRange: nil)
//                if commentDepthValue != nil {
//                    return false
//                }
//            }
//        }
        return true
    }
}
