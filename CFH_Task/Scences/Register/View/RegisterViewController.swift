//
//  RegisterViewController.swift
//  CFH_Task
//
//  Created by Hamada Ragab on 03/03/2024.
//

import UIKit
import JVFloatLabeledTextField
import RxSwift
import RxCocoa
class RegisterViewController: BaseViewController {
    @IBOutlet weak var showHidePassword: UIButton!
    @IBOutlet weak var signUp: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var password: JVFloatLabeledTextField!
    @IBOutlet weak var email: JVFloatLabeledTextField!
    @IBOutlet weak var age: JVFloatLabeledTextField!
    @IBOutlet weak var lastName: JVFloatLabeledTextField!
    @IBOutlet weak var firstName: JVFloatLabeledTextField!
    var viewModel: RegisterViewModelProtocol?
    var router: RegisterRouterProtocol?
    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        securePassword()
        setUpTextFields()
        bindTextFieldsData()
        didRegisterNewUser()
        didTapOnBack()
        isUserExistBefore()
        viewModel?.viewDidLoad()
    }
    private func setUpTextFields() {
        age.keyboardType = .asciiCapableNumberPad
        [lastName, firstName, password, email, age].forEach{ textFiled in
            textFiled.floatingLabelYPadding = 10
            textFiled.floatingLabelActiveTextColor = .blue
        }
    }
    private func bindTextFieldsData() {
        firstName.rx.text.orEmpty.bind(to: viewModel!.input.firstName).disposed(by: disposeBag)
        lastName.rx.text.orEmpty.bind(to: viewModel!.input.lastName).disposed(by: disposeBag)
        age.rx.text.orEmpty.bind(to: viewModel!.input.age).disposed(by: disposeBag)
        password.rx.text.orEmpty.bind(to: viewModel!.input.password).disposed(by: disposeBag)
        email.rx.text.orEmpty.bind(to: viewModel!.input.email).disposed(by: disposeBag)
        signUp.rx.tap.bind(to: viewModel!.input.signUpTapped).disposed(by: disposeBag)
    }
    private func securePassword() {
        showHidePassword.rx.tap.subscribe(onNext: {[weak self] _ in
            self?.password.isSecureTextEntry.toggle()
            let image = self?.password.isSecureTextEntry ?? false ? "showPassword" : "hidePassword"
            self?.showHidePassword.setImage(UIImage(named: image), for: .normal)
        }).disposed(by: disposeBag)
    }
    private func didRegisterNewUser() {
        viewModel?.output.errorMessage.asDriver(onErrorJustReturn: "").drive(onNext: { [weak self] message in
            self?.showToast(title: "", message: message, status: .error)
        }).disposed(by: disposeBag)
        viewModel?.output.showLoading.asDriver(onErrorJustReturn: false).drive(onNext: { [weak self] isLoading in
            guard let self = self else {return}
            self.showHud(showLoding: isLoading)
        }).disposed(by: disposeBag)
        viewModel?.output.didRegisterUser.asDriver(onErrorJustReturn: "").drive(onNext: { [weak self] message in
            self?.showToast(title: "", message: message, status: .success)
            self?.router?.goToHome()
        }).disposed(by: disposeBag)
    }
    private func isUserExistBefore() {
        viewModel?.output.isUserAlreadyExist.asDriver(onErrorJustReturn: false).drive(onNext: { [weak self] _ in
            self?.presentLoginAlert()
        }).disposed(by: disposeBag)
    }
    private func presentLoginAlert() {
        let alertController = UIAlertController(title: "Attentions!", message: "user is Already Exist would you login ?", preferredStyle: .alert)
        let yes = UIAlertAction(title: "Yes", style: .destructive) { (action) in
            self.router?.dismiss()
        }
        let cancel = UIAlertAction(title: "No", style: .default)
        alertController.addAction(cancel)
        alertController.addAction(yes)
        self.present(alertController, animated: true, completion: nil)
    }
    private func didTapOnBack() {
        backBtn.rx.tap.subscribe(onNext: {[weak self] _ in
            self?.router?.dismiss()
        }).disposed(by: disposeBag)
    }
}
