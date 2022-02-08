//
//  Font.swift
//  Auth-Practice
//
//  Created by 배은서 on 2022/02/08.
//

import UIKit

struct FontDescription {
    let font: Font
    let size: CGFloat
//    let style: UIFont.TextStyle
}

enum FontStyle {
    case title1 // 23pt, Medium
    
    case body1  // 17pt, Regular
    case body2  // 17pt, Medium
    case body3  // 17pt, SemiBold
    case body4  // 15pt, Medium
    case body5  // 14pt, Regular
}

extension FontStyle {
    private var fontDescription: FontDescription {
        switch self {
        case .title1:
            return FontDescription(font: .medium, size: 23)
        case .body1:
            return FontDescription(font: .regular, size: 17)
        case .body2:
            return FontDescription(font: .medium, size: 17)
        case .body3:
            return FontDescription(font: .semiBold, size: 17)
        case .body4:
            return FontDescription(font: .medium, size: 15)
        case .body5:
            return FontDescription(font: .regular, size: 14)
        }
    }
}

extension FontStyle {
    var font: UIFont {
        guard let font = UIFont(name: fontDescription.font.name, size: fontDescription.size) else {
            return UIFont()
        }
        return font
    }
}
