//
//  TermsAndConditionViewModel.swift
//  CFH_Task
//
//  Created by Hamada Ragab on 04/03/2024.
//

import Foundation
import RxSwift
import RxCocoa
protocol TermsAndConditionViewModelProtocol: AnyObject {
    var input: TermsAndConditionViewModel.Input {get}
    var output: TermsAndConditionViewModel.Output {get}
    func viewDidLoad()
}

class TermsAndConditionViewModel: TermsAndConditionViewModelProtocol {
    var input: Input = .init()
    var output: Output = .init()
    func viewDidLoad() {
    }
}
extension TermsAndConditionViewModel: BaseViewModel {
    struct Input {
        
    }
    class Output {
        let goToHome = PublishSubject<Bool>()
        let goToLogin = PublishSubject<Bool>()
        
    }
}

