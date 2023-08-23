//
//  LoginModel.swift
//  Catberries
//
//  Created by Илья Черницкий on 18.08.23.
//

import UIKit

class User {
    let name: String
    init(name: String) {
        self.name = name
    }
}

class LoginViewModel {

    var username: String = ""
    var password: String = ""
    var userDictionary: [String: String] = [:]

    func saveCredentials() {
        UserSessionManager.shared.saveCredentials(userDictionary)
    }

    func loadCredentials() {
        if let userDictionary = UserSessionManager.shared.loadCredentials() {
            self.userDictionary = userDictionary
        }
    }

    func logout() {
        UserSessionManager.shared.clearCredentials()
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
