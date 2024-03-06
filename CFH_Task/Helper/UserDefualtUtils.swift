//
//  UserDefualtUtils.swift
//  CFH_Task
//
//  Created by Hamada Ragab on 03/03/2024.
//

import Foundation
class UserDefualtUtils {
    static private let IsLogged = "IsLogged"
    static private let userData = "userData"
    static private let userDefualt = UserDefaults.standard
    
    static func setIsLoggedIn(loggedIn: Bool) {
        userDefualt.setValue(loggedIn, forKey: IsLogged)
    }
    static func getIsLoggedIn() -> Bool? {
        return userDefualt.bool(forKey: IsLogged)
    }
    static func setUserData(user: User) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(user) {
            userDefualt.set(encoded, forKey: userData)
        }
    }
    static func getUserData() -> User? {
        if let data = userDefualt.data(forKey: userData) {
            let decoder = JSONDecoder()
            if let object = try? decoder.decode(User.self, from: data) {
                return object
            }else {
                print("Couldnt decode object")
                return nil
            }
        }else {
            print("Couldnt find key")
            return nil
        }
    }
    static func removeUserData() {
        userDefualt.setValue(false, forKey: IsLogged)
        userDefualt.removeObject(forKey: userData)
        userDefualt.synchronize()
    }
}
