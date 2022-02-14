//
//  BaseResponse.swift
//  Auth-Practice
//
//  Created by 배은서 on 2022/02/11.
//

import Foundation

struct BaseResponse<T: Decodable>: Decodable {
    let status: Int
    let success: Bool
    let message: String
    let data: T?
}
