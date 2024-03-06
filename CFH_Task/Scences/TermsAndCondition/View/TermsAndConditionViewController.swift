//
//  TermsAndConditionViewController.swift
//  CFH_Task
//
//  Created by Hamada Ragab on 04/03/2024.
//

import UIKit
import RxSwift
import RxCocoa
class TermsAndConditionViewController: UIViewController {
    @IBOutlet weak var backBtn: UIButton!
    var viewModel: TermsAndConditionViewModelProtocol?
    var router: TermsAndConditionRouterProtocol?
    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        didTapOnBack()
    }
    private func didTapOnBack() {
        backBtn.rx.tap.subscribe(onNext: { [weak self] _ in
            self?.router?.dismiss()
        }).disposed(by: disposeBag)
    }

}
