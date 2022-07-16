//
//  UserDefaultsManager.swift
//  RocketsApp
//
//  Created by Kirill Privalov on 07.07.2022.
//

import Foundation

protocol StorageManager {
    var heightUnit: String? { get set }
    var diameterUnit: String? { get set }
    var massUnit: String? { get set }
    var payloadUnit: String? { get set }
}

final class UserDefaultsManager: StorageManager {
    enum UserDefaultsKeys: String {
        case height
        case diameter
        case mass
        case payload
    }
    
    @propertyWrapper
    struct UserDefault {
        let key: UserDefaultsKeys
        var container: UserDefaults = .standard

        var wrappedValue: String? {
            get {
                return container.object(forKey: key.rawValue) as? String
            }
            set {
                container.set(newValue, forKey: key.rawValue)
            }
        }
    }
    
    let defaults = UserDefaults.standard
    
    static let shared = UserDefaultsManager()
    
    init() {
        UserDefaults.standard.register(defaults: [UserDefaultsKeys.height.rawValue: "ft",
                                                  UserDefaultsKeys.diameter.rawValue: "ft",
                                                  UserDefaultsKeys.mass.rawValue: "kg",
                                                  UserDefaultsKeys.payload.rawValue: "lb"])
    }

    @UserDefault(key: .height)
    var heightUnit: String?
    
    @UserDefault(key: .diameter)
    var diameterUnit: String?
    
    @UserDefault(key: .mass)
    var massUnit: String?
    
    @UserDefault(key: .payload)
    var payloadUnit: String?
}
