//
//  HistoryViewModel.swift
//  BestCalculator
//
//  Created by talgar osmonov on 20/5/21.
//

import Foundation
import UIKit


protocol HistoryViewModelInput {
    func fetchResults()
    var dataManager: DataStoreManager { get set }
}

protocol HistoryViewModelOutput: AnyObject {
    
}

// MARK: - ViewModel

class HistoryViewModel {
    
    private weak var delegate: HistoryViewModelOutput?
    let sortDescriptor = NSSortDescriptor(key: #keyPath(Equation.inputResult), ascending: true)
    var dataManager: DataStoreManager = DataStoreManager()
    
    // MARK: - Init
    
    init(delegate: HistoryViewModelOutput) {
        self.delegate = delegate
    }
    
    // MARK: - Helpers Methods

}

extension HistoryViewModel: HistoryViewModelInput {
    func fetchResults() {
        dataManager.fetchRequest.fetchLimit = 15
        dataManager.fetchRequest.sortDescriptors = [sortDescriptor]
        try! dataManager.fetchResultController.performFetch()
    }
}
