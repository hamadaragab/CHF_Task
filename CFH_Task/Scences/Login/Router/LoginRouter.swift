//
//  LoginRouter.swift
//  CFH_Task
//
//  Created by Hamada Ragab on 03/03/2024.
//

import Foundation
//
//  LoginRouter.swift
//  CFH_Task
//
//  Created by Hamada Ragab on 03/03/2024.
//

import Foundation
import UIKit
protocol LoginRouterProtocol {
    func goToRegister()
    func goToHome()
}
class LoginRouter {
    var viewController: LoginViewController?
    init(viewController: LoginViewController) {
        self.viewController = viewController
    }
    func start() {
        viewController?.router = self
        viewController?.viewModel = LoginViewModel(repository: LoginRepository())
    }
}
extension LoginRouter: LoginRouterProtocol{
    func goToHome() {
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            let homeView = HomeViewController()
            HomeRouter(viewController: homeView).start()
            let navigationController = UINavigationController(rootViewController: homeView)
            navigationController.modalPresentationStyle = .fullScreen
            navigationController.navigationBar.isHidden = true
            sceneDelegate.window?.rootViewController = navigationController
            sceneDelegate.window?.makeKeyAndVisible()
        }
    }
    func goToRegister() {
        let registerView = RegisterViewController()
        RegisterRouter(viewController: registerView).start()
        registerView.modalPresentationStyle = .fullScreen
        self.viewController?.navigationController?.pushViewController(registerView, animated: true)
        
    }
}
