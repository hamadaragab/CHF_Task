//
//  HomeRouter.swift
//  CFH_Task
//
//  Created by Hamada Ragab on 03/03/2024.
//

import Foundation
import SideMenu
protocol HomeRouterProtocol {
//    func goToHome()
    func goToSideMenu()
}
class HomeRouter {
    var viewController: HomeViewController?
    init(viewController: HomeViewController) {
        self.viewController = viewController
    }
    func start() {
        viewController?.router = self
        viewController?.viewModel = HomeViewModel(repository: HomeRepository())
    }
}
extension HomeRouter: HomeRouterProtocol{
    func goToSideMenu() {
        let sideMenuVC = SideMenuViewController()
        SideMenuRouter(viewController: sideMenuVC).start()
        let menu = SideMenuNavigationController(rootViewController: sideMenuVC)
        menu.presentationStyle = .menuSlideIn
        menu.menuWidth = self.viewController?.view.frame.size.width ?? 0.0
        menu.modalPresentationStyle = .overFullScreen
        menu.leftSide = true
        viewController?.present(menu, animated: true, completion: nil)
    }
}
