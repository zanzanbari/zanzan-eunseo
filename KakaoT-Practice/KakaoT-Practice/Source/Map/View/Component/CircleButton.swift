//
//  CircleButton.swift
//  KakaoT-Practice
//
//  Created by 배은서 on 2022/03/04.
//

import UIKit

class CircleButton: UIButton {
    
    var config = UIButton.Configuration.plain()

    init(image: UIImage, title: String?) {
        super.init(frame: .zero)
        config(image: image, title: title)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - InitUI
    
    private func config(image: UIImage, title: String?) {
        layer.cornerRadius = 20
        backgroundColor = Color.white
        config.buttonSize = .small
        config.image = image
        config.title = title
        config.baseBackgroundColor = Color.white
        config.baseForegroundColor = Color.navy100
        config.attributedTitle?.font = FontStyle.body7.font
        if title != nil {
            config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 13)
        }
        
        configuration = config
    }
}
