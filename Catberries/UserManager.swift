//
//  UserManager.swift
//  Catberries
//
//  Created by Илья Черницкий on 18.08.23.
//

import Foundation

final class UserManager {

    private static let credentialsKey = "credentials"
    private static let loginssKey = "logins"

    static func saveCredentials(_ credentials: [String: String]) {
        UserDefaults.standard.set(credentials, forKey: credentialsKey)
    }

    static func loadCredentials() -> [String: String]? {
        return UserDefaults.standard.dictionary(forKey: credentialsKey) as? [String: String]
    }

    static func clearCredentials() {
        UserDefaults.standard.removeObject(forKey: credentialsKey)
    }

    static func saveInUserDefaults(to loginDictionary: [String: String], _ user : String) {
        let userDefaults = UserDefaults.init(suiteName: user)!
        let logins = LoginData(data: loginDictionary)
        let loginData = try? JSONEncoder().encode(logins)
        userDefaults.set(loginData, forKey: loginssKey)
    }

    static func loadFromUserDefaults(_ user : String) -> [String: String] {
        let userDefaults = UserDefaults.init(suiteName: user)!
        if let loginsData = userDefaults.value(forKey: loginssKey) as? Data {
            let logins = try? JSONDecoder().decode(LoginData.self, from: loginsData)
            return logins?.data ?? [:] }
        else {
            return [:]
        }
    }
}

struct LoginData: Codable {
    let data: [String: String]
}
