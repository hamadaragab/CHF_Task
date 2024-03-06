//
//  SideMenuViewModel.swift
//  CFH_Task
//
//  Created by Hamada Ragab on 04/03/2024.
//

import Foundation
import RxSwift
import RxCocoa
protocol SideMenuViewModelProtocol: AnyObject {
    var input: SideMenuViewModel.Input {get}
    var output: SideMenuViewModel.Output {get}
    func viewDidLoad()
    func logout()
}

class SideMenuViewModel: SideMenuViewModelProtocol {
    var input: Input = .init()
    var output: Output = .init()
    private var venues: [Venues] = []
    init() {
        
    }
    func viewDidLoad() {
        createSideMenuItems()
    }
    private func createSideMenuItems() {
        let HomeModel = SideMenuModel(image: "Home", title: .Home)
        let LogoutModel = SideMenuModel(image: "logout", title: .Logout)
        let profileModel = SideMenuModel(image: "profile", title: .Profile)
        let TermsAndConditionModel = SideMenuModel(image: "termsAndCondition", title: .TermsAndCondition)
        let sideMenuItems = [HomeModel, profileModel, TermsAndConditionModel, LogoutModel]
        self.output.sideMenuItems.onNext(sideMenuItems)
    }
    func logout() {
        UserDefualtUtils.removeUserData()
        output.didLogOut.onNext(true)
    }
}
extension SideMenuViewModel: BaseViewModel {
    struct Input {
        
    }
    class Output {
        let showLoading = PublishSubject<Bool>()
        let errorMessage = PublishSubject<String>()
        let sideMenuItems = PublishSubject<[SideMenuModel]>()
        let didLogOut = PublishSubject<Bool>()
    }
}

