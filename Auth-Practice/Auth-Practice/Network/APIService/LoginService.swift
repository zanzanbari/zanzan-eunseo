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
    case reissueToken
}

extension LoginService: TargetType {
    var baseURL: URL {
        return URL(string: NetworkConstant.baseURL)!
    }
    
    var path: String {
        switch self {
        case .login: return "/auth/login"
        case .socialLogin(let param): return "/auth/\((param.socialType ?? .kakao).name )/login"
        case .reissueToken: return "/auth/reissue/token"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .login, .socialLogin: return .post
        case .reissueToken: return .get
        }
    }
    
    var task: Task {
        switch self {
        case .login(let param):
            return .requestJSONEncodable(param)
        case .socialLogin(let param):
            return .requestParameters(parameters: ["token" : param.accessToken], encoding: URLEncoding.queryString)
        case .reissueToken:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .login: return NetworkConstant.loginHeader
        case .socialLogin: return NetworkConstant.loginHeader
        case .reissueToken: return NetworkConstant.accessTokenHeader
        }
    }
}
