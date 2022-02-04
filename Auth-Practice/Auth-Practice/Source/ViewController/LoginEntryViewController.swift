//
//  LoginEntryViewController.swift
//  Auth-Practice
//
//  Created by 배은서 on 2022/02/04.
//

import UIKit

import SnapKit
import Then
import Alamofire

class LoginEntryViewController: UIViewController {
    
    // MARK: - Properties
    
    private let logoImageView = UIImageView().then {
        $0.image = Const.image.logo
    }
    
    private let kakaoLoginButton = UIButton().then {
        var config = UIButton.Configuration.plain()
        config.title = "카카오 로그인"
        config.baseForegroundColor = Const.color.black
        config.image = Const.image.kakao
        config.imagePadding = 80
        config.contentInsets = NSDirectionalEdgeInsets(top: 13, leading: 18, bottom: 14, trailing: 122)
        $0.configuration = config
        $0.backgroundColor = Const.color.yellow100
        $0.titleLabel?.font = .systemFont(ofSize: 17)
        $0.layer.cornerRadius = 5
    }
    
    private let naverLoginButton = UIButton().then {
        var config = UIButton.Configuration.plain()
        config.title = "네이버 로그인"
        config.baseForegroundColor = Const.color.white
        config.image = Const.image.naver
        config.imagePadding = 80
        config.contentInsets = NSDirectionalEdgeInsets(top: 13, leading: 18, bottom: 14, trailing: 122)
        $0.configuration = config
        $0.backgroundColor = Const.color.green
        $0.titleLabel?.font = .systemFont(ofSize: 17)
        $0.layer.cornerRadius = 5
    }
    
    private let appleLoginButton = UIButton().then {
        var config = UIButton.Configuration.plain()
        config.title = "Apple 로그인"
        config.baseForegroundColor = Const.color.black
        config.image = Const.image.apple
        config.imagePadding = 80
        config.contentInsets = NSDirectionalEdgeInsets(top: 13, leading: 18, bottom: 14, trailing: 122)
        $0.configuration = config
        $0.backgroundColor = Const.color.white
        $0.titleLabel?.font = .systemFont(ofSize: 17)
        $0.layer.borderWidth = 1
        $0.layer.borderColor = Const.color.black?.cgColor
        $0.layer.cornerRadius = 5
    }
    
    private let emailLoginButton = UIButton().then {
        $0.setTitle("이메일 로그인", for: .normal)
        $0.setTitleColor(Const.color.darkGray, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 15)
        $0.addTarget(self, action: #selector(touchupEmailLoginButton), for: .touchUpInside)
    }
    
    private let signupButton = UIButton().then {
        $0.setTitle("가입하기", for: .normal)
        $0.setTitleColor(Const.color.darkGray, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 15)
    }
    
    private let verticalLine = UIView().then {
        $0.backgroundColor = Const.color.gray
    }
    
    private lazy var socialLoginStackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .fill
        $0.distribution = .fill
        $0.spacing = 15
        $0.addArrangedSubviews([kakaoLoginButton, naverLoginButton, appleLoginButton])
    }

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setupLayout()
    }
    
    // MARK: - InitUI
    
    private func configUI() {
        view.backgroundColor = Const.color.white
    }
    
    private func setupLayout() {
        view.addSubviews([logoImageView,
                          socialLoginStackView,
                          emailLoginButton,
                          verticalLine,
                          signupButton])
        
        logoImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(159)
            $0.centerX.equalToSuperview()
        }
        
        socialLoginStackView.snp.makeConstraints {
            $0.top.equalTo(logoImageView.snp.bottom).offset(159)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        emailLoginButton.snp.makeConstraints {
            $0.top.equalTo(socialLoginStackView.snp.bottom).offset(41)
            $0.trailing.equalTo(verticalLine.snp.leading).offset(-30)
        }
        
        verticalLine.snp.makeConstraints {
            $0.centerY.equalTo(emailLoginButton.snp.centerY)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(20)
            $0.width.equalTo(1)
        }
        
        signupButton.snp.makeConstraints {
            $0.top.equalTo(socialLoginStackView.snp.bottom).offset(41)
            $0.leading.equalTo(verticalLine.snp.trailing).offset(30)
        }
    }
    
    // MARK: - @objc
    
    @objc func touchupEmailLoginButton() {
        
    }
}
