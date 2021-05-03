//
//  HomeViewModel.swift
//  BestCalculator
//
//  Created by talgar osmonov on 4/5/21.
//

import Foundation

protocol HomeViewModelInput {
    
}

protocol HomeViewModelOutput: AnyObject {
    
}

// MARK: - ViewModel

class HomeViewModel {
    
    // MARK: - Properties
    
    private weak var delegate: HomeViewModelOutput?
    
    // MARK: - Init
    
    init(delegate: HomeViewModelOutput) {
        self.delegate = delegate
    }
    
    // MARK: - Helper Methods
    
}

// MARK: - Input

extension HomeViewModel: HomeViewModelInput {
    
}
