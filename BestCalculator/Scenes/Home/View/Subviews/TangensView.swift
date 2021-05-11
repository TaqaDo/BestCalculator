//
//  tangensView.swift
//  BestCalculator
//
//  Created by talgar osmonov on 6/5/21.
//

import SnapKit
import UIKit

protocol TangensDelegate: AnyObject {
    func swipeRight()
}

protocol TangensViewLogic: UIView {
    func setCollectionView(withDataSourceAndDelegate: UICollectionViewDelegate & UICollectionViewDataSource) -> UICollectionView
    func getCollectionView() -> UICollectionView
    var delegate: TangensDelegate? {get set}
}

final class TangensView: UIView {
    
    weak var delegate: TangensDelegate?
    
    // MARK: - Views
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collView.register(TangensCell.self, forCellWithReuseIdentifier: TangensCell.cellID)
        collView.backgroundColor = .green
        collView.isScrollEnabled = false
        return collView
    }()
    
    private lazy var swipeRight: UISwipeGestureRecognizer = {
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeRightGesture))
        swipe.direction = .right
        return swipe
    }()
    
    //
    
    // MARK: - Init
    
    override init(frame: CGRect = CGRect.zero) {
        super.init(frame: frame)
        configure()
        self.addGestureRecognizer(swipeRight)
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Actions
    
    @objc func swipeRightGesture() {
        delegate?.swipeRight()
    }
    
    // MARK: - Private Methods
    
    private func configure() {
        backgroundColor = .systemRed
        addSubviews()
        addConstraints()
    }
    
    private func addSubviews() {
        addSubview(collectionView)
    }
    
    private func addConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - OrdersViewLogic

extension TangensView: TangensViewLogic {
    
    func setCollectionView(withDataSourceAndDelegate: UICollectionViewDataSource & UICollectionViewDelegate) -> UICollectionView {
        collectionView.delegate = withDataSourceAndDelegate
        collectionView.dataSource = withDataSourceAndDelegate
        return collectionView
    }
    
    func getCollectionView() -> UICollectionView {
        return collectionView
    }
    
}
