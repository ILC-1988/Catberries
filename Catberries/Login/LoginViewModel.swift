//
//  LoginModel.swift
//  Catberries
//
//  Created by Илья Черницкий on 18.08.23.
//

import UIKit

class LoginViewModel {

    var username: String = ""
    var password: String = ""
    var userDictionary: [String: String] = [:]

    func saveCredentials() {
        UserManager.saveCredentials(userDictionary)
    }

    func loadCredentials() {
        if let userDictionary = UserManager.loadCredentials() {
            self.userDictionary = userDictionary
        }
    }

    func logout() {
        UserManager.clearCredentials()
    }

    func loadFromUserDefaults() {
        userDictionary = UserManager.loadFromUserDefaults(username)
    }

    func saveInUserDefaults() {
        UserManager.saveInUserDefaults(to: userDictionary, username)
    }

    func userSingIn(login: String, password: String) -> Bool {
        var input = false
        for (user, pass) in userDictionary {
            if user == login {
                input = pass == password
                break
            }
        }
        return input
    }
}
