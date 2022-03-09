//
//  Font.swift
//  KakaoT-Practice
//
//  Created by 배은서 on 2022/03/09.
//

import UIKit

enum FontStyle {
    case body1
    case body2
    case body3
    case body4
    case body5
    case body6
    case body7
    case body8
    case body9
}

extension FontStyle {
    var font: UIFont {
        switch self {
        case .body1: return .systemFont(ofSize: 17, weight: .regular)
        case .body2: return .systemFont(ofSize: 16, weight: .regular)
        case .body3: return .systemFont(ofSize: 16, weight: .regular)
        case .body4: return .systemFont(ofSize: 15, weight: .regular)
        case .body5: return .systemFont(ofSize: 14, weight: .medium)
        case .body6: return .systemFont(ofSize: 14, weight: .regular)
        case .body7: return .systemFont(ofSize: 13, weight: .regular)
        case .body8: return .systemFont(ofSize: 12, weight: .regular)
        case .body9: return .systemFont(ofSize: 10, weight: .regular)
        }
    }
    
    var kern: Double {
        switch self {
        case .body1, .body4, .body7: return 0
        case .body2: return -0.04
        case .body3, .body5: return -0.06
        case .body6, .body8: return -0.05
        case .body9: return -0.15
        }
    }
}
