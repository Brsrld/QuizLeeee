//
//  UserDefaultsHelper.swift
//  QuizLeeee
//
//  Created by Barış Şaraldı on 28.12.2023.
//

import Foundation

// MARK: - UserDefaultsHelper
final class UserDefaultsHelper {
    static func setData<T>(value: T, key: UserDefaultKeys) {
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: key.rawValue)
    }
    static func getData<T>(type: T.Type, forKey: UserDefaultKeys) -> T? {
        let defaults = UserDefaults.standard
        let value = defaults.object(forKey: forKey.rawValue) as? T
        return value
    }
    static func removeData(key: UserDefaultKeys) {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: key.rawValue)
    }
}

enum UserDefaultKeys: String, CaseIterable {
    case score
}
