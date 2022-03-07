//
//  PlaceCollectionViewCell.swift
//  KakaoT-Practice
//
//  Created by 배은서 on 2022/03/08.
//

import UIKit

import SnapKit
import Then

class PlaceCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let identifier = "PlaceCollectionViewCell"
    
    enum IconType {
        case home, company, empty
        
        var image: UIImage {
            switch self {
            case .home: return Image.home ?? UIImage()
            case .company: return Image.company ?? UIImage()
            case .empty: return UIImage()
            }
        }
    }
    
    var iconType: IconType = .empty {
        didSet {
            switch iconType {
            case .home: leftIcon.image = Image.home
            case .company: leftIcon.image = Image.company
            case .empty: leftIcon.isHidden = true
            }
        }
    }
    
    private let leftIcon = UIImageView()
    private let placeLabel = UILabel()
    
    private lazy var placeStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .fill
        $0.distribution = .fill
        $0.spacing = 6
        $0.addArrangedSubviews([leftIcon, placeLabel])
    }
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - InitUI
    
    private func configUI() {
        backgroundColor = Color.gray500
        contentView.layer.cornerRadius = 20
    }
    
    private func setupLayout() {
        addSubview(placeStackView)
        
        placeStackView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
