//
//  RegisterViewModel.swift
//  CFH_Task
//
//  Created by Hamada Ragab on 03/03/2024.
//

import Foundation
import RxSwift
import RxCocoa
protocol RegisterViewModelProtocol: AnyObject {
    var input: RegisterViewModel.Input {get}
    var output: RegisterViewModel.Output {get}
    func viewDidLoad()
}

class RegisterViewModel: RegisterViewModelProtocol {
    var input: Input = .init()
    var output: Output = .init()
    private let disposeBag = DisposeBag()
    private let repository: RegisterRepositoryProtocol?
    init(repository: RegisterRepositoryProtocol) {
        self.repository = repository
    }
    func viewDidLoad() {
        didTapOnSignUp()
    }
    private func didTapOnSignUp() {
        input.signUpTapped.subscribe(onNext: { [weak self] _ in
            self?.validateRegisterData()
        }).disposed(by: disposeBag)
    }
    private func validateRegisterData() {
        guard let firstName = input.firstName.value, !firstName.isEmpty else {
            output.errorMessage.onNext("First name is missing or empty.")
            return
        }
        guard let lastName = input.lastName.value, !lastName.isEmpty else {
            output.errorMessage.onNext("Last name is missing or empty.")
            return
        }
        
        guard let age = input.age.value, !age.isEmpty, let Int_age = Int(age), Int_age >= 18 else {
            output.errorMessage.onNext("Your Age is Under 18")
            return
        }
        guard let email = input.email.value, !email.isEmpty, email.isValidEmail else {
            output.errorMessage.onNext("You must enter valid Email address")
            return
        }
        guard let password = input.password.value, !password.isEmpty, password.isValidPassword else {
            output.errorMessage.onNext("Password should be at least 8 characters!")
            return
        }
        let user = UserData(firstName: firstName, lastName: lastName, age: Int_age, email: email, password: password)
        Register(user: user)
    }
    private func Register(user: UserData) {
        output.showLoading.onNext(true)
        repository?.registerNewUser(user: user, completion: { response in
            self.output.showLoading.onNext(false)
            switch response {
            case .success(let userStatus):
                if userStatus == .Created {
                    self.output.didRegisterUser.onNext("User registered successfully")
                    UserDefualtUtils.setIsLoggedIn(loggedIn: true)
                    UserDefualtUtils.setUserData(user: User(userData: user))
                }else {
                    self.output.isUserAlreadyExist.onNext(true)
                }
            case .failure(let error):
                self.output.errorMessage.onNext(error.localizedDescription)
            }
        })
    }
}
extension RegisterViewModel: BaseViewModel {
    struct Input {
        let signUpTapped = PublishSubject<Void>()
        let email = BehaviorRelay<String?>(value: nil)
        let password = BehaviorRelay<String?>(value: nil)
        let age = BehaviorRelay<String?>(value: nil)
        let firstName = BehaviorRelay<String?>(value: nil)
        let lastName = BehaviorRelay<String?>(value: nil)
    }
    class Output {
        let showLoading = PublishSubject<Bool>()
        let errorMessage = PublishSubject<String>()
        let didRegisterUser = PublishSubject<String>()
        let isUserAlreadyExist = PublishSubject<Bool>()
    }
}

