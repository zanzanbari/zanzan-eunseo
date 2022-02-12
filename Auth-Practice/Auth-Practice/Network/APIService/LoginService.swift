//
//  LoginService.swift
//  Auth-Practice
//
//  Created by 배은서 on 2022/02/13.
//

import Foundation

import Moya

enum LoginService {
    case login(param: LoginModel)
}

extension LoginService: TargetType {
    var baseURL: URL {
        return URL(string: NetworkConstant.baseURL)!
    }
    
    var path: String {
        switch self {
        case .login: return "/auth/login"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .login: return .post
        }
    }
    
    var task: Task {
        switch self {
        case .login(let param):
            return .requestJSONEncodable(param)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .login: return ["Content-Type" : "application/json"]
        }
    }
}
