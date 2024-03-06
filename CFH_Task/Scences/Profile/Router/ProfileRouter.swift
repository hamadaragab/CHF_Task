//
//  ProfileRouter.swift
//  CFH_Task
//
//  Created by Hamada Ragab on 04/03/2024.
//

import Foundation
import UIKit
protocol ProfileRouterProtocol {
    func dismiss()
}
class ProfileRouter {
    var viewController: ProfileViewController?
    init(viewController: ProfileViewController) {
        self.viewController = viewController
    }
    func start() {
        viewController?.router = self
        viewController?.viewModel = ProfileViewModel()
    }
}
extension ProfileRouter: ProfileRouterProtocol{
    func dismiss() {
        self.viewController?.navigationController?.popViewController(animated: true)
    }
}
