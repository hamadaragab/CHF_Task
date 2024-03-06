//
//  NetworkServices.swift
//  Yabraa
//
//  Created by Hamada Ragab on 06/03/2023.
//

import Foundation
import RxSwift


class NetworkServices {
    class func callAPI<T: Decodable>(withURL url: String, responseType: T.Type,method: HttpMethod, parameters: [String:Any?]?, queryItems: [URLQueryItem]?) -> Observable<T> {
        guard let fullURL = getFullURL(url, queryItems) else {
            return Observable.error(APIError.invalidURL)
        }
        var request = URLRequest(url: fullURL)
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let parameters = parameters {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                print(error)
            }
        }
        return URLSession.shared.rx.response(request: request)
            .map { response, data in
                guard 200..<300 ~= response.statusCode else {
                    throw APIError.requestFailed
                }
                return data
            }
            .map { data in
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(T.self, from: data)
                    return response
                } catch (let error){
                    print(error)
                    throw APIError.jsonParsingFailed
                }
            }
            .asObservable()
    }
    class func getFullURL(_ url: String, _ queryItems: [URLQueryItem]?) -> URL? {
        if let queryItems = queryItems, var components = URLComponents(string: url) {
            components.queryItems = queryItems
            guard let url = components.url else {
                fatalError("Failed to construct URL")
            }
            return url
        }else if let url = URL(string: url) {
            return url
        }
        return nil
    }
    
}
