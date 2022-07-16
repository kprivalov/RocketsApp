//
//  SettingsScreenController.swift
//  RocketsApp
//
//  Created by Kirill Privalov on 02.07.2022.
//

import Foundation
import UIKit

// MARK: - SettingsTableView

final class SettingsTableViewController: UITableViewController {
    private lazy var dismissButton = UIBarButtonItem(title: "Закрыть",
                                                     primaryAction: UIAction { [weak self] _ in
        self?.dismiss(animated: true)
    })
    private var navTitle = UILabel()
    private let presenter = SettingsPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.customizeTableView()
        self.customizeNavigationItems()
        tableView.register(SettingsItemCell.self, forCellReuseIdentifier: "SettingsCell")
    }
    
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        presenter.settingsCount
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath) as! SettingsItemCell
        let setting = presenter.getSettingsTypeByIndex(indexPath.row)
        cell.selectionStyle = .none
        cell.backgroundColor = self.view.backgroundColor
        cell.updateCell(type: setting.type,
                        name: setting.name,
                        segments: setting.units,
                        defaultValue: setting.defaultValue)

        return cell
    }
    
    private func customizeTableView() {
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        let inset = UIEdgeInsets(top: 60, left: 0, bottom: 0, right: 0)
        self.tableView.contentInset = inset
        view.backgroundColor = UIColor(red: 0.071, green: 0.071, blue: 0.071, alpha: 1)
    }
    
    private func customizeNavigationItems() {
        self.navigationItem.setRightBarButton(dismissButton, animated: false)
        self.navTitle.text = "Настройки"
        self.navTitle.textColor = .white
        self.navigationItem.titleView = navTitle
        let attributes: [NSAttributedString.Key : Any] = [.font: UIFont.boldSystemFont(ofSize: 16), .foregroundColor: UIColor.white]
        dismissButton.setTitleTextAttributes(attributes, for: .normal)
    }
}
