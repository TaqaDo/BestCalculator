//
//  ResultView.swift
//  BestCalculator
//
//  Created by talgar osmonov on 4/5/21.
//

import SnapKit
import UIKit

protocol ResultViewLogic: UIView {
    func getInputLabel() -> UILabel
    func getOutputLabel() -> UILabel
}

final class ResultView: UIView {
    
    // MARK: - Views
    
    private lazy var inputLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 76, weight: .light)
        label.textAlignment = .right
        label.textColor = .white
        label.sizeToFit()
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.1
        return label
    }()
    
    private lazy var outputLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 56, weight: .light)
        label.textAlignment = .right
        label.textColor = .systemGreen
        label.sizeToFit()
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.1
        return label
    }()
    
    private lazy var tempLabel: UILabel = {
        let label = UILabel()
        label.text = "Градусы"
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textAlignment = .left
        label.textColor = .lightGray
        return label
    }()
    
    private lazy var settingsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("≡", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        button.tintColor = .lightGray
        return button
    }()
    
    private lazy var navView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.addSubview(tempLabel)
        view.addSubview(settingsButton)
        
        tempLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview().inset(10)
        }
        
        settingsButton.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.trailing.equalToSuperview().inset(10)
        }
        
        return view
    }()
    
    //
    
    // MARK: - Init
    
    override init(frame: CGRect = CGRect.zero) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func configure() {
        backgroundColor = .init(hex: "#343d52")
        addSubviews()
        addConstraints()
    }
    
    private func addSubviews() {
        addSubview(inputLabel)
        addSubview(outputLabel)
        addSubview(navView)
    }
    
    private func addConstraints() {
        navView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(30)
        }
        inputLabel.snp.makeConstraints { make in
            make.top.equalTo(navView.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalToSuperview().dividedBy(2.25)
        }
        outputLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(inputLabel.snp.bottom)
        }
    }
}

// MARK: - OrdersViewLogic

extension ResultView: ResultViewLogic {
    func getInputLabel() -> UILabel {
        return inputLabel
    }
    
    func getOutputLabel() -> UILabel {
        return outputLabel
    }
}


