//
//  Constant.swift
//  SwiftExample
//
//  Created by 200OK-IOS5 on 31/01/24.
//

import Foundation

enum screen {
    case login, product, storyBoard
    var indentifier: String {
        switch self {
          case .login: return "LoginScreen"
          case .product: return "ProductViewScreen"
          case .storyBoard: return "Main"
        }
    }
}

// for custom erors
struct ErrorModel: Codable {
    let code: String?
    let message: String?
}

enum ApiError: Error {
    case badURL
    case requestFailed
    case invalidResponse
    case decodingFailed
    case customError(ErrorModel)
    var errorDescription: String? {
        switch self {
        case .requestFailed:
            return "Server is not reachable"
        case .badURL:
            return "Not a valid URL"
        case .decodingFailed:
            return "Json failed"
        case .invalidResponse:
            return "Response type not a json"
        case .customError(let model):
            return model.message
        }
    }
}

class Constant {
    static let baseUrl = "https://dummyjson.com/"
    static let header  = "application/json"
    static let dummyuserName = "kminchelle"
    static let dummyPassword = "0lelplR"
    static let alert = "Alert"
    static let ok = "OK"
}

class AlertMessages {
    static let authError   = "Authentication Problem. Please check username & password."
    static let emptyField  = "Please enter username and password."
    static let problem     = "Something went wrong..!!"
    static let emptyUsername = "Please enter username."
    static let emptypassword = "Please enter username."
}

class NavigationTitle {
    static let products = "Products"
}

class UserDefaultKeys {
    static let authToken = "authToken"
}

struct ErrorInfo: Decodable {
    let message: String
}
