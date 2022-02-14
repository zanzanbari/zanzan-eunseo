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
    
    enum Const {
        static let invalidEmail = "올바르지 않은 이메일 형식입니다"
        static let notExistEmail = "존재하지 않는 이메일입니다"
        static let inputEmail = "이메일을 입력해주세요"
        static let checkPassword = "비밀번호를 확인해주세요"
        static let inputPassword = "비밀번호를 입력해주세요"
    }
    
    enum NetworkErrorMessage {
        static let notExistUser = "회원가입이 필요합니다."
        static let incorrectPassword = "비밀번호가 일치하지 않습니다."
    }

    // MARK: - Properties
    
    private var loginData = LoginModel()
    
    private let backButton = UIButton().then {
        $0.setImage(Image.back, for: .normal)
        $0.addTarget(self, action: #selector(touchupBackButton), for: .touchUpInside)
    }
    
    private let emailLoginLabel = UILabel().then {
        $0.text = "이메일 로그인"
        $0.textColor = Color.black000
        $0.font = FontStyle.title1.font
    }
    
    private let emailTextField = UITextField().then {
        $0.attributedPlaceholder = NSAttributedString(string: "이메일", attributes: [NSAttributedString.Key.foregroundColor : Color.gray ?? UIColor()])
    }
    
    private let passwordTextField = UITextField().then {
        $0.attributedPlaceholder = NSAttributedString(string: "비밀번호", attributes: [NSAttributedString.Key.foregroundColor : Color.gray ?? UIColor()])
        $0.isSecureTextEntry = true
    }
    
    private let emailLine = UIView()
    private let passwordLine = UIView()
    
    private let emailWarningLabel = UILabel()
    private let passwordWarningLabel = UILabel()
    
    private let emailDeleteButton = UIButton()
    private let passwordDeleteButton = UIButton()
    
    private let showPasswordButton = UIButton().then {
        $0.setImage(Image.lookInactive, for: .normal)
        $0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        $0.setContentCompressionResistancePriority(.required, for: .horizontal)
        $0.isHidden = true
        $0.addTarget(self, action: #selector(touchupShowPasswordButton), for: .touchUpInside)
    }
    
    private let loginButton = UIButton().then {
        $0.setTitle("로그인", for: .normal)
        $0.setTitleColor(Color.white, for: .normal)
        $0.titleLabel?.font = FontStyle.body3.font
        $0.backgroundColor = Color.black020
        $0.layer.cornerRadius = 4
        $0.addTarget(self, action: #selector(touchupLoginButton), for: .touchUpInside)
    }
    
    private let findPasswordButton = UIButton().then {
        $0.setTitle("비밀번호를 잊어버리셨나요?", for: .normal)
        $0.setTitleColor(Color.gray, for: .normal)
        $0.titleLabel?.font = FontStyle.body4.font
    }
    
    private lazy var emailStackView = UIStackView().then {
        $0.addArrangedSubviews([emailTextField, emailDeleteButton])
    }
    
    private lazy var passwordStackView = UIStackView().then {
        $0.addArrangedSubviews([passwordTextField, passwordDeleteButton, showPasswordButton])
    }
    
    private var isShowPasswordButtonSelected: Bool = false {
        didSet {
            let image = isShowPasswordButtonSelected ? Image.lookActive : Image.lookInactive
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
        view.backgroundColor = Color.white
        navigationController?.isNavigationBarHidden = true
        
        [emailTextField, passwordTextField].forEach {
            $0.font = FontStyle.body1.font
            $0.textColor = Color.black020
            $0.tintColor = Color.black020
            $0.delegate = self
        }
        
        [emailLine, passwordLine].forEach {
            $0.backgroundColor = Color.grayC4
        }
        
        [emailWarningLabel, passwordWarningLabel].forEach {
            $0.textColor = Color.red
            $0.font = FontStyle.body5.font
            $0.isHidden = true
        }
        
        [emailDeleteButton, passwordDeleteButton].forEach {
            $0.setImage(Image.delete, for: .normal)
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
                          emailWarningLabel,
                          passwordWarningLabel,
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
        
        emailWarningLabel.snp.makeConstraints {
            $0.top.equalTo(emailLine.snp.bottom).offset(4)
            $0.leading.equalToSuperview().inset(28)
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
        
        passwordWarningLabel.snp.makeConstraints {
            $0.top.equalTo(passwordLine.snp.bottom).offset(4)
            $0.leading.equalToSuperview().inset(28)
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
    
    @objc func touchupLoginButton() {
        resignTextFieldFirstResponder()
        
        if !emailTextField.hasText, !passwordTextField.hasText {
            updateWarning(emailTextField, message: Const.inputEmail)
            updateWarning(passwordTextField, message: Const.inputPassword)
        } else if !loginData.isValidEmail(email: emailTextField.text ?? "") {
            updateWarning(emailTextField, message: Const.invalidEmail)
            setupTextField(passwordTextField, lineColor: Color.grayC4 ?? UIColor(), isEmpty: nil)
        } else if !loginData.isValidPassword(password: passwordTextField.text ?? "") {
            updateWarning(passwordTextField, message: Const.checkPassword)
        } else {
            login(email: emailTextField.text ?? "", password: passwordTextField.text ?? "")
        }
    }
    
    // MARK: - Custom Method
    
    private func login(email: String, password: String) {
        loginData.email = email
        loginData.password = password
        
        LoginAPI.shared.postLogin(userData: loginData) { result in
            switch result {
            case .success(let data):
                guard let result = data as? BaseResponse<UserModel>, let userData = result.data else { return }
                
                let homeViewController = HomeViewController()
                homeViewController.nickname = userData.nickname
                self.navigationController?.pushViewController(homeViewController, animated: true)
            case .requestErr(let message):
                guard let errorMessage = message as? String else { return }
                self.handleRequestError(errorMessage: errorMessage)
            case .pathErr, .serverErr, .networkFail:
                print(self)
            }
        }
    }
    
    private func setupTextField(_ textField: UITextField, lineColor: UIColor, isEmpty: Bool?) {
        switch textField {
        case emailTextField:
            if let isEmailEmpty = isEmpty, !isEmailEmpty {
                emailDeleteButton.isHidden = false
                if emailLine.backgroundColor == Color.red {
                    return
                }
            } else {
                emailDeleteButton.isHidden = true
                updateWarning(emailTextField, message: nil)
            }
            emailLine.backgroundColor = lineColor
        case passwordTextField:
            if let isPasswordEmpty = isEmpty, !isPasswordEmpty {
                [passwordDeleteButton, showPasswordButton].forEach {
                    $0.isHidden = false
                }
                if passwordLine.backgroundColor == Color.red {
                    return
                }
            } else {
                [passwordDeleteButton, showPasswordButton].forEach {
                    $0.isHidden = true
                }
                updateWarning(passwordTextField, message: nil)
            }
            passwordLine.backgroundColor = lineColor
        default:
            return
        }
    }
    
    private func updateWarning(_ textField: UITextField, message: String?) {
        switch textField {
        case emailTextField:
            guard let message = message else {
                emailLine.backgroundColor = Color.black200
                emailWarningLabel.isHidden = true
                return
            }
            emailLine.backgroundColor = Color.red
            emailWarningLabel.isHidden = false
            emailWarningLabel.text = message
        case passwordTextField:
            guard let message = message else {
                passwordLine.backgroundColor = Color.black200
                passwordWarningLabel.isHidden = true
                return
            }
            passwordLine.backgroundColor = Color.red
            passwordWarningLabel.isHidden = false
            passwordWarningLabel.text = message
        default:
            return
        }
    }
    
    private func resignTextFieldFirstResponder() {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
    private func handleRequestError(errorMessage: String) {
        if errorMessage == NetworkErrorMessage.incorrectPassword {
            updateWarning(passwordTextField, message: Const.checkPassword)
        } else if errorMessage == NetworkErrorMessage.notExistUser {
            updateWarning(emailTextField, message: Const.notExistEmail)
        }
    }
}

//MARK: - UITextFieldDelegate

extension EmailLoginViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        setupTextField(textField, lineColor: Color.black200 ?? UIColor(), isEmpty: textField.text?.isEmpty)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        setupTextField(textField, lineColor: Color.grayC4 ?? UIColor(), isEmpty: nil)
        if emailTextField.hasText, !loginData.isValidEmail(email: emailTextField.text ?? "") {
            updateWarning(emailTextField, message: Const.invalidEmail)
            return
        }
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        setupTextField(textField, lineColor: Color.black200 ?? UIColor(), isEmpty: textField.text?.isEmpty)
    }
}
