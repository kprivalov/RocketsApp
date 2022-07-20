//
//  SettingsPresenter.swift
//  RocketsApp
//
//  Created by Kirill Privalov on 11.07.2022.
//

import Foundation

protocol SettingsPresenterProtocol {
    var storage: StorageManager { get }
    var settingsCount: Int { get }
    var settingsArray: [SettingsModel.Setting] { get }
    func valueFromStorage(key: SettingsModel.Settings) -> String?
    func getSettingsTypeByIndex(_ index: Int) -> SettingsModel.Setting
    func setValueToStorage(key: SettingsModel.Settings, _ value: String?) -> Void
}

class SettingsPresenter: SettingsPresenterProtocol {
    var storage: StorageManager = UserDefaultsManager()
    
    var settingsCount: Int {
        return SettingsModel.Settings.allCases.count
    }
    
    var settingsArray: [SettingsModel.Setting] {
        return SettingsModel.Settings.allCases.map { item in
            SettingsModel.Setting(type: item,
                                  name: item.setting.name,
                                  units: item.setting.segments,
                                  defaultValue: self.valueFromStorage(key: item))
        }
    }
    
    func valueFromStorage(key: SettingsModel.Settings) -> String? {
        switch key {
        case .height: return storage.heightUnit
        case .diameter: return storage.diameterUnit
        case .mass: return storage.massUnit
        case .payload: return storage.payloadUnit
        }
    }
    
    func getSettingsTypeByIndex(_ index: Int) -> SettingsModel.Setting {
        settingsArray[index]
    }
 
    func setValueToStorage(key: SettingsModel.Settings, _ value: String?) {
        switch key {
        case .height: self.storage.heightUnit = value
        case .diameter: self.storage.diameterUnit = value
        case .mass: self.storage.massUnit = value
        case .payload: self.storage.payloadUnit = value
        }
    }
}
