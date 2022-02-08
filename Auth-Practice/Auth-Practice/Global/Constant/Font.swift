//
//  Font.swift
//  Auth-Practice
//
//  Created by 배은서 on 2022/02/08.
//

import Foundation

enum Font: String {
    case regular = "Pretendard-Regular"
    case medium = "Pretendard-Medium"
    case semiBold = "Pretendard-SemiBold"
    
    var name: String {
        return self.rawValue
    }
}
