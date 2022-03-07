//
//  MapSearchViewController.swift
//  KakaoT-Practice
//
//  Created by 배은서 on 2022/03/04.
//

import UIKit

import SnapKit
import Then

class MapSearchViewController: UIViewController {
    
    // MARK: - Properties
    
    private let placeList = ["집", "회사", "세브란스병원", "서울등명초등학교"]
    
    private let backButton = CircleButton(image: Image.back ?? UIImage(), title: nil)
    private let businessButton = CircleButton(image: Image.business ?? UIImage(), title: nil)
    private let bookingButton = CircleButton(image: Image.booking ?? UIImage(), title: "예약")
    private let locationButton = CircleButton(image: Image.location ?? UIImage(), title: nil)
    
    private let searchView = UIView().then {
        $0.backgroundColor = Color.white
        $0.layer.cornerRadius = 20
        $0.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
    }
    
    private let hereTextField = LocationSearchTextField().then {
        $0.searchType = .here
        $0.attributedPlaceholder = NSAttributedString(string: "현위치", attributes: [NSAttributedString.Key.foregroundColor: Color.gray200 ?? UIColor()])
    }
    private let destinationTextField = LocationSearchTextField().then {
        $0.searchType = .destination
        $0.attributedPlaceholder = NSAttributedString(string: "어디로 갈까요?", attributes: [NSAttributedString.Key.foregroundColor: Color.gray200 ?? UIColor()])
    }
    
    private let seperatorView = UIView().then {
        $0.backgroundColor = Color.gray400
    }
    
    private let collectionViewLayout = UICollectionViewFlowLayout().then {
        $0.minimumLineSpacing = 10
    }
    
    private lazy var placeCollectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout).then {
        $0.backgroundColor = Color.white
        $0.isScrollEnabled = true
//        $0.register(PlaceCollectionViewCell.self, forCellWithReuseIdentifier: PlaceCollectionViewCell.identifier)
//        $0.delegate = self
//        $0.dataSource = self
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setupLayout()
    }
    
    // MARK: - InitUI
    
    private func configUI() {
//        view.backgroundColor = Color.gray300
    }
    
    private func setupLayout() {
        view.addSubviews([backButton,
                          businessButton,
                          bookingButton,
                          locationButton,
                          searchView,
                          hereTextField,
                          seperatorView,
                          destinationTextField,
                          placeCollectionView])
        
        backButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.leading.equalToSuperview().inset(12)
            $0.height.width.equalTo(40)
        }
        
        businessButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.trailing.equalToSuperview().inset(12)
            $0.height.width.equalTo(40)
        }
        
        bookingButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(12)
            $0.bottom.equalTo(searchView.snp.top).offset(-16)
            $0.height.equalTo(40)
        }
        
        locationButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(12)
            $0.bottom.equalTo(searchView.snp.top).offset(-16)
            $0.height.width.equalTo(40)
        }
        
        searchView.snp.makeConstraints {
            $0.leading.bottom.trailing.equalToSuperview()
            $0.height.equalTo(226)
        }
        
        hereTextField.snp.makeConstraints {
            $0.top.equalTo(searchView.snp.top).offset(36)
            $0.leading.trailing.equalTo(searchView).inset(20)
        }
        
        seperatorView.snp.makeConstraints {
            $0.top.equalTo(hereTextField.snp.bottom).offset(12)
            $0.leading.trailing.equalTo(hereTextField)
            $0.height.equalTo(1)
        }
        
        destinationTextField.snp.makeConstraints {
            $0.top.equalTo(seperatorView.snp.bottom).offset(12)
            $0.leading.trailing.equalTo(searchView).inset(20)
        }
        
        placeCollectionView.snp.makeConstraints {
            $0.top.equalTo(destinationTextField.snp.bottom).offset(20)
            $0.leading.equalTo(destinationTextField)
        }
    }
    
    // MARK: - Custom Method


}

//extension SearchViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//    }
//}
//
//extension SearchViewController: UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//    }
//}

