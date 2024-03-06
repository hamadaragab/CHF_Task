//
//  HomeViewRepository.swift
//  CFH_Task
//
//  Created by Hamada Ragab on 03/03/2024.
//

import Foundation
import RxCocoa
import RxSwift
protocol HomeRepositoryProtocol: AnyObject {
    func getVenues(completion: @escaping (Result<[Venues], ErrorStatus>) -> Void)
}
class HomeRepository: HomeRepositoryProtocol {
    private let disposeBag = DisposeBag()
    func getVenues(completion: @escaping (Result<[Venues], ErrorStatus>) -> Void) {
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "ll", value: "23.0340847,72.5084728"),
            URLQueryItem(name: "client_id", value: "4EQRZPSGKBZGFSERGJY055FRW2OSPJRZYR4C3J0JN2CQQFIV"),
            URLQueryItem(name: "client_secret", value: "AJR4B5LLRONWAJWJJOACHAFLCWS2YJAZMGQNFFZQP0IB3THR"),
            URLQueryItem(name: "v", value: "20180910")
        ]
        NetworkServices.callAPI(withURL: URLS.BASE_URL, responseType: VenuesResponse.self, method: .GET, parameters: nil, queryItems: queryItems).subscribe(onNext: { response in
            if let isSuccess = response.meta?.code, isSuccess == 200 , let venues = response.response?.venues {
                completion(.success(venues))
            }else {
                completion(.failure(.VenuesNotFound))
            }
        },onError: { error in
            completion(.failure(.ErrorMessage(message: error.localizedDescription)))
        }).disposed(by: disposeBag)
    }
}
