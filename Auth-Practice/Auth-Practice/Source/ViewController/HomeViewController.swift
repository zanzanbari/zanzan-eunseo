//
//  HomeViewController.swift
//  Auth-Practice
//
//  Created by 배은서 on 2022/02/14.
//

import UIKit

import SnapKit
import Then

class HomeViewController: UIViewController {

    // MARK: - Properties
    
    var nickname: String?
    
    private let nicknameLabel = UILabel().then {
        $0.textColor = Color.black200
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setupLayout()
    }
    
    // MARK: - InitUI
    
    private func configUI() {
        view.backgroundColor = .white
        nicknameLabel.text = nickname
    }
    
    private func setupLayout() {
        view.addSubview(nicknameLabel)
        
        nicknameLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
