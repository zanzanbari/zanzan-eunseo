//
//  UITextField+.swift
//  KakaoT-Practice
//
//  Created by 배은서 on 2022/03/06.
//

import UIKit

extension UITextField {
    func addLeftPadding(size: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: size, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = ViewMode.always
    }
}
