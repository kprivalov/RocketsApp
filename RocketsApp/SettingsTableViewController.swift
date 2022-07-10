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
    private var model = SettingsModel()
    
    override init(style: UITableView.Style = .plain) {
        super.init(style: style)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        let inset = UIEdgeInsets(top: 60, left: 0, bottom: 0, right: 0)
        self.tableView.contentInset = inset
        view.backgroundColor = UIColor(red: 0.071, green: 0.071, blue: 0.071, alpha: 1)
        tableView.visibleCells.forEach {
          $0.backgroundColor = UIColor(red: 0.071, green: 0.071, blue: 0.071, alpha: 1)
        }
        self.customizeNavigationItems()
        super.viewDidLoad()
        tableView.register(SettingsItemCell.self, forCellReuseIdentifier: "SettingsCell")
    }
    
    func customizeNavigationItems() {
        self.navigationItem.setRightBarButton(dismissButton, animated: false)
        self.navTitle.text = "Настройки"
        self.navTitle.textColor = .white
        self.navigationItem.titleView = navTitle
        let attributes: [NSAttributedString.Key : Any] = [.font: UIFont.boldSystemFont(ofSize: 16), .foregroundColor: UIColor.white]
        dismissButton.setTitleTextAttributes(attributes, for: .normal)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        model.settingsArray.count
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath) as! SettingsItemCell
        cell.selectionStyle = .none
        cell.updateCell(type: model.settingsArray[indexPath.row].type,
                        name: model.settingsArray[indexPath.row].name,
                        segments: model.settingsArray[indexPath.row].units,
                        defaultValue: model.settingsArray[indexPath.row].defaultValue)
        return cell
    }
}
