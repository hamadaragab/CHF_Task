//
//  LaunchViewModel.swift
//  CFH_Task
//
//  Created by Hamada Ragab on 03/03/2024.
//

import Foundation
import RxSwift
import RxCocoa
protocol LaunchViewModelProtocol: AnyObject {
    var input: LaunchViewModel.Input {get}
    var output: LaunchViewModel.Output {get}
    func viewDidLoad()
}

class LaunchViewModel: LaunchViewModelProtocol {
    var input: Input = .init()
    var output: Output = .init()
    func viewDidLoad() {
        // check is logged in
        if let isLoggedin = UserDefualtUtils.getIsLoggedIn(), isLoggedin {
            // go To Home
            output.goToHome.onNext(true)
        }else {
            // go To login
            output.goToLogin.onNext(true)
        }
    }
}
extension LaunchViewModel: BaseViewModel {
    struct Input {
        
    }
    class Output {
        let goToHome = PublishSubject<Bool>()
        let goToLogin = PublishSubject<Bool>()
        
    }
}

