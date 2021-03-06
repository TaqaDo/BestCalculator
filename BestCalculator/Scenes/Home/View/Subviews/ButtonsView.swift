//
//  ButtonsView.swift
//  BestCalculator
//
//  Created by talgar osmonov on 4/5/21.
//

import SnapKit
import UIKit

protocol ButtonsDelegate: AnyObject {
    func swipeLeft()
}

protocol ButtonsViewLogic: UIView {
    func setCollectionView(withDataSourceAndDelegate: UICollectionViewDelegate & UICollectionViewDataSource) -> UICollectionView
    func getCollectionView() -> UICollectionView
    var delegate: ButtonsDelegate? {get set}
}

final class ButtonsView: UIView {
    
     weak var delegate: ButtonsDelegate?
    
    // MARK: - Views
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collView.register(ButtonsCell.self, forCellWithReuseIdentifier: ButtonsCell.cellID)
        collView.backgroundColor = .init(hex: "717786")
        collView.isScrollEnabled = false
        return collView
    }()
    
    private lazy var swipeLeft: UISwipeGestureRecognizer = {
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeLeftGesture))
        swipe.direction = .left
        return swipe
    }()
       
    
    //
    
    // MARK: - Init
    
    override init(frame: CGRect = CGRect.zero) {
        super.init(frame: frame)
        configure()
        self.addGestureRecognizer(swipeLeft)
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Actions
    
    @objc func swipeLeftGesture() {
        delegate?.swipeLeft()
    }
    
    // MARK: - Private Methods
    
    private func configure() {
        backgroundColor = .clear
        addSubviews()
        addConstraints()
    }
    
    private func addSubviews() {
        addSubview(collectionView)
    }
    
    private func addConstraints() {
        collectionView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
}

// MARK: - OrdersViewLogic

extension ButtonsView: ButtonsViewLogic {
    func setCollectionView(withDataSourceAndDelegate: UICollectionViewDataSource & UICollectionViewDelegate) -> UICollectionView {
        collectionView.delegate = withDataSourceAndDelegate
        collectionView.dataSource = withDataSourceAndDelegate
        return collectionView
    }
    
    func getCollectionView() -> UICollectionView {
        return collectionView
    }
    
}


