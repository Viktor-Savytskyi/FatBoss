//
//  KeyChainManagerTests.swift
//  FatBossTests
//
//  Created by 12345 on 03.07.2023.
//

import XCTest
@testable import FatBoss

final class KeyChainManagerTests: XCTestCase {
    var sut: KeyChainManager!
    var user: UserEntity!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = KeyChainManager()
        user = UserEntity(firstName: "viktor123", lastName: "viktor123")
    }
    
    override func tearDownWithError() throws {
        sut = nil
        user = nil
        try super.tearDownWithError()
    }
    
    //is user Dont exist - set new User
    //    func testCreateNewUserAccount() {
    //        XCTAssertNotNil(keyChainManager.create(userAccount: user), "account isnt nill!")
    //    }
    //
    
    func testCreatExistedUser() {
        XCTAssertNotNil(sut.create(userAccount: user), "user account existed!")
    }
    
    
    func testGetUserAccount() {
        let retrivedAccount = sut.get(userAccount: user)
        XCTAssertNotNil(retrivedAccount, "user account not existed!")
        XCTAssertEqual(retrivedAccount?.firstName, user.firstName, "first name is not the same")
        XCTAssertEqual(retrivedAccount?.lastName, user.lastName, "last name is not the same")
    }
    
    func testGetNotExistedAccount() {
        XCTAssertNil(sut.get(userAccount: UserEntity(firstName: "nnn", lastName: "nnn")), "account not exist")
    }
}
