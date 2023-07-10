//
//  SnackModel.swift
//  FatBoss
//
//  Created by 12345 on 27.06.2023.
//

import Foundation
import RealmSwift

final class SnackModel: Object {
    
    @objc dynamic var id: Int = UUID().hashValue
    @objc dynamic var price: Int = 0
    @objc dynamic var productName: String = ""
    @objc dynamic var date: Date = Date()
        
    override class func primaryKey() -> String? {
        return "id"
    }
}
