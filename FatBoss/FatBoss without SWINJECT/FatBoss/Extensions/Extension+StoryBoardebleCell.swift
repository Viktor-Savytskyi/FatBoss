//
//  Extension+CollectionViewCell.swift
//  FatBoss
//
//  Created by 12345 on 27.06.2023.
//

import UIKit

protocol StoryBoardebleCell {
    static var reusebleIdentifier: String { get }
    static var nib: UINib { get }
}

extension StoryBoardebleCell {
    static var reusebleIdentifier: String { String(describing: self) }
    static var nib: UINib { UINib(nibName: String(describing: self), bundle: nil) }
}
