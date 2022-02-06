//
//  EmailLoginViewController.swift
//  Auth-Practice
//
//  Created by 배은서 on 2022/02/04.
//

import UIKit

import SnapKit
import Then

class EmailLoginViewController: UIViewController {

    // MARK: - Properties
    
    private let backButton = UIButton().then {
        $0.setImage(Const.image.back, for: .normal)
        $0.addTarget(self, action: #selector(touchupBackButton), for: .touchUpInside)
    }
    
    private let emailLoginLabel = UILabel().then {
        $0.text = "이메일 로그인"
        $0.textColor = Const.color.black000
        $0.font = .systemFont(ofSize: 23)
    }
    
    private let emailTextField = UITextField().then {
        $0.placeholder = "이메일"
    }
    
    private let passwordTextField = UITextField().then {
        $0.placeholder = "비밀번호"
        $0.isSecureTextEntry = true
    }
    
    private let emailLine = UIView()
    private let passwordLine = UIView()
    
    private let emailDeleteButton = UIButton()
    private let passwordDeleteButton = UIButton()
    
    private let showPasswordButton = UIButton().then {
        $0.setImage(Const.image.lookInactive, for: .normal)
        $0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        $0.setContentCompressionResistancePriority(.required, for: .horizontal)
        $0.isHidden = true
        $0.addTarget(self, action: #selector(touchupShowPasswordButton), for: .touchUpInside)
    }
    
    private let loginButton = UIButton().then {
        $0.setTitle("로그인", for: .normal)
        $0.setTitleColor(Const.color.white, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 17)
        $0.backgroundColor = Const.color.black020
        $0.layer.cornerRadius = 4
    }
    
    private let findPasswordButton = UIButton().then {
        $0.setTitle("비밀번호를 잊어버리셨나요?", for: .normal)
        $0.setTitleColor(Const.color.gray, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 15)
    }
    
    private lazy var emailStackView = UIStackView().then {
        $0.addArrangedSubviews([emailTextField, emailDeleteButton])
    }
    
    private lazy var passwordStackView = UIStackView().then {
        $0.addArrangedSubviews([passwordTextField, passwordDeleteButton, showPasswordButton])
    }
    
    private var isShowPasswordButtonSelected: Bool = false {
        didSet {
            let image = isShowPasswordButtonSelected ? Const.image.lookActive : Const.image.lookInactive
            showPasswordButton.setImage(image, for: .normal)
            passwordTextField.isSecureTextEntry = isShowPasswordButtonSelected ? false : true
        }
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
        navigationController?.isNavigationBarHidden = true
        
        [emailTextField, passwordTextField].forEach {
            $0.textColor = Const.color.black020
            $0.delegate = self
        }
        
        [emailLine, passwordLine].forEach {
            $0.backgroundColor = Const.color.grayC4
        }
        
        [emailDeleteButton, passwordDeleteButton].forEach {
            $0.setImage(Const.image.delete, for: .normal)
            $0.setContentCompressionResistancePriority(.required, for: .horizontal)
            $0.isHidden = true
            $0.addTarget(self, action: #selector(touchupDeleteButton(_:)), for: .touchUpInside)
        }
        
        [emailStackView, passwordStackView].forEach {
            $0.axis = .horizontal
            $0.alignment = .fill
            $0.distribution = .fill
        }
    }
    
    private func setupLayout() {
        view.addSubviews([backButton,
                          emailLoginLabel,
                          emailStackView,
                          passwordStackView,
                          emailLine,
                          passwordLine,
                          loginButton,
                          findPasswordButton])
        
        backButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(6)
            $0.leading.equalToSuperview().inset(4)
        }
        
        emailLoginLabel.snp.makeConstraints {
            $0.top.equalTo(backButton.snp.bottom).offset(25)
            $0.leading.equalToSuperview().inset(20)
        }
        
        emailStackView.snp.makeConstraints {
            $0.top.equalTo(emailLoginLabel.snp.bottom).offset(42)
            $0.leading.equalToSuperview().inset(28)
            $0.trailing.equalToSuperview().inset(20)
        }
        
        emailLine.snp.makeConstraints {
            $0.top.equalTo(emailStackView.snp.bottom)
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalTo(emailStackView)
            $0.height.equalTo(1)
        }
        
        passwordStackView.snp.makeConstraints {
            $0.top.equalTo(emailLine.snp.bottom).offset(42)
            $0.leading.equalToSuperview().inset(28)
            $0.trailing.equalToSuperview().inset(20)
        }
        
        passwordLine.snp.makeConstraints {
            $0.top.equalTo(passwordStackView.snp.bottom)
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalTo(passwordStackView)
            $0.height.equalTo(1)
        }
        
        loginButton.snp.makeConstraints {
            $0.top.equalTo(passwordLine.snp.bottom).offset(81)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(54)
        }
        
        findPasswordButton.snp.makeConstraints {
            $0.top.equalTo(loginButton.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }
    }
    
    // MARK: - @objc
    
    @objc func touchupBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func touchupDeleteButton(_ sender: UIButton) {
        if sender == emailDeleteButton {
            emailTextField.text = ""
        } else {
            passwordTextField.text = ""
        }
    }
    
    @objc func touchupShowPasswordButton() {
        isShowPasswordButtonSelected.toggle()
    }
    
    // MARK: - Custom Method
    
    private func setupTextField(_ textField: UITextField, lineColor: UIColor, isEmpty: Bool?) {
        switch textField {
        case emailTextField:
            if let isEmailEmpty = isEmpty {
                emailDeleteButton.isHidden = isEmailEmpty ? true : false
            } else {
                emailDeleteButton.isHidden = true
            }
            emailLine.backgroundColor = lineColor
            return
        case passwordTextField:
            if let isPasswordEmpty = isEmpty {
                [passwordDeleteButton, showPasswordButton].forEach {
                    $0.isHidden = isPasswordEmpty ? true : false
                }
            } else {
                [passwordDeleteButton, showPasswordButton].forEach {
                    $0.isHidden = true
                }
            }
            passwordLine.backgroundColor = lineColor
            return
        default:
            return
        }
    }
}

extension EmailLoginViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        setupTextField(textField, lineColor: Const.color.black200 ?? UIColor(), isEmpty: textField.text?.isEmpty)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        setupTextField(textField, lineColor: Const.color.grayC4 ?? UIColor(), isEmpty: nil)
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        setupTextField(textField, lineColor: Const.color.black200 ?? UIColor(), isEmpty: textField.text?.isEmpty)
    }
}
