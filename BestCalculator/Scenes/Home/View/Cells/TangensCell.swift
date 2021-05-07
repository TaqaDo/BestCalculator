//
//  TangensCell.swift
//  BestCalculator
//
//  Created by talgar osmonov on 6/5/21.
//

import UIKit
import SnapKit

protocol TangensCellDelegate: AnyObject {
    func clickForTangensRow(item: TangensModel)
}

final class TangensCell: UICollectionViewCell {
    
    private weak var delegate: TangensCellDelegate?
    private var item: TangensModel?
    
    // MARK: - Views
    
    private lazy var label: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 26, weight: .light)
        view.textColor = .darkGray
        view.textAlignment = .center
        return view
    }()
    
    private lazy var gesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
    
    //
    
    // MARK: - Init
    
    override init(frame: CGRect = CGRect.zero) {
        super.init(frame: frame)
        configure()
        self.addGestureRecognizer(gesture)
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Actions
    
    @objc func viewTapped() {
        if let item = self.item {
            self.delegate?.clickForTangensRow(item: item)
        }
    }
    
    // MARK: - Private Methods
    
    private func configure() {
        backgroundColor = .clear
        addSubviews()
        addConstraints()
    }
    
    private func addSubviews() {
        contentView.addSubview(label)
    }
    
    private func addConstraints() {
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    func fill(model: TangensModel, delegate: TangensCellDelegate) {
        backgroundColor = model.colorHex
        label.text = model.title
        self.delegate = delegate
        self.item = model
    }
}

