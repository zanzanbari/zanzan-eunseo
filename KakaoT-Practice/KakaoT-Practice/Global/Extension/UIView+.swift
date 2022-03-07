//
//  UIView+.swift
//  KakaoT-Practice
//
//  Created by 배은서 on 2022/03/05.
//

import UIKit

extension UIView {
    public func addSubviews(_ view: [UIView]) {
        view.forEach { self.addSubview($0) }
    }
}
