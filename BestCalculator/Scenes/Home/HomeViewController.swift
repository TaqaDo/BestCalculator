//
//  HomeViewController.swift
//  BestCalculator
//
//  Created by talgar osmonov on 3/5/21.
//

import UIKit


final class HomeViewController: UIViewController {
    
    // MARK: - Public Properties
    
    lazy var contentView: HomeViewLogic = HomeView()
    
    // MARK: - Private Properties
    
    //
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    // MARK: - Private Methods
    
    private func configure() {
        
    }
    
    // MARK: - UI Actions
    
    //
}




