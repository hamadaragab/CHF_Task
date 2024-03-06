//
//  LoginRepository.swift
//  CFH_Task
//
//  Created by Hamada Ragab on 03/03/2024.
//

import Foundation
import RealmSwift
protocol LoginRepositoryProtocol: AnyObject {
    func login(email: String, password: String, completion: @escaping (Result<UserData, ErrorStatus>) -> Void)
}
class LoginRepository: LoginRepositoryProtocol {
    func login(email: String, password: String, completion: @escaping (Result<UserData, ErrorStatus>) -> Void) {
        do {
            let realm = try Realm()
            if let user = realm.objects(UserData.self).filter({$0.email == email && $0.password == password}).first {
                completion(.success(user))
            } else {
                completion(.failure(.UserNotExist))
            }
        } catch {
            print("Error accessing Realm: \(error)")
        }
    }
}
