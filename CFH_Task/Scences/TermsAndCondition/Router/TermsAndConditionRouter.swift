//
//  TermsAndConditionRouter.swift
//  CFH_Task
//
//  Created by Hamada Ragab on 04/03/2024.
//

import Foundation
import UIKit
protocol TermsAndConditionRouterProtocol {
    func dismiss()
}
class TermsAndConditionRouter {
    var viewController: TermsAndConditionViewController?
    init(viewController: TermsAndConditionViewController) {
        self.viewController = viewController
    }
    func start() {
        viewController?.router = self
        viewController?.viewModel = TermsAndConditionViewModel()
    }
}
extension TermsAndConditionRouter: TermsAndConditionRouterProtocol{
    func dismiss() {
        self.viewController?.navigationController?.popViewController(animated: true)
    }
}
