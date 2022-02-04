//
//  UIStackView+.swift
//  Auth-Practice
//
//  Created by 배은서 on 2022/02/04.
//

import UIKit

extension UIStackView {
    public func addArrangedSubviews(_ view: [UIView]) {
        view.forEach { self.addArrangedSubview($0) }
    }
}
