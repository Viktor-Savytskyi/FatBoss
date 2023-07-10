//
//  Extension+DateFormatter.swift
//  FatBoss
//
//  Created by 12345 on 03.07.2023.
//

import Foundation

enum DateFormat {
    case dMMMyyyy
    case ddMMMMyyyy
    case ddMMMM
    
    var stringFormat: String {
        switch self {
        case .dMMMyyyy:
           return "d MMM yyyy"
        case .ddMMMMyyyy:
            return "dd MMMM yyyy"
        case .ddMMMM:
            return "dd MMMM"
        }
    }
}

extension DateFormatter {
    static func setDateFormat(dateFormat: DateFormat) -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat.stringFormat
        return dateFormatter
    }
}
