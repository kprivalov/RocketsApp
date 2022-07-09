//
//  SettingsCell.swift
//  RocketsApp
//
//  Created by Kirill Privalov on 07.07.2022.
//

import UIKit

// MARK: - SettingsItemCell

class SettingsItemCell: UITableViewCell {
    lazy var settingLabel = UILabel()
    lazy var control = UISegmentedControl()
    var settingType: SettingsModel.Settings?
    let model = SettingsModel()
    
    func customizeSettingsLabel() {
        settingLabel.textColor = .white
    }
    
    func customizeControl() {
        control.layer.backgroundColor = UIColor(red: 0.129, green: 0.129, blue: 0.129, alpha: 1).cgColor
        control.layer.cornerRadius = 7.8
        let font = UIFont.systemFont(ofSize: 14)
        control.setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)
        control.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(red: 0.557, green: 0.557, blue: 0.561, alpha: 1)], for: UIControl.State.normal)
        control.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(red: 0.071, green: 0.071, blue: 0.071, alpha: 1)], for: UIControl.State.selected)
    }
    
    func saveSetting() {
        guard let type = settingType, let title = control.titleForSegment(at: control.selectedSegmentIndex) else { return }
        model.setSettingsValue(field: type, value: title)
    }
    
    func setConstraints() {
        control.translatesAutoresizingMaskIntoConstraints = false
        settingLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(equalToConstant: 64),
            control.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            control.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -31),
            control.widthAnchor.constraint(equalToConstant: 115),
            control.heightAnchor.constraint(equalToConstant: 40),
            settingLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 28),
            settingLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: "SettingsCell")
        self.backgroundColor = SettingsTableView().view.backgroundColor
        self.customizeControl()
        self.customizeSettingsLabel()
        contentView.addSubview(settingLabel)
        contentView.addSubview(control)
        self.setConstraints()
        self.control.addAction(UIAction { _ in
            self.saveSetting()
        }, for: .valueChanged)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - updateCell

extension SettingsItemCell {
    func updateCell(type: SettingsModel.Settings, name: String, segments: [String], defaultValue: String?) {
        guard let defaultValue = defaultValue, let index = segments.firstIndex(of: defaultValue) else { return }
        self.settingLabel.text = name
        self.settingType = type
        for (index, element) in segments.enumerated() {
            self.control.insertSegment(withTitle: element, at: index, animated: true)
        }
        self.control.selectedSegmentIndex = index
    }
}
