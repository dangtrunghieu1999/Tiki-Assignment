//
//  String+Extension.swift
//  Tiki-Assignment
//
//  Created by Kai on 06/07/2024.
//

import Foundation
import UIKit

extension String {
    func replace(_ target: String, withString: String) -> String {
        return self.replacingOccurrences(of: target, with: withString, options: NSString.CompareOptions.literal, range: nil)
    }
}

public extension Optional where Wrapped == String {
    var orEmpty: String {
        switch self {
        case .some(let value):
            return String(describing: value)
        default:
            return ""
        }
    }
}

extension String {
    func widthForTwoLines(font: UIFont, padding: CGFloat = 16) -> CGFloat {
        // Get the height of two lines
        let twoLineHeight = "1\n2".height(withConstrainedWidth: .greatestFiniteMagnitude, font: font)
        
        // Get the width of the string as a single line
        let oneLineWidth = self.width(withConstrainedHeight: .greatestFiniteMagnitude, font: font)
        
        // Start with 1/2 of the full width of the string
        var halfWidth: CGFloat = ceil(oneLineWidth * 0.5)
        
        // Get the height of the string constrained to half width
        var newHeight: CGFloat = self.height(withConstrainedWidth: halfWidth, font: font)
        
        // The string may still wrap onto a third line, so increase the width
        // until we only need two lines
        while newHeight > twoLineHeight {
            halfWidth += 8
            newHeight = self.height(withConstrainedWidth: halfWidth, font: font)
        }
        
        // Return the calculated width plus the padding
        return halfWidth + padding
    }

    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        return ceil(boundingBox.height)
    }

    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        return ceil(boundingBox.width)
    }
}

