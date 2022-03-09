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
    
    private let backButton = CircleButton(image: Image.back ?? UIImage(), title: nil)
    private let businessButton = CircleButton(image: Image.business ?? UIImage(), title: nil)
    private let bookingButton = CircleButton(image: Image.booking ?? UIImage(), title: "예약")
    private let locationButton = CircleButton(image: Image.location ?? UIImage(), title: nil)
    
    private let searchView = SearchView().then {
        $0.viewType = .mapSearch
        $0.layer.cornerRadius = 20
        $0.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setupLayout()
    }
    
    // MARK: - InitUI
    
    private func configUI() {
        view.backgroundColor = Color.gray200
    }
    
    private func setupLayout() {
        view.addSubviews([backButton,
                          businessButton,
                          bookingButton,
                          locationButton,
                          searchView])
        
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
    }
    
    // MARK: - Custom Method


}
