//
//  SnackListTableViewCell.swift
//  FatBoss
//
//  Created by 12345 on 27.06.2023.
//

import UIKit

final class SnackListTableViewCell: UITableViewCell, StoryBoardebleCell {
    
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var itemNameLabel: UILabel!
    @IBOutlet private weak var itemPriceLabel: UILabel!
    @IBOutlet private weak var leftStackViewConstraint: NSLayoutConstraint!
    @IBOutlet private weak var rightStackViewConstraint: NSLayoutConstraint!
    
    let priceType = "uah"

    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = 8
        itemNameLabel.textColor = Constants.Colors.mainTextWithAlpha
    }
    
    func fillHeaderWith(dayString: String?, totalPrice: Int) {
        var dateFormatter = DateFormatter.setDateFormat(dateFormat: .ddMMMMyyyy)
        let dateFromString = dateFormatter.date(from: dayString ?? "")
        dateFormatter = DateFormatter.setDateFormat(dateFormat: .ddMMMM)
        let date = dateFormatter.string(from: dateFromString ?? Date())
        containerView.backgroundColor = .clear
        itemNameLabel.font = Constants.Fonts.montseratRegularText
        itemNameLabel.text = date.lowercased()
        itemPriceLabel.textColor = Constants.Colors.mainTextWithAlpha
        itemPriceLabel.font = Constants.Fonts.montseratPlaceholder
        let priceString = "\(totalPrice) \(priceType)"
                    itemPriceLabel.setupFontAttributesForText(title: "Total: \(priceString)",
                                                              textForchange: [priceString],
                                                              anotherColor: Constants.Colors.green)
        changeStackViewConstraints()
    }
    
    func fillCellWith(item: SnackModel) {
            containerView.backgroundColor = Constants.Colors.lightGreen
            itemNameLabel.font = Constants.Fonts.montseratBoldText
            itemNameLabel.text = item.productName
            itemPriceLabel.textColor = Constants.Colors.green
            itemPriceLabel.font = Constants.Fonts.montseratLargeLabelTitle
            itemPriceLabel.setupFontAttributesForText(title: "\(item.price) \(priceType)",
                                                      textForchange: [priceType],
                                                      anotherFont: Constants.Fonts.montseratBoldText,
                                                      anotherColor: Constants.Colors.green)
    }
    
    func changeStackViewConstraints() {
        leftStackViewConstraint.constant = 0
        rightStackViewConstraint.constant = 0
        layoutIfNeeded()
    }
}
