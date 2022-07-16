//
//  SettingsPresenter.swift
//  RocketsApp
//
//  Created by Kirill Privalov on 11.07.2022.
//

import Foundation

protocol SettingsPresenterProtocol {
    var settingsCount: Int { get }
    var settingsArray: [SettingsModel.Setting] { get }
    func getSettingsTypeByIndex(_ index: Int) -> SettingsModel.Setting
    func setValueToStorage() -> Void
    var valueFromStorage: String? { get }
}

class SettingsPresenter: NSObject {
    var settingsCount: Int {
        return SettingsModel.Settings.allCases.count
    }
    
    private var settingsArray: [SettingsModel.Setting] {
        return SettingsModel.Settings.allCases.map { item in
            SettingsModel.Setting(type: item,
                                  name: item.setting.name,
                                  units: item.setting.segments,
                                  defaultValue: self.valueFromStorage(item))
        }
    }
    
    func getSettingsTypeByIndex(_ index: Int) -> SettingsModel.Setting {
        settingsArray[index]
    }
 
    func setValueToStorage(key: SettingsModel.Settings, _ value: String?) {
        switch key {
        case .height: UserDefaultsManager.shared.heightUnit = value
        case .diameter: UserDefaultsManager.shared.diameterUnit = value
        case .mass: UserDefaultsManager.shared.massUnit = value
        case .payload: UserDefaultsManager.shared.payloadUnit = value
        }
    }
    
    private var valueFromStorage: (SettingsModel.Settings) -> String? = { setting in
        switch setting {
        case .height: return UserDefaultsManager.shared.heightUnit
        case .diameter: return UserDefaultsManager.shared.diameterUnit
        case .mass: return UserDefaultsManager.shared.massUnit
        case .payload: return UserDefaultsManager.shared.payloadUnit
        }
    }
}
