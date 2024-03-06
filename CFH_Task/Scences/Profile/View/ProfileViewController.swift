//
//  ProfileViewController.swift
//  CFH_Task
//
//  Created by Hamada Ragab on 04/03/2024.
//

import UIKit
import RxSwift
import RxCocoa
class ProfileViewController: UIViewController {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    var viewModel: ProfileViewModelProtocol?
    var router: ProfileRouterProtocol?
    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        didTapOnBack()
        bindUserData()
        viewModel?.viewDidLoad()
    }
    private func bindUserData() {
        viewModel?.output.name.bind(to: name.rx.text).disposed(by: disposeBag)
        viewModel?.output.email.bind(to: email.rx.text).disposed(by: disposeBag)
        viewModel?.output.age.bind(to: age.rx.text).disposed(by: disposeBag)
    }
    private func didTapOnBack() {
        backBtn.rx.tap.subscribe(onNext: { [weak self] _ in
            self?.router?.dismiss()
        }).disposed(by: disposeBag)
    }
}
