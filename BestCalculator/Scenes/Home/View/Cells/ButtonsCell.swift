//
//  ButtonsCell.swift
//  BestCalculator
//
//  Created by talgar osmonov on 4/5/21.
//

import UIKit
import SnapKit

protocol ButtonsCellDelegate: AnyObject {
    func clickForRow(item: ButtonModel)
    func longClickRow(item: ButtonModel)
}

final class ButtonsCell: UICollectionViewCell {
    
    private weak var delegate: ButtonsCellDelegate?
    private var item: ButtonModel?
    
    // MARK: - Views
    
    private lazy var label: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 26, weight: .light)
        view.textColor = .white
        view.textAlignment = .center
        return view
    }()
    
    private lazy var gesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
    private lazy var longGesture: UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(viewLongTapped))
    
    //
    
    // MARK: - Init
    
    override init(frame: CGRect = CGRect.zero) {
        super.init(frame: frame)
        configure()
        
        self.addGestureRecognizer(gesture)
        self.addGestureRecognizer(longGesture)
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Actions
    
    @objc func viewLongTapped() {
        if let item = self.item {
            self.delegate?.longClickRow(item: item)
        }
    }
    
    @objc func viewTapped() {
        if let item = self.item {
            self.delegate?.clickForRow(item: item)
        }
    }
    
    // MARK: - Private Methods
    
    private func configure() {
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
    
    func fill(model: ButtonModel, delegate: ButtonsCellDelegate) {
        backgroundColor = UIColor.init(hex: model.colorHex ?? "#000000")
        label.text = model.title
        self.delegate = delegate
        self.item = model
    }
}
