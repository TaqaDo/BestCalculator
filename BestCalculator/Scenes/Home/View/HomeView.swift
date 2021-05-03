//
//  HomeView.swift
//  BestCalculator
//
//  Created by talgar osmonov on 3/5/21.
//

import SnapKit
import UIKit

protocol HomeViewLogic: UIView {
  
}

final class HomeView: UIView {
  
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
    backgroundColor = .red
    addSubviews()
    addConstraints()
  }
  
  private func addSubviews() {
    
  }
  
  private func addConstraints() {
    
  }
}

// MARK: - OrdersViewLogic

extension HomeView: HomeViewLogic {
  
}

