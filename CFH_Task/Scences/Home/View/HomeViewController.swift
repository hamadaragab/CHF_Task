//
//  HomeViewController.swift
//  CFH_Task
//
//  Created by Hamada Ragab on 03/03/2024.
//

import UIKit
import RxSwift
import RxCocoa
import GoogleMaps
class HomeViewController: BaseViewController {
    @IBOutlet weak var venuesTableView: UITableView!
    @IBOutlet weak var sideMenuBtn: UIButton!
    @IBOutlet weak var segmentContoller: UISegmentedControl!
    @IBOutlet weak var mapView: GMSMapView!
    var viewModel: HomeViewModelProtocol?
    var router: HomeRouterProtocol?
    private let disposeBag = DisposeBag()
    var markerView = UIImageView()
    private var venues: [Venues] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        didSwitchSegment()
        addMarkersToMap()
        setUpMapView()
        bindViewModel()
        setUpTableView()
        didTapOnSideMenu()
        viewModel?.viewDidLoad()
    }
    private func didTapOnSideMenu() {
        sideMenuBtn.rx.tap.subscribe(onNext: { [weak self] _ in
            self?.router?.goToSideMenu()
        }).disposed(by: disposeBag)
    }
    private func setUpTableView() {
        registerCell()
        bindVenuseData()
    }
    private func registerCell() {
        venuesTableView.register(UINib(nibName: "VenueCell", bundle: nil), forCellReuseIdentifier: "VenueCell")
        venuesTableView.rx.setDelegate(self).disposed(by: disposeBag)
        
    }
    private func bindVenuseData() {
        viewModel?.output.venues.bind(to: venuesTableView.rx.items(cellIdentifier: "VenueCell",cellType: VenueCell.self)) { (index, venue, cell) in
            cell.setUpCell(venue: venue)
        }.disposed(by: disposeBag)
    }
    private func bindViewModel() {
        viewModel?.output.errorMessage.asDriver(onErrorJustReturn: "").drive(onNext: { [weak self] message in
            self?.showToast(title: "", message: message, status: .error)
        }).disposed(by: disposeBag)
        viewModel?.output.showLoading.asDriver(onErrorJustReturn: false).drive(onNext: { [weak self] isLoading in
            guard let self = self else {return}
            self.showHud(showLoding: isLoading)
        }).disposed(by: disposeBag)
    }
    private func setUpMapView() {
        let camera = GMSCameraPosition.camera(withLatitude: 23.03359, longitude: 72.50938, zoom: 16)
        mapView.camera = camera
        mapView.delegate = self
        
    }
    private func didSwitchSegment() {
        segmentContoller.rx.selectedSegmentIndex
            .subscribe(onNext: { [weak self] index in
                switch index {
                case 0:
                    self?.venuesTableView.isHidden = false
                    self?.mapView.isHidden = true
                case 1:
                    self?.venuesTableView.isHidden = true
                    self?.mapView.isHidden = false
                default:
                    break
                }
            })
            .disposed(by: disposeBag)
    }
    private func addMarkersToMap() {
        viewModel?.output.venues.asDriver(onErrorJustReturn: []).drive(onNext: {[weak self] venues in
            self?.venues = venues
            for i in 0..<venues.count {
                self?.showMarker(location: venues[i].location, index: i)
            }
        }).disposed(by: disposeBag)
    }
    private func showMarker(location : Location?, index: Int){
        guard let lat = location?.lat, let lng = location?.lng else {return}
        let coordinator = CLLocationCoordinate2DMake(lat, lng)
        let marker = GMSMarker()
        marker.position = coordinator
        marker.accessibilityLabel = String(index)
        marker.map = mapView
    }
}
extension HomeViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        
    }
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        
    }
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        let view = ShadowView(frame: CGRect.init(x: 0, y: 0, width: 300, height: 120))
        view.backgroundColor = .clear
        let markerInfoWindow = MarkerInfoWindow.createMyClassView()
        if let markerIndex = Int(marker.accessibilityLabel ?? "") {
            markerInfoWindow.setUpView(venue: self.venues[markerIndex])
        }
        view.addSubview(markerInfoWindow)
        markerInfoWindow.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            markerInfoWindow.topAnchor.constraint(equalTo: view.topAnchor),
            markerInfoWindow.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            markerInfoWindow.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            markerInfoWindow.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        return view
    }
}
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

extension UIView {
    class func initFromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: self), owner: nil, options: nil)?[0] as! T
    }
}
