//
//  SideMenuRouter.swift
//  CFH_Task
//
//  Created by Hamada Ragab on 04/03/2024.
//

import Foundation
import UIKit
protocol SideMenuRouterProtocol {
    func dismissSideMenu()
    func goToProfile()
    func goToLogin()
    func goToTermsAndConditios()
}
class SideMenuRouter {
    var viewController: SideMenuViewController?
    init(viewController: SideMenuViewController) {
        self.viewController = viewController
    }
    func start() {
        viewController?.router = self
        viewController?.viewModel = SideMenuViewModel()
    }
}
extension SideMenuRouter: SideMenuRouterProtocol{
    func goToProfile() {
        let profileView = ProfileViewController()
        ProfileRouter(viewController: profileView).start()
        profileView.modalPresentationStyle = .fullScreen
        self.viewController?.navigationController?.pushViewController(profileView, animated: true)
    }
    
    func goToTermsAndConditios() {
        let termsAndConditionView = TermsAndConditionViewController()
        TermsAndConditionRouter(viewController: termsAndConditionView).start()
        termsAndConditionView.modalPresentationStyle = .fullScreen
        self.viewController?.navigationController?.pushViewController(termsAndConditionView, animated: true)
    }
    func goToLogin() {
        let loginView = LoginViewController()
        LoginRouter(viewController: loginView).start()
        let navigationController = UINavigationController(rootViewController: loginView)
        navigationController.modalPresentationStyle = .fullScreen
        navigationController.navigationBar.isHidden = true
        self.viewController?.present(navigationController, animated: true)
        
    }
    func dismissSideMenu() {
        viewController?.dismiss(animated: true)
    }
    
}
