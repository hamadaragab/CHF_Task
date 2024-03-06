//
//  ProfileViewModel.swift
//  CFH_Task
//
//  Created by Hamada Ragab on 04/03/2024.
//

import Foundation
import RxSwift
import RxCocoa
protocol ProfileViewModelProtocol: AnyObject {
    var input: ProfileViewModel.Input {get}
    var output: ProfileViewModel.Output {get}
    func viewDidLoad()
}

class ProfileViewModel: ProfileViewModelProtocol {
    var input: Input = .init()
    var output: Output = .init()
    func viewDidLoad() {
        getUserData()
    }
    private func getUserData() {
        if let userData = UserDefualtUtils.getUserData() {
            output.name.onNext("\(userData.firstName) \(userData.lastName)")
            output.email.onNext(userData.email)
            output.age.onNext(String(userData.age))
        }
    }
}
extension ProfileViewModel: BaseViewModel {
    struct Input {
        
    }
    class Output {
        let name = PublishSubject<String>()
        let email = PublishSubject<String>()
        let age = PublishSubject<String>()
    }
}

