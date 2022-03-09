//
//  LocationTextField.swift
//  KakaoT-Practice
//
//  Created by 배은서 on 2022/03/05.
//

import UIKit

import SnapKit
import Then

class LocationSearchTextField: UITextField {
    
    enum SearchType {
        case here, destination
        
        var leftIcon: UIImage {
            switch self {
            case .here: return Image.here ?? UIImage()
            case .destination: return Image.destination ?? UIImage()
            }
        }
    }
    
    var searchType: SearchType = .here {
        didSet {
            switch searchType {
            case .here: leftIcon.image = Image.here
            case .destination: leftIcon.image = Image.destination
            }
        }
    }
    
    private let leftIcon = UIImageView().then {
        $0.image = Image.here
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configUI() {
        textColor = Color.black100
        font = FontStyle.body1.font
        layer.cornerRadius = 25
        addLeftPadding(size: 44)
    }
    
    private func setupLayout() {
        addSubview(leftIcon)
        
        leftIcon.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(12)
            $0.centerY.equalToSuperview()
        }
    }
}
