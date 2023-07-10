//
//  Extension+UILabel.swift
//  FatBoss
//
//  Created by 12345 on 27.06.2023.
//

import UIKit

extension UILabel {
    func setupFontAttributesForText(title: String,
                                    textForchange: [String],
                                    anotherFont: UIFont = Constants.Fonts.montseratPlaceholder,
                                    anotherColor: UIColor = Constants.Colors.mainText) {
        let mainAttributedText =
        NSMutableAttributedString(string: title,
                                  attributes: [.foregroundColor: textColor ?? Constants.Colors.mainText,
                                               .font: font ?? Constants.Fonts.montseratPlaceholder])
        let attributes = [NSAttributedString.Key.font: anotherFont,
                          NSAttributedString.Key.foregroundColor: anotherColor]
        textForchange.forEach { subString in
            let range = (title as NSString).range(of: "\(subString)", options: .caseInsensitive)
            mainAttributedText.addAttributes(attributes, range: NSRange(location: range.location, length: range.length))
        }
        attributedText = mainAttributedText
    }
}
