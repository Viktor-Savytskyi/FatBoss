//
//  AccountManager.swift
//  FatBoss
//
//  Created by 12345 on 03.07.2023.
//

import Foundation

enum ValidationError: Error {
    case firstNameError
    case lastNameError
    case productDateError
    case productNameError
    case productPriceError
    
    var description: String {
        switch self {
        case .firstNameError:
            return "first name validation error"
        case .lastNameError:
            return "first name validation error"
        case .productDateError:
            return "product date validation error"
        case .productNameError:
            return "product name validation error"
        case .productPriceError:
            return "product price validation error"
        }
    }
}

protocol AccountManagerProtocol {
    func validateUser(firstName: String?, lastName: String?) throws
}

final class AccountManager: AccountManagerProtocol {
    
    private let mockUser = UserEntity(firstName: "viktor123", lastName: "viktor123")
    private var errorType: ValidationError = .firstNameError
    
    func validateUser(firstName: String?, lastName: String?) throws {
        guard firstName == mockUser.firstName else { throw ValidationError.firstNameError }
        guard lastName == mockUser.lastName   else { throw ValidationError.lastNameError }
    }
}
