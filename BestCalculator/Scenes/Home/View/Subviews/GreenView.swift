//
//  GreenView.swift
//  BestCalculator
//
//  Created by talgar osmonov on 7/5/21.
//

import SnapKit
import UIKit

protocol GreenDelegate: AnyObject {
    func clickGreenView()
}

protocol GreenViewLogic: UIView {
    var delegate: GreenDelegate? {get set}
}

final class GreenView: UIView {
    
    internal weak var delegate: GreenDelegate?
    
    // MARK: - Views
    private lazy var gesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
    
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
        self.delegate?.clickGreenView()
        
    }
    
    // MARK: - Private Methods
    
    private func configure() {
        backgroundColor = .green
        addSubviews()
        addConstraints()
    }
    
    private func addSubviews() {
        
    }
    
    private func addConstraints() {
        
    }
}

// MARK: - OrdersViewLogic

extension GreenView: GreenViewLogic {
    
}

