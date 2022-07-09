//
//  UserDefaultsManager.swift
//  RocketsApp
//
//  Created by Kirill Privalov on 07.07.2022.
//

import Foundation

class UserDefaultsManager {
    enum UserDefaultsKeys: String {
        case height
        case diameter
        case mass
        case payload
    }
    
    let defaults = UserDefaults.standard
    static let shared = UserDefaultsManager()
    
    init() {
        defaults.register(defaults: [UserDefaultsKeys.height.rawValue: "ft",
                                     UserDefaultsKeys.diameter.rawValue: "ft",
                                     UserDefaultsKeys.mass.rawValue: "kg",
                                     UserDefaultsKeys.payload.rawValue: "lb"])
    }

    var heightUnit: String? {
        get {
            defaults.object(forKey: UserDefaultsKeys.height.rawValue) as? String
        } set {
            defaults.set(newValue, forKey: UserDefaultsKeys.height.rawValue)
        }
    }
    
    var diameterUnit: String? {
        get {
            defaults.object(forKey: UserDefaultsKeys.diameter.rawValue) as? String
        } set {
            defaults.set(newValue, forKey: UserDefaultsKeys.diameter.rawValue)
        }
    }
    
    var massUnit: String? {
        get {
            defaults.object(forKey: UserDefaultsKeys.mass.rawValue) as? String
        } set {
            defaults.set(newValue, forKey: UserDefaultsKeys.mass.rawValue)
        }
    }
    
    var payloadUnit: String? {
        get {
            defaults.object(forKey: UserDefaultsKeys.payload.rawValue) as? String
        } set {
            defaults.set(newValue, forKey: UserDefaultsKeys.payload.rawValue)
        }
    }
}

