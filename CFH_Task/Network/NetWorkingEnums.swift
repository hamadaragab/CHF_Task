//
//  NetWorkingEnums.swift
//  CFH_Task
//
//  Created by Hamada Ragab on 04/03/2024.
//

import Foundation
enum HttpMethod: String {
    case POST = "Post"
    case GET = "Get"
    case DELETE = "Delete"
    case PUT = "Put"
    
}
enum APIError: Error {
    case invalidURL
    case invalidResponse
    case requestFailed
    case jsonParsingFailed
}
