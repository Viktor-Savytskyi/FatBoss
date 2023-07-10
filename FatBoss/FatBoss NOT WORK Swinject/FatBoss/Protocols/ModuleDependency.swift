//
//  ModuleDependency.swift
//  FatBoss
//
//  Created by Developer on 06.07.2023.
//

import Foundation
import Swinject

protocol ModuleDependency {
    init(container: Container)
    func createDependensies(container: Container)
    func injectDependinsies(container: Container)
}
