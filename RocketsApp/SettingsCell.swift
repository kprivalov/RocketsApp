//
//  SettingsCell.swift
//  RocketsApp
//
//  Created by Kirill Privalov on 07.07.2022.
//

import UIKit

final class SettingsItemCell: UITableViewCell {
    private var settingLabel = UILabel()
    private var control = UISegmentedControl()
    private var settingType: SettingsModel.Settings?
    internal var onSaveSetting: ((String) -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: "SettingsCell")
        contentView.addSubview(settingLabel)
        contentView.addSubview(control)
        self.customizeControl()
        self.customizeSettingsLabel()
        self.setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.control.removeAllSegments()
    }
    
    private func customizeSettingsLabel() {
        settingLabel.textColor = .white
    }
    
    private func customizeControl() {
        control.layer.backgroundColor = UIColor(red: 0.129, green: 0.129, blue: 0.129, alpha: 1).cgColor
        control.layer.cornerRadius = 7.8
        let font = UIFont.systemFont(ofSize: 14)
        control.setTitleTextAttributes([.foregroundColor: UIColor(red: 0.557, green: 0.557, blue: 0.561, alpha: 1),
                                        .font: font], for: .normal)
        control.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(red: 0.071, green: 0.071, blue: 0.071, alpha: 1)], for: UIControl.State.selected)
        control.addAction(UIAction { _ in
            self.saveSetting()
        }, for: .valueChanged)
    }
    
    private func saveSetting() {
        guard let title = control.titleForSegment(at: control.selectedSegmentIndex) else { return }
        onSaveSetting?(title)
    }
    
    private func setConstraints() {
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
}

// MARK: - updateCell

extension SettingsItemCell {
    func updateCell(setting: SettingsModel.Setting) {
        guard let defaultValue = setting.defaultValue, let index = setting.units.firstIndex(of: defaultValue) else { return }
        self.settingLabel.text = setting.name
        self.settingType = setting.type
        for (index, element) in setting.units.enumerated() {
            self.control.insertSegment(withTitle: element, at: index, animated: true)
        }
        self.control.selectedSegmentIndex = index
    }
}
