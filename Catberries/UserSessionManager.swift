//
//  UserSessionManager.swift
//  Catberries
//
//  Created by Илья Черницкий on 23.08.23.
//

import Foundation

final class UserSessionManager {
    static let shared = UserSessionManager()

    private var currentUser: User?
    private let userDefaults = UserDefaults.standard
    private let cartKey = "Cart"
    private let favoritesKey = "Favorites"
    private let credentialsKey = "credentials"
    private let loginssKey = "logins"

    private init() {}

    func setCurrentUser(user: User) {
        currentUser = user
    }

    func getCurrentUser() -> User? {
        return currentUser
    }

    func clearCurrentUser() {
        currentUser = nil
    }

    func saveCredentials(_ credentials: [String: String]) {
        userDefaults.set(credentials, forKey: credentialsKey)
    }

    func loadCredentials() -> [String: String]? {
        return userDefaults.dictionary(forKey: credentialsKey) as? [String: String]
    }

    func clearCredentials() {
        userDefaults.removeObject(forKey: credentialsKey)
    }

    func setData(key: String, to userData: [UserData]) {
        let userDefaults = UserDefaults(suiteName: currentUser?.name)
        let logins = LoginData(data: userData)
        let loginData = try? JSONEncoder().encode(logins)
        userDefaults?.set(loginData, forKey: key)
    }

    func getData(key: String) -> [UserData] {
        let userDefaults = UserDefaults(suiteName: currentUser?.name)
        if let loginsData = userDefaults?.value(forKey: key) as? Data {
            let logins = try? JSONDecoder().decode(LoginData.self, from: loginsData)
            return logins?.data ?? []
        } else {
            return []
        }
    }
}

struct LoginData: Codable {
    let data: [UserData]
}

struct UserData: Codable {
    let product: Product
    var quantity: Int
}
