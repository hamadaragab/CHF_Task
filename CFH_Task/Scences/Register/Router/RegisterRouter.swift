//
//  RegisterRouter.swift
//  CFH_Task
//
//  Created by Hamada Ragab on 03/03/2024.
//

import Foundation
import UIKit
protocol RegisterRouterProtocol {
    func goToHome()
    func dismiss()
}
class RegisterRouter {
    var viewController: RegisterViewController?
    init(viewController: RegisterViewController) {
        self.viewController = viewController
    }
    func start() {
        viewController?.router = self
        viewController?.viewModel = RegisterViewModel(repository: RegisterRepository())
    }
}
extension RegisterRouter: RegisterRouterProtocol{
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
    func dismiss() {
        self.viewController?.navigationController?.popViewController(animated: true)
    }
}
