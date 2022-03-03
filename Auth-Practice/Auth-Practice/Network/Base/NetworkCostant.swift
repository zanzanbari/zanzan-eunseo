//
//  NetworkCostant.swift
//  Auth-Practice
//
//  Created by 배은서 on 2022/02/11.
//

import Foundation

struct NetworkConstant {
    static let baseURL = "https://asia-northeast3-zanzan-18f89.cloudfunctions.net/api"
    static let loginHeader = ["Content-Type" : "application/json"]
    static let accessTokenHeader = ["Content-Type" : "application/json",
                                    "accesstoken" : UserDefaults.standard.string(forKey: UserDefaultsKey.accessToken) ?? "",
                                    "refreshtoken" : UserDefaults.standard.string(forKey: UserDefaultsKey.refreshToken) ?? ""]
}
