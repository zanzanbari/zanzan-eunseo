//
//  SocialLoginModel.swift
//  Auth-Practice
//
//  Created by 배은서 on 2022/02/19.
//

import Foundation

enum SocialType {
    case kakao, naver, apple
    
    var name: String {
        switch self {
        case .kakao: return "kakao"
        case .naver: return "naver"
        case .apple: return "apple"
        }
    }
}

struct SocialLoginModel {
    let socialType: SocialType
    let accessToken: String
}
