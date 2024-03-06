//
//  ErrorStatus.swift
//  CFH_Task
//
//  Created by Hamada Ragab on 03/03/2024.
//

import Foundation
enum ErrorStatus:Error {
    case ErrorSavingUser
    case UserNotExist
    case VenuesNotFound
    case ErrorMessage(message:String)
    var localizedDescription: String {
        switch self {
        case .ErrorSavingUser:
            return "something is wrong while saving user data"
        case .UserNotExist:
            return "user not found"
        case .VenuesNotFound:
            return "there are no Venues Found"
        case .ErrorMessage(let message):
            return message
        }
    }
}
