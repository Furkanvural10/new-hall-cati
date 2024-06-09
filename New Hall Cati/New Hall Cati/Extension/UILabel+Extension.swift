//
//  UILabel+Extension.swift
//  New Hall Cati
//
//  Created by Emirhan İpek on 10.06.2024.
//

import UIKit

extension UILabel {
    func setUnderlinedText(_ text: String) {
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: text.count))
        self.attributedText = attributedString
    }
}
