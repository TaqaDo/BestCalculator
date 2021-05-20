//
//  File.swift
//  BestCalculator
//
//  Created by talgar osmonov on 20/5/21.
//

import Foundation
import UIKit
import SnapKit


 class HistoryCell: UITableViewCell {
    
    // MARK: - Views
    
    private lazy var inputLabel: UILabel = {
       let label = UILabel()
        label.text = "11"
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = .white
        return label
    }()
    
    private lazy var outputLabel: UILabel = {
       let label = UILabel()
        label.text = "33"
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = .lightGray
        return label
    }()
    
    //
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func configure() {
        backgroundColor = .mediumDark
        addSubviews()
        addConstraints()
    }
    
    private func addSubviews() {
        addSubview(inputLabel)
        addSubview(outputLabel)
    }
    
    private func addConstraints() {
        inputLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.leading.equalToSuperview().inset(10)
        }
        outputLabel.snp.makeConstraints { make in
            make.bottom.trailing.equalToSuperview().inset(10)
        }
    }
    
    func setupData(input: String, output: String) {
        self.inputLabel.text = input
        self.outputLabel.text = output
    }
}
