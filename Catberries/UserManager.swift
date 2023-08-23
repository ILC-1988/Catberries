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


