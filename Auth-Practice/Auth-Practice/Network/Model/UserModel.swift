//
//  UserModel.swift
//  Auth-Practice
//
//  Created by 배은서 on 2022/02/13.
//

import Foundation

struct UserModel: Codable {
    let nickname: String
    let accesstoken: String
    let refreshtoken: String
}
