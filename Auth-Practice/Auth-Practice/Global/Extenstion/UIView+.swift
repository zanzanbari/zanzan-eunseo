//
//  UIView+.swift
//  Auth-Practice
//
//  Created by 배은서 on 2022/02/04.
//

import UIKit

extension UIView {
    public func addSubviews(_ view: [UIView]) {
        view.forEach { self.addSubview($0) }
    }
}
