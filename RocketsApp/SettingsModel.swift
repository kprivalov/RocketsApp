//
//  SettingsModel.swift
//  RocketsApp
//
//  Created by Kirill Privalov on 08.07.2022.
//

import Foundation

struct SettingsModel {
    struct Setting {
        let type: Settings
        let name: String
        let units: [String]
        let defaultValue: String?
    }
    
    enum Unit {
        case length
        case mass
        
        var units: [String] {
            switch self {
            case .length:
                return ["m", "ft"]
            case .mass:
                return ["kg", "lb"]
            }
        }
    }
    
    enum Settings: CaseIterable {
        case height
        case diameter
        case mass
        case payload
        
        var setting: (name: String, segments: [String], defaultValue: String?) {
            switch self {
            case .height: return ("Высота", Unit.length.units, UserDefaultsManager.shared.heightUnit)
            case .diameter: return ("Диаметр", Unit.length.units, UserDefaultsManager.shared.diameterUnit)
            case .mass: return ("Масса", Unit.mass.units, UserDefaultsManager.shared.massUnit)
            case .payload: return ("Полезная нагрузка", Unit.mass.units, UserDefaultsManager.shared.payloadUnit)
            }
        }
    }
    
    var settingsArray: [Setting] {
        var settings = [Setting]()
        settings = Settings.allCases.map { item in
            Setting(type: item,
                    name: item.setting.name,
                    units: item.setting.segments,
                    defaultValue: item.setting.defaultValue)
        }
        return settings
    }
    
    func setSettingsValue(field: Settings, value: String) {
        switch field {
        case .height:
            UserDefaultsManager.shared.heightUnit = value
        case .diameter:
            UserDefaultsManager.shared.diameterUnit = value
        case .mass:
            UserDefaultsManager.shared.massUnit = value
        case .payload:
            UserDefaultsManager.shared.payloadUnit = value
        }
    }
}
