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
        
        var setting: (name: String, segments: [String]) {
            switch self {
            case .height: return ("Высота", Unit.length.units)
            case .diameter: return ("Диаметр", Unit.length.units)
            case .mass: return ("Масса", Unit.mass.units)
            case .payload: return ("Полезная нагрузка", Unit.mass.units)
            }
        }
    }
}
