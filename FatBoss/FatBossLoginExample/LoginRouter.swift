//
//  LoginRouter.swift
//  EkreativeSnacks
//
//  Created by Oleksand Atamanskyi on 10/28/19.
//  Copyright © 2019 Oleksand Atamanskyi. All rights reserved.
//

import Foundation

final class LoginRouter {
    private let router: Router
    
    init(router: Router) {
        self.router = router
    }
    
    func showSnacks() {
        router.present(route: .snacks)
    }
}
