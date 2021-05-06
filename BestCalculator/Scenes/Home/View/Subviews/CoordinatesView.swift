//
//  HomeView.swift
//  BestCalculator
//
//  Created by talgar osmonov on 3/5/21.
//

import SnapKit
import UIKit

protocol CoordinateDelegate: AnyObject {
    func clickView()
}

protocol CoordinatesViewLogic: UIView {
    var delegate: CoordinateDelegate? {get set}
}

final class CoordinatesView: UIView {
    
    internal weak var delegate: CoordinateDelegate?
    
    // MARK: - Views
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
        self.delegate?.clickView()
        
    }
    
    // MARK: - Private Methods
    
    private func configure() {
        backgroundColor = .lightGray
        addSubviews()
        addConstraints()
    }
    
    private func addSubviews() {
        
    }
    
    private func addConstraints() {
        
    }
}

// MARK: - OrdersViewLogic

extension CoordinatesView: CoordinatesViewLogic {
    
}

