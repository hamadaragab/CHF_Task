//
//  LoignViewModel.swift
//  CFH_Task
//
//  Created by Hamada Ragab on 03/03/2024.
//

import Foundation
import RxSwift
import RxCocoa
protocol LoginViewModelProtocol: AnyObject {
    var input: LoginViewModel.Input {get}
    var output: LoginViewModel.Output {get}
    func viewDidLoad()
}

class LoginViewModel: LoginViewModelProtocol {
    var input: Input = .init()
    var output: Output = .init()
    private let disposeBag = DisposeBag()
    private let repository: LoginRepositoryProtocol?
    init(repository: LoginRepositoryProtocol) {
        self.repository = repository
    }
    func viewDidLoad() {
        didTapOnSignin()
    }
    private func didTapOnSignin() {
        input.signInTapped.subscribe(onNext: { [weak self] _ in
            self?.validateLoginData()
        }).disposed(by: disposeBag)
    }
    private func validateLoginData() {
        guard let email = input.email.value, !email.isEmpty, email.isValidEmail else {
            output.errorMessage.onNext("You must enter valid Email address")
            return
        }
        guard let password = input.password.value, !password.isEmpty, password.isValidPassword else {
            output.errorMessage.onNext("Password should be at least 8 characters!")
            return
        }
        login(email: email, password: password)
    }
    private func login(email: String, password: String) {
        output.showLoading.onNext(true)
        repository?.login(email: email, password: password, completion: { response in
            self.output.showLoading.onNext(false)
            switch response {
            case .success(let userData):
                self.output.didLogin.onNext(true)
                UserDefualtUtils.setIsLoggedIn(loggedIn: true)
                UserDefualtUtils.setUserData(user: User(userData: userData))
            case .failure(let error):
                self.output.errorMessage.onNext(error.localizedDescription)
            }
        })
    }
}
extension LoginViewModel: BaseViewModel {
    struct Input {
        let signInTapped = PublishSubject<Void>()
        let email = BehaviorRelay<String?>(value: nil)
        let password = BehaviorRelay<String?>(value: nil)
    }
    class Output {
        let showLoading = PublishSubject<Bool>()
        let errorMessage = PublishSubject<String>()
        let didLogin = PublishSubject<Bool>()
    }
}

