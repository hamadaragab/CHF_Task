//
//  File.swift
//  CFH_Task
//
//  Created by Hamada Ragab on 03/03/2024.
//

import Foundation
import RxSwift
import RxCocoa
protocol HomeViewModelProtocol: AnyObject {
    var input: HomeViewModel.Input {get}
    var output: HomeViewModel.Output {get}
    func viewDidLoad()
}

class HomeViewModel: HomeViewModelProtocol {
    var input: Input = .init()
    var output: Output = .init()
    private let repository: HomeRepositoryProtocol?
    private var venues: [Venues] = []
    init(repository: HomeRepositoryProtocol) {
        self.repository = repository
    }
    func viewDidLoad() {
        getVenues()
    }
    private func getVenues() {
        output.showLoading.onNext(true)
        repository?.getVenues(completion: { response in
            self.output.showLoading.onNext(false)
            switch response {
            case .success(let venues):
                self.venues = venues
                self.output.venues.onNext(venues)
            case .failure(let error):
                self.output.errorMessage.onNext(error.localizedDescription)
            }
        })
    }
}
extension HomeViewModel: BaseViewModel {
    struct Input {
        
    }
    class Output {
        let showLoading = PublishSubject<Bool>()
        let errorMessage = PublishSubject<String>()
        let venues = PublishSubject<[Venues]>()
    }
}

