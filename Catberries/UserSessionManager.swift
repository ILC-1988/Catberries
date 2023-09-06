//
//  UserSessionManager.swift
//  Catberries
//
//  Created by Илья Черницкий on 23.08.23.
//

import Foundation
import UIKit

final class UserSessionManager {
    static let shared = UserSessionManager()

    private var currentUser: User?
    private let userDefaults = UserDefaults.standard
    private let cartKey = "Cart"
    private let info = "Info"
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

    func setUserInfo(key: String, to user: User) {
        let userDefaults = UserDefaults(suiteName: key)
        let userInfo = try? JSONEncoder().encode(user)
        userDefaults?.set(userInfo, forKey: info)
    }

    func getUserInfo(key: String) -> User? {
        let userDefaults = UserDefaults(suiteName: key)
        if let userData = userDefaults?.value(forKey: info) as? Data {
            if let userInfo = try? JSONDecoder().decode(User.self, from: userData) {
                return userInfo
            }
        }
        return nil
    }
}

struct LoginData: Codable {
    let data: [UserData]
}

struct UserData: Codable {
    let product: Product
    var quantity: Int
}

struct User: Codable {
    let name: String
    let email: String?
    let address: String?
    let phone: String?
}
