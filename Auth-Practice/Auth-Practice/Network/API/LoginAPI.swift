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
                completion(self.judgeLoginStatus(by: response.statusCode, response.data))
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension LoginAPI {
    private func judgeLoginStatus(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
        guard let decodedData = try? JSONDecoder().decode(BaseResponse<UserModel>.self, from: data) else {
            return .pathErr
        }
        
        switch statusCode {
        case 200: return .success(decodedData)
        case 400: return .requestErr(decodedData.message)
        case 500: return .serverErr
        default: return .networkFail
        }
    }
}
