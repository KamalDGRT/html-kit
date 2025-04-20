//
// NSAttributedString.swift
// HTMLKit
//

import UIKit

extension NSAttributedString {
    func updateParagraphStyle(
        alignment: NSTextAlignment,
        lineSpacing: CGFloat
    ) -> NSAttributedString {
        let mutableString = NSMutableAttributedString(attributedString: self)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = alignment
        paragraphStyle.lineSpacing = lineSpacing
        
        let fullRange = NSRange(location: 0, length: mutableString.length)
        mutableString.addAttribute(.paragraphStyle, value: paragraphStyle, range: fullRange)
        
        return mutableString
    }
}
