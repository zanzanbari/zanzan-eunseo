//
//  SearchView.swift
//  KakaoT-Practice
//
//  Created by 배은서 on 2022/03/09.
//

import UIKit

import SnapKit
import Then

class SearchView: UIView {
    
    enum ViewType {
        case mapSearch, search
    }
    
    var viewType: ViewType = .mapSearch {
        didSet {
            switch viewType {
            case .mapSearch:
                setPlaceholder(hereTextField, placeholder: "현위치")
                setPlaceholder(destinationTextField, placeholder: "어디로 갈까요?")
                buttonStackView.isHidden = true
            case .search:
                setPlaceholder(hereTextField, placeholder: "출발지 검색")
                setPlaceholder(destinationTextField, placeholder: "도착지 검색")
                horizontalDivideView.isHidden = true
            }
        }
    }
    
    var placeList = ["집", "회사", "세브란스병원", "서울등명초등학교"]
    
    private let hereTextField = LocationSearchTextField().then {
        $0.searchType = .here
    }
    
    private let destinationTextField = LocationSearchTextField().then {
        $0.searchType = .destination
    }
    
    private let horizontalDivideView = UIView().then {
        $0.backgroundColor = Color.navy400
    }
    
    private let collectionViewLayout = UICollectionViewFlowLayout().then {
        $0.minimumLineSpacing = 10
        $0.minimumInteritemSpacing = 10
        $0.scrollDirection = .horizontal
    }
    
    private lazy var placeCollectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout).then {
        $0.backgroundColor = Color.white
        $0.isScrollEnabled = true
        $0.showsHorizontalScrollIndicator = false
        $0.register(PlaceCollectionViewCell.self, forCellWithReuseIdentifier: PlaceCollectionViewCell.identifier)
        $0.delegate = self
        $0.dataSource = self
    }

    private let hereButton = UIButton().then {
        $0.setImage(Image.location, for: .normal)
    }
    
    private let mapButton = UIButton().then {
        $0.setImage(Image.map, for: .normal)
    }
    
    private let verticalDivideView = UIView().then {
        $0.backgroundColor = Color.navy400
    }
    
    private lazy var buttonStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .fill
        $0.distribution = .fill
        $0.alignment = .center
        $0.spacing = 8
        $0.addArrangedSubviews([hereButton, verticalDivideView, mapButton])
    }
    
    private lazy var locationStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .fill
        $0.distribution = .fill
        $0.spacing = 116
        $0.addArrangedSubviews([placeCollectionView, buttonStackView])
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
        backgroundColor = Color.white
    }
    
    private func setupLayout() {
        addSubviews([hereTextField,
                     horizontalDivideView,
                     destinationTextField,
                     locationStackView])
        
        hereTextField.snp.makeConstraints {
            switch viewType {
            case .mapSearch: $0.top.equalToSuperview().inset(36)
            case .search: $0.top.equalToSuperview().inset(12)
            }
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        horizontalDivideView.snp.makeConstraints {
            $0.top.equalTo(hereTextField.snp.bottom).offset(12)
            $0.leading.trailing.equalTo(hereTextField)
            $0.height.equalTo(1)
        }
        
        destinationTextField.snp.makeConstraints {
            $0.top.equalTo(horizontalDivideView.snp.bottom).offset(12)
            $0.leading.trailing.equalTo(horizontalDivideView)
        }
        
        locationStackView.snp.makeConstraints {
            switch viewType {
            case .mapSearch: $0.top.equalTo(destinationTextField.snp.bottom).offset(20)
            case .search: $0.top.equalTo(destinationTextField.snp.bottom).offset(9)
            }
            $0.leading.equalTo(destinationTextField.snp.leading)
            $0.trailing.equalToSuperview()
        }
        
        [hereButton, mapButton].forEach {
            $0.snp.makeConstraints {
                $0.width.height.equalTo(40)
            }
        }
        
        verticalDivideView.snp.makeConstraints {
            $0.width.equalTo(1)
            $0.height.equalTo(24)
        }
    }
    
    private func setPlaceholder(_ textfield: UITextField, placeholder: String) {
        textfield.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: Color.gray200 ?? UIColor()])
    }
    
    private func calculateTextWidthSize(text: String) -> CGFloat {
        let label = UILabel()
        label.font = FontStyle.body6.font
        label.text = text
        label.sizeToFit()
        
        return label.frame.size.width
    }
}

extension SearchView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.backgroundColor = Color.navy400
    }
}

extension SearchView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch viewType {
        case .mapSearch: return placeList.count
        case .search: return 2
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlaceCollectionViewCell.identifier, for: indexPath) as? PlaceCollectionViewCell else { return UICollectionViewCell() }
        
        cell.placeName = placeList[indexPath.item]
        
        switch indexPath.item {
        case 0: cell.iconType = .home
        case 1: cell.iconType = .company
        default: cell.iconType = .empty
        }
        
        switch viewType {
        case .mapSearch: cell.backgroundColor = Color.gray500
        case .search: cell.backgroundColor = Color.white
        }
        
        return cell
    }
}

extension SearchView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var width: CGFloat
        
        switch indexPath.item {
        case 0, 1: width = calculateTextWidthSize(text: placeList[indexPath.item])  + 48 + 6
        default: width = calculateTextWidthSize(text: placeList[indexPath.item]) + 30
        }
        
        return CGSize(width: width, height: collectionView.frame.height)
    }
}
