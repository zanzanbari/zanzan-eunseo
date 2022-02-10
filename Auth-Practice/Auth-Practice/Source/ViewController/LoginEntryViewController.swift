//
//  LoginEntryViewController.swift
//  Auth-Practice
//
//  Created by 배은서 on 2022/02/04.
//

import UIKit

import SnapKit
import Then

class LoginEntryViewController: UIViewController {
    
    // MARK: - Properties
    
    private let logoImageView = UIImageView().then {
        $0.image = Image.logo
    }
    
    private let kakaoLoginButton = AuthButton(authType: .kakao)
    private let naverLoginButton = AuthButton(authType: .naver)
    private let appleLoginButton = AuthButton(authType: .apple).then {
        $0.layer.borderWidth = 1
        $0.layer.borderColor = Color.black020?.cgColor
    }
    
    private let emailLoginButton = UIButton().then {
        $0.setTitle("이메일 로그인", for: .normal)
        $0.setTitleColor(Color.darkGray, for: .normal)
        $0.titleLabel?.font = FontStyle.body4.font
        $0.addTarget(self, action: #selector(touchupEmailLoginButton), for: .touchUpInside)
    }
    
    private let signupButton = UIButton().then {
        $0.setTitle("가입하기", for: .normal)
        $0.setTitleColor(Color.darkGray, for: .normal)
        $0.titleLabel?.font = FontStyle.body4.font
    }
    
    private let verticalLine = UIView().then {
        $0.backgroundColor = Color.gray
    }
    
    private lazy var socialLoginStackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .fill
        $0.distribution = .fillEqually
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
        view.backgroundColor = Color.white
    }
    
    private func setupLayout() {
        view.addSubviews([logoImageView,
                          socialLoginStackView,
                          emailLoginButton,
                          verticalLine,
                          signupButton])
        
        logoImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
        }
        
        socialLoginStackView.snp.makeConstraints {
            $0.top.equalTo(logoImageView.snp.bottom).offset(159)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(186)
        }
        
        emailLoginButton.snp.makeConstraints {
            $0.top.equalTo(socialLoginStackView.snp.bottom).offset(41)
            $0.trailing.equalTo(verticalLine.snp.leading).offset(-30)
        }
        
        verticalLine.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(30)
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
        let emailLoginViewController = EmailLoginViewController()
        navigationController?.pushViewController(emailLoginViewController, animated: true)
    }
}
