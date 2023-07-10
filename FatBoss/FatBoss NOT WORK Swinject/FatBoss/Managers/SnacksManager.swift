//
//  SnacksManager.swift
//  FatBoss
//
//  Created by 12345 on 28.06.2023.
//

import UIKit
import RealmSwift

enum RuntimeError: Error {
    case NoRealmSet
}

protocol DidUpdateSnacksProtocol {
    func snacksDidUpdate()
}

protocol SnacksManagerProtocol {
    var snackManagerDelegate: DidUpdateSnacksProtocol? { get set }
    func addObserver()
    func getObjects() throws -> Results<SnackModel>
    func fetchSnackList(completion: @escaping ((Results<SnackModel>) -> Void))
    func removeSnack(id: Int) throws
    func save(snack: SnackModel) throws
}

final class SnacksManager: SnacksManagerProtocol {
    
    private var snacks: Results<SnackModel>?
    private let realm = try? Realm()
    private var notificationToken: NotificationToken?
    var snackManagerDelegate: DidUpdateSnacksProtocol?

    init() {
        addObserver()
    }
    
    func addObserver() {
        notificationToken = realm?.objects(SnackModel.self).observe() { [weak self] (changes: RealmCollectionChange) in
            switch changes {
            case .initial:
                self?.snackManagerDelegate?.snacksDidUpdate()
            case .update(_, _, _, _):
                self?.snackManagerDelegate?.snacksDidUpdate()
            case .error(let error):
                print("Error: \(error)")
                break
            }
        }
    }
    
    func getObjects() throws -> Results<SnackModel> {
        if let realm {
            let realmResults = realm.objects(SnackModel.self)
            return realmResults
        } else {
            throw RuntimeError.NoRealmSet
        }
    }
    
    func fetchSnackList(completion: @escaping ((Results<SnackModel>) -> Void)) {
        do {
            snacks = try getObjects()
        } catch {
            print(error)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            guard let self,
                  let snacks = self.snacks else { return }
            completion(snacks)
        }
    }
    
    func removeSnack(id: Int) throws {
        if let realm, let snack = realm.object(ofType: SnackModel.self, forPrimaryKey: id){
            try realm.write {
                realm.delete(snack)
            }
        } else {
            throw RuntimeError.NoRealmSet
        }
    }
    
    func save(snack: SnackModel) throws {
        try realm?.write {
            realm?.add(snack)
        }
    }
}
