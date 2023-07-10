//
//  SnackListViewViewController.swift
//  FatBoss
//
//  Created by 12345 on 26.06.2023.
//

import UIKit

protocol SomeProtocolDelegate {
    func someMethod()
}

protocol SnackListViewInput {
    var snackListViewOutput: SnackListViewOutput? { get set }
    var userAccount: UserEntity? { get set }
    func updateSnackList(snacksByDate: [SnackByDate]?)
    func fillWithUserAccount(account: UserEntity)
}

protocol SnackListViewOutput {
    func showAddProductWindow()
    func deleteSnack(id: Int)
    func getUserAccountData(userAccount: UserEntity)
    func moveBack()
}

final class SnackListView: BaseView, SnackListViewInput {
    
    @IBOutlet private weak var extiButtonImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var topBackgroundView: UIView!
    @IBOutlet private weak var snackListTableView: UITableView!
    @IBOutlet private weak var addProductButton: UIButton!
    
    private let snackTableViewRowHeight: CGFloat = 80
    private let snackTableViewHeaderHeight: CGFloat = 40
    var snackListViewOutput: SnackListViewOutput?
    var userAccount: UserEntity?
    var snacksByDate = [SnackByDate]() {
        didSet {
            snackListTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupButtonStyle()
        setupNavigationItems()
        snackListViewOutput?.getUserAccountData(userAccount: userAccount ?? UserEntity(firstName: "Unknown",
                                                                                       lastName: "User"))
    }
    
    private func setupTableView() {
        snackListTableView.clipsToBounds = true
        snackListTableView.layer.cornerRadius = 10
        snackListTableView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        snackListTableView.delegate = self
        snackListTableView.dataSource = self
        snackListTableView.register(SnackListTableViewCell.nib,
                                    forCellReuseIdentifier: SnackListTableViewCell.reusebleIdentifier)
    }
    
    
    private func createTableViewHeader(tableView: UITableView, section: Int) -> UIView {
        let headerCell = tableView.dequeueReusableCell(withIdentifier: SnackListTableViewCell.reusebleIdentifier) as! SnackListTableViewCell
        headerCell.fillHeaderWith(dayString: snacksByDate[section].date,
                                  totalPrice: snacksByDate[section].totalPrice)
        return headerCell
    }
    
    private func setupButtonStyle() {
        let cornerRadius = addProductButton.frame.height / 2
        var configuration = UIButton.Configuration.filled()
        var container = AttributeContainer()
        container.font = Constants.Fonts.montseratBoldText
        configuration.attributedTitle = AttributedString("Add Product", attributes: container)
        configuration.image = UIImage(systemName: "plus")?.withTintColor(Constants.Colors.orange)
        configuration.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(weight: .bold)
        configuration.imagePadding = 5
        configuration.baseBackgroundColor = Constants.Colors.background
        configuration.baseForegroundColor = Constants.Colors.orange
        configuration.background.cornerRadius = cornerRadius
        addProductButton.layer.cornerRadius = cornerRadius
        addProductButton.configuration = configuration
        addProductButton.layer.borderColor = Constants.Colors.orange.cgColor
        addProductButton.layer.borderWidth = 2
    }
    
    private func setupNavigationItems() {
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(pressExit))
        extiButtonImageView.gestureRecognizers = [recognizer]
        extiButtonImageView.isUserInteractionEnabled = true
    }
    
    @objc private func pressExit() {
        snackListViewOutput?.moveBack()
    }
    
    func fillWithUserAccount(account: UserEntity) {
        self.titleLabel.text = "\(account.firstName) \(account.lastName)"
    }
    
    func updateSnackList(snacksByDate: [SnackByDate]?) {
        guard let snacksByDate else { return }
        self.snacksByDate = snacksByDate
    }
    
    private func createSwipeToDeleteAction(indexPath: IndexPath) -> UISwipeActionsConfiguration {
        let delete = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (action, sourceView, completionHandler) in
            if let id = self?.snacksByDate[indexPath.section].snacks[indexPath.row].id {
                self?.snackListViewOutput?.deleteSnack(id: id)
            }
            completionHandler(true)
        }
        let swipeActionConfig = UISwipeActionsConfiguration(actions: [delete])
        swipeActionConfig.performsFirstActionWithFullSwipe = false
        return swipeActionConfig
    }
    
    @IBAction private func addProductAction(_ sender: Any) {
        snackListViewOutput?.showAddProductWindow()
    }
}

extension SnackListView: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        snacksByDate.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        snacksByDate[section].snacks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SnackListTableViewCell.reusebleIdentifier, for: indexPath) as! SnackListTableViewCell
        
        cell.fillCellWith(item: snacksByDate[indexPath.section].snacks[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        snackTableViewRowHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        createTableViewHeader(tableView: tableView, section: section)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        snackTableViewHeaderHeight
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        createSwipeToDeleteAction(indexPath: indexPath)
    }
}

extension SnackListView: LoadingIndicatorProtocol {
    func show() {
        startLoading()
    }
    
    func hide() {
        stopLoading()
    }
}
