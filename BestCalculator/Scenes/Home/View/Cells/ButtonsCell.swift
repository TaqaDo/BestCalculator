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
}

final class ButtonsCell: UICollectionViewCell {
    
    private weak var delegate: ButtonsCellDelegate?
    private var item: ButtonModel?
    
    // MARK: - Views
    
    private lazy var label: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 26, weight: .regular)
        view.textColor = .white
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
            self.delegate?.clickForRow(item: item)
        }
    }
    
    // MARK: - Private Methods
    
    private func configure() {
        backgroundColor = .systemPink
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
