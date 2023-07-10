//
//  SnackListPresenter.swift
//  FatBoss
//
//  Created by 12345 on 27.06.2023.
//

import Foundation

//protocol SnackListPresenterInput {
//    var snackListPresenterOutput: SnackListPresenterOutput? { get set }
//}
//
//protocol SnackListPresenterOutput {
//    func deleteSnack(id: Int)
//    func getUserAccountData(userAccount: UserEntity)
//    func moveBack()
//}

final class SnackListPresenter {
    
    var view: SnackListViewInput
    var interactor: SnackListInteractorInput
    var router: SnackListRouterInput
    
    init(view: SnackListViewInput,
         interactor: SnackListInteractorInput,
         router: SnackListRouterInput,
         userAccount: UserEntity) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.view.userAccount = userAccount
    }
    
    private func makeSectionsItemsFromSnacks(snackList: [SnackModel]) -> [SnackByDate] {
        var snackByDate = [SnackByDate]()
        let dateFormatter = DateFormatter.setDateFormat(dateFormat: .ddMMMMyyyy)
        let uniqueDates = Set(snackList.map { $0.date.timeIntervalSince1970 }).sorted(by: <)
        let sortedSectionDates = uniqueDates.map { Date(timeIntervalSince1970: $0) }.map({ dateFormatter.string(from: $0) })
        for date in sortedSectionDates {
            var daytedSnack = SnackByDate(date: date, snacks: [])
            snackList.forEach { snack in
                let snackDate = dateFormatter.string(from: snack.date)
                if snackDate == date  {
                    daytedSnack.snacks.append(snack)
                }
            }
            daytedSnack.totalPrice = daytedSnack.snacks.map { $0.price }.reduce(0, +)
            snackByDate.append(daytedSnack)
        }
        return snackByDate
    }
}

extension SnackListPresenter: SnackListViewOutput {
    func showAddProductWindow() {
        router.showPopupScreen()
    }
    
    func moveBack() {
        router.moveBack()
    }
    
    func getUserAccountData(userAccount: UserEntity) {
        interactor.getKeyChainUserAccount(userAccount: userAccount)
    }
    
    func deleteSnack(id: Int) {
        interactor.deleteSnack(id: id)
    }
}

extension SnackListPresenter: SnackListInteractorOutput {
    func returnUserAccount(userAccount: UserEntity) {
        view.fillWithUserAccount(account: userAccount)
    }
    
    func returnSnackList(snacks: [SnackModel]?){
        if let snacks {
            view.updateSnackList(snacksByDate: makeSectionsItemsFromSnacks(snackList: snacks))
        } else {
            print("no snacks existed")
        }
    }
}
