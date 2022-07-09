//
//  SettingsScreenController.swift
//  RocketsApp
//
//  Created by Kirill Privalov on 02.07.2022.
//

import Foundation
import UIKit

class SettingsTableView: UITableViewController {
    override init(style: UITableView.Style = .plain) {
        super.init(style: style)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .black
        super.viewDidLoad()
        tableView.register(SettingsItemCell.self, forCellReuseIdentifier: "String")
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        4
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "String", for: indexPath) as! SettingsItemCell
        cell.selectionStyle = .none
        return cell
    }
}

// MARK: - Adding footer

class SettingsItemCell: UITableViewCell {
    lazy var settingsName = UILabel()
    let segments = ["m", "ft"]
    lazy var control = UISegmentedControl(items: segments)
    
    func customiseSettingsLabel() {
        
    }
    
    func customiseControl() {
        control.layer.backgroundColor = UIColor(red: 0.129, green: 0.129, blue: 0.129, alpha: 1).cgColor
        control.layer.cornerRadius = 7.8
        let font = UIFont.systemFont(ofSize: 14)
        control.setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)
        control.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(red: 0.557, green: 0.557, blue: 0.561, alpha: 1)], for: UIControl.State.normal)
        control.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(red: 0.071, green: 0.071, blue: 0.071, alpha: 1)], for: UIControl.State.selected)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: "String")
        settingsName.text = "SomeText"
        settingsName.textColor = .white
        self.customiseControl()

        contentView.addSubview(settingsName)
        contentView.addSubview(control)
        control.translatesAutoresizingMaskIntoConstraints = false
        settingsName.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(equalToConstant: 64),
            control.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            control.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -31),
            control.widthAnchor.constraint(equalToConstant: 115),
            control.heightAnchor.constraint(equalToConstant: 40),
            settingsName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 28),
            settingsName.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
                ])
        self.control.selectedSegmentIndex = self.segments.firstIndex(of: "m")!
        self.backgroundColor = .black
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override func setSelected(_ selected: Bool, animated: B   ool) {
//         super.setSelected(selected, animated: animated)
//
//         if selected {
//             contentView.backgroundColor = .black
//         } else {
//             contentView.backgroundColor = .black
//         }
//     }
}

class SectionFooter: UITableViewHeaderFooterView {
    static let reuseIdentifier: String = String(describing: SectionFooter.self)
    
    var label = UILabel()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
