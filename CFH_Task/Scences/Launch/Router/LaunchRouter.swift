//
//  LaunchRouter.swift
//  CFH_Task
//
//  Created by Hamada Ragab on 03/03/2024.
//

import Foundation
import UIKit
protocol LaunchRouterProtocol {
    func goToHome()
    func goToLogin()
}
class LaunchRouter {
    var viewController: LaunchViewController?
    init(viewController: LaunchViewController) {
        self.viewController = viewController
    }
    func start() {
        viewController?.router = self
        viewController?.viewModel = LaunchViewModel()
    }
}
extension LaunchRouter: LaunchRouterProtocol{
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
    func goToLogin() {
        let loginView = LoginViewController()
        LoginRouter(viewController: loginView).start()
        let navigationController = UINavigationController(rootViewController: loginView)
        navigationController.modalPresentationStyle = .fullScreen
        navigationController.navigationBar.isHidden = true
        self.viewController?.present(navigationController, animated: true)
        
    }
}
