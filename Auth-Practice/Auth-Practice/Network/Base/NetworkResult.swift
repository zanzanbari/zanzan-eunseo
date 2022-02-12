//
//  NetworkError.swift
//  Auth-Practice
//
//  Created by 배은서 on 2022/02/11.
//

import Foundation

enum NetworkResult<T> {
    case success(T)
    case requestErr(T)
    case pathErr
    case serverErr
    case networkFail
}

extension NetworkResult: CustomStringConvertible {
    var description: String {
        switch self {
        case .success(_): return "서버 통신 성공✨"
        case .requestErr(_): return "요청 에러🚨"
        case .pathErr: return "경로 에러🚨"
        case .serverErr: return "서버의 내부적 에러🚨"
        case .networkFail: return "네트워크 연결 실패🚨"
        }
    }
}
