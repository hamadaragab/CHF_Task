//
//  UserData.swift
//  CFH_Task
//
//  Created by Hamada Ragab on 03/03/2024.
//

import Foundation
import RealmSwift
class UserData: Object, Codable {
    @Persisted var firstName: String = ""
    @Persisted var lastName: String = ""
    @Persisted var age: Int = 0
    @Persisted var email: String = ""
    @Persisted var password: String = ""

    convenience init(firstName: String, lastName: String, age: Int, email: String, password: String) {
        self.init()
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
        self.email = email
        self.password = password
    }
}

struct User: Codable{
    var firstName: String
    var lastName: String
    var age: Int
    var email: String
    var password: String
    
    init(userData: UserData) {
        self.firstName = userData.firstName
        self.lastName = userData.lastName
        self.age = userData.age
        self.email = userData.email
        self.password = userData.password
    }
}
