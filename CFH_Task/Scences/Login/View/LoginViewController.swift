//
//  LoginViewController.swift
//  CFH_Task
//
//  Created by Hamada Ragab on 03/03/2024.
//

import UIKit
import RxSwift
import RxCocoa
import JVFloatLabeledTextField
class LoginViewController: BaseViewController {
    @IBOutlet weak var password: JVFloatLabeledTextField!
    @IBOutlet weak var email: JVFloatLabeledTextField!
    @IBOutlet weak var singUp: UIButton!
    @IBOutlet weak var singIn: UIButton!
    @IBOutlet weak var showAndHidePassword: UIButton!
    var viewModel: LoginViewModelProtocol?
    var router: LoginRouterProtocol?
    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUi()
        bindTextFieldsData()
        bindButtonActions()
        securePassword()
        didLogin()
        viewModel?.viewDidLoad()
    }
    private func setUpUi() {
        [password,email].forEach{ textFiled in
            textFiled.floatingLabelYPadding = 10
            textFiled.floatingLabelActiveTextColor = .blue
        }
    }
    private func bindTextFieldsData() {
        password.rx.text.orEmpty.bind(to: viewModel!.input.password).disposed(by: disposeBag)
        email.rx.text.orEmpty.bind(to: viewModel!.input.email).disposed(by: disposeBag)
    }
    private func bindButtonActions() {
        singIn.rx.tap.bind(to: viewModel!.input.signInTapped).disposed(by: disposeBag)
        singUp.rx.tap.asDriver().drive(onNext: {[weak self] _ in
            self?.router?.goToRegister()
        }).disposed(by: disposeBag)
    }
    private func securePassword() {
        showAndHidePassword.rx.tap.subscribe(onNext: {[weak self] _ in
            self?.password.isSecureTextEntry.toggle()
            let image = self?.password.isSecureTextEntry ?? false ? "showPassword" : "hidePassword"
            self?.showAndHidePassword.setImage(UIImage(named: image), for: .normal)
        }).disposed(by: disposeBag)
    }
    private func didLogin() {
        viewModel?.output.errorMessage.asDriver(onErrorJustReturn: "").drive(onNext: { [weak self] message in
            self?.showToast(title: "", message: message, status: .error)
        }).disposed(by: disposeBag)
        viewModel?.output.showLoading.asDriver(onErrorJustReturn: false).drive(onNext: { [weak self] isLoading in
            guard let self = self else {return}
            self.showHud(showLoding: isLoading)
        }).disposed(by: disposeBag)
        viewModel?.output.didLogin.asDriver(onErrorJustReturn: false).drive(onNext: { [weak self] message in
            self?.router?.goToHome()
        }).disposed(by: disposeBag)
    }
}
