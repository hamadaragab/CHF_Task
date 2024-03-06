//
//  RegisterRepository.swift
//  CFH_Task
//
//  Created by Hamada Ragab on 03/03/2024.
//

import Foundation
import RealmSwift

protocol RegisterRepositoryProtocol: AnyObject {
    func registerNewUser(user: UserData, completion: @escaping (Result<UserStatus, ErrorStatus>) -> Void)
}
class RegisterRepository: RegisterRepositoryProtocol {
    func registerNewUser(user: UserData, completion: @escaping (Result<UserStatus, ErrorStatus>) -> Void) {
        do {
            let realm = try Realm()
            if let _ = realm.objects(UserData.self).filter({$0.email == user.email && $0.password == user.password}).first {
                completion(.success(.AlreadyExists))
            }else {
                try realm.write {
                    realm.add(user)
                }
                completion(.success(.Created))
            }
        } catch {
            completion(.failure(.ErrorSavingUser))
        }
    }
}
