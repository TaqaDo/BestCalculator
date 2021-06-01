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
}

protocol HistoryViewModelOutput: AnyObject {
    
}

// MARK: - ViewModel

class HistoryViewModel {
    
    private weak var delegate: HistoryViewModelOutput?
    let sortDescriptor = NSSortDescriptor(key: #keyPath(Equation.inputResult), ascending: true)
    
    // MARK: - Init
    
    init(delegate: HistoryViewModelOutput) {
        self.delegate = delegate
    }
    
    // MARK: - Helpers Methods

}

extension HistoryViewModel: HistoryViewModelInput {
    func fetchResults() {
        DataStoreManager.shared.fetchRequest.fetchLimit = 15
        DataStoreManager.shared.fetchRequest.sortDescriptors = [sortDescriptor]
        try! DataStoreManager.shared.fetchResultController.performFetch()
    }
}
