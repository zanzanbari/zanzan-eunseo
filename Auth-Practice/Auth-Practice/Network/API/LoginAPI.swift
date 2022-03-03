//
//  LoginAPI.swift
//  Auth-Practice
//
//  Created by 배은서 on 2022/02/13.
//

import Foundation

import Moya

final class LoginAPI {
    
    // MARK: - Static Properties
    
    static let shared = LoginAPI()
    private init() { }
    
    // MARK: - Network Properties
    
    private let loginProvider = MoyaProvider<LoginService>()
    
    //MARK: - POST
    
    func postLogin(userData: LoginModel, completion: @escaping (NetworkResult<Any>)  -> ()) {
        let param = userData
        
        loginProvider.request(.login(param: param)) { result in
            switch result {
            case .success(let response):
                completion(self.judgeLoginStatus(by: response.statusCode, response.data, decodeType: UserModel.self))
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func postSocialLogin(socialLoginData: SocialLoginModel, completion: @escaping (NetworkResult<Any>) -> ()) {
        loginProvider.request(.socialLogin(param: socialLoginData)) { result in
            switch result {
            case .success(let response):
                completion(self.judgeLoginStatus(by: response.statusCode, response.data, decodeType: UserModel.self))
            case .failure(let error):
                print(error)
            }
        }
    }
    
    //MARK: - GET
    
    func getAccessToken(completion: @escaping (NetworkResult<Any>) -> ()) {
        loginProvider.request(.reissueToken) { result in
            switch result {
            case .success(let response):
                completion(self.judgeLoginStatus(by: response.statusCode, response.data, decodeType: SocialLoginModel.self))
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension LoginAPI {
    private func judgeLoginStatus<T: Codable>(by statusCode: Int, _ data: Data, decodeType: T.Type) -> NetworkResult<Any> {
        guard let decodedData = try? JSONDecoder().decode(BaseResponse<T>.self, from: data) else {
            return .pathErr
        }
        
        switch statusCode {
        case 200: return .success(decodedData)
        case 400: return .requestErr(decodedData.message)
        case 401: return .expireToken
        case 500: return .serverErr
        default: return .networkFail
        }
    }
}
