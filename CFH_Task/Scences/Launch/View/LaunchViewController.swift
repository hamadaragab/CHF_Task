//
//  LaunchViewController.swift
//  CFH_Task
//
//  Created by Hamada Ragab on 03/03/2024.
//

import UIKit
import RxSwift
import RxCocoa
class LaunchViewController: UIViewController {
    var viewModel: LaunchViewModelProtocol?
    var router: LaunchRouterProtocol?
    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        goToNextView()
        viewModel?.viewDidLoad()
    }
    private func goToNextView() {
        viewModel?.output.goToHome.asDriver(onErrorJustReturn: false).drive(onNext: {[weak self] _ in
            self?.router?.goToHome()
        }).disposed(by: disposeBag)
        viewModel?.output.goToLogin.asDriver(onErrorJustReturn: false).drive(onNext: {[weak self] _ in
            self?.router?.goToLogin()
        }).disposed(by: disposeBag)
    }
}
