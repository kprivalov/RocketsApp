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
    var defaults: UserDefaults? { get }
}

class UserDefaultsManager: StorageManager {
    var defaults: UserDefaults?

    enum UserDefaultsKeys: String {
        case height
        case diameter
        case mass
        case payload
    }
    
    @propertyWrapper
    struct UserDefault {
        let key: UserDefaultsKeys
        var container: UserDefaults

        var wrappedValue: String? {
            get {
                return container.object(forKey: key.rawValue) as? String
            }
            set {
                container.set(newValue, forKey: key.rawValue)
            }
        }
    }
        
    init(defaults: UserDefaults = UserDefaults.standard) {
        self.defaults = defaults
        UserDefaults.standard.register(defaults: [UserDefaultsKeys.height.rawValue: "ft",
                                                  UserDefaultsKeys.diameter.rawValue: "ft",
                                                  UserDefaultsKeys.mass.rawValue: "kg",
                                                  UserDefaultsKeys.payload.rawValue: "lb"])
    }

    @UserDefault(key: .height, container: UserDefaults.standard)
    var heightUnit: String?
    
    @UserDefault(key: .diameter, container: UserDefaults.standard)
    var diameterUnit: String?
    
    @UserDefault(key: .mass, container: UserDefaults.standard)
    var massUnit: String?
    
    @UserDefault(key: .payload, container: UserDefaults.standard)
    var payloadUnit: String?
}
