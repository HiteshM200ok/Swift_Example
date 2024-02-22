//
//  EndPoints.swift
//  SwiftExample
//
//  Created by 200OK-IOS5 on 15/02/24.
//

import Foundation

enum BaseURLPath {
    case live
    case staging
    case development
    
    var path: String {
        switch self {
        case .live : return Constant.baseUrl
        case .staging: return Constant.baseUrl
        case .development: return Constant.baseUrl
        }
    }
}

enum APIEndPoints {
    case login
    case auth
    case products
    var url : String {
        switch self {
            case .login: return "auth/login"
            case .auth: return "auth/me"
            case .products: return "products"
        }
    }
}

enum HTTPMethodType: String {
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
}
