//
//  ResultView.swift
//  BestCalculator
//
//  Created by talgar osmonov on 4/5/21.
//

import SnapKit
import UIKit

protocol ResultViewLogic: UIView {
  
}

final class ResultView: UIView {
  
  // MARK: - Views
  
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
    
  }
  
  private func addConstraints() {
    
  }
}

// MARK: - OrdersViewLogic

extension ResultView: ResultViewLogic {
  
}


