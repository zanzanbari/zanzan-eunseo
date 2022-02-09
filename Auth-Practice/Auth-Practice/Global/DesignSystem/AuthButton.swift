//
//  AuthButton.swift
//  Auth-Practice
//
//  Created by 배은서 on 2022/02/09.
//

import UIKit

import SnapKit

class AuthButton: UIButton {
    
    enum AuthType {
        case kakao
        case naver
        case apple
        
        var name: String {
            switch self {
            case .kakao: return "카카오 로그인"
            case .naver: return "네이버 로그인"
            case .apple: return "Apple로 로그인"
            }
        }
        
        var leftImage: UIImage {
            switch self {
            case .kakao: return Image.kakao ?? UIImage()
            case .naver: return Image.naver ?? UIImage()
            case .apple: return Image.apple ?? UIImage()
            }
        }
        
        var backgroundColor: UIColor {
            switch self {
            case .kakao: return Color.yellow100 ?? UIColor()
            case .naver: return Color.green ?? UIColor()
            case .apple: return Color.white ?? UIColor()
            }
        }
        
        var titleColor: UIColor {
            switch self {
            case .kakao: return Color.black000 ?? UIColor()
            case .naver: return Color.white ?? UIColor()
            case .apple: return Color.black000 ?? UIColor()
            }
        }
    }
    
    private let leftImageView = UIImageView()

    init(authType: AuthType) {
        super.init(frame: .zero)
        configUI(authType: authType)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configUI(authType: AuthType) {
        setTitle(authType.name, for: .normal)
        setTitleColor(authType.titleColor, for: .normal)
        titleLabel?.font = FontStyle.body2.font
        backgroundColor = authType.backgroundColor
        leftImageView.image = authType.leftImage
        layer.cornerRadius = 12
    }
    
    private func setupLayout() {
        addSubview(leftImageView)
        
        leftImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(18)
            $0.centerY.equalToSuperview()
        }
    }
    
}
