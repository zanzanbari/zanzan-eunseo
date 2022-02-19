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
    case socialLogin(param: SocialLoginModel)
}

extension LoginService: TargetType {
    var baseURL: URL {
        return URL(string: NetworkConstant.baseURL)!
    }
    
    var path: String {
        switch self {
        case .login: return "/auth/login"
        case .socialLogin(let param): return "/auth/\(param.socialType.name)/login"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .login: return .post
        case .socialLogin: return .post
        }
    }
    
    var task: Task {
        switch self {
        case .login(let param):
            return .requestJSONEncodable(param)
        case .socialLogin(let param):
            return .requestParameters(parameters: ["token" : param.accessToken], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .login: return NetworkConstant.loginHeader
        case .socialLogin: return NetworkConstant.loginHeader
        }
    }
}
