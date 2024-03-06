//
//  SideMenuViewController.swift
//  CFH_Task
//
//  Created by Hamada Ragab on 03/03/2024.
//

import UIKit
import RxSwift
import RxCocoa
class SideMenuViewController: BaseViewController {
    @IBOutlet weak var sideMenuTable: UITableView!
    @IBOutlet weak var dismissSideMenu: UIButton!
    var viewModel: SideMenuViewModelProtocol?
    var router: SideMenuRouterProtocol?
    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        didLogout()
        didTapOnSideMenu()
        viewModel?.viewDidLoad()
    }
    private func didLogout() {
        viewModel?.output.didLogOut.asDriver(onErrorJustReturn: false).drive(onNext: { [weak self] _ in
            self?.router?.goToLogin()
        }).disposed(by: disposeBag)
    }
    private func didTapOnSideMenu() {
        dismissSideMenu.rx.tap.subscribe(onNext: { [weak self] _ in
            self?.router?.dismissSideMenu()
        }).disposed(by: disposeBag)
    }
    private func setUpTableView() {
        registerCell()
        bindSideMenuData()
    }
    private func registerCell() {
        sideMenuTable.register(UINib(nibName: "SideMenuCell", bundle: nil), forCellReuseIdentifier: "SideMenuCell")
        sideMenuTable.rx.setDelegate(self).disposed(by: disposeBag)
    }
    private func bindSideMenuData() {
        viewModel?.output.sideMenuItems.bind(to: sideMenuTable.rx.items(cellIdentifier: "SideMenuCell",cellType: SideMenuCell.self)) { (index, item, cell) in
            cell.setUpCell(sideMenuItem: item)
        }.disposed(by: disposeBag)
        sideMenuTable.rx.modelSelected(SideMenuModel.self).subscribe(onNext: { [weak self] sideMenuItem in
            self?.didSelectSideMenuItem(sideMenuItem: sideMenuItem.title)
        }).disposed(by: disposeBag)
    }
    private func didSelectSideMenuItem(sideMenuItem: SideMenuItems) {
        switch sideMenuItem {
        case.Home:
            router?.dismissSideMenu()
        case .Profile:
            router?.goToProfile()
        case .TermsAndCondition:
            router?.goToTermsAndConditios()
        case .Logout:
            logOut()
        }
    }
    private func logOut() {
        let alertController = UIAlertController(title: "Log out!", message: "Are you sure You want to logout? ", preferredStyle: .actionSheet)
        let yes = UIAlertAction(title: "Yes", style: .destructive) { (action) in
            self.viewModel?.logout()
        }
        let cancel = UIAlertAction(title: "No", style: .default)
        alertController.addAction(yes)
        alertController.addAction(cancel)
        self.present(alertController, animated: true, completion: nil)
    }
    
}
extension SideMenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
