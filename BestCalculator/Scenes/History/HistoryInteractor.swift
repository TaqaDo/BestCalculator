//
//  HistoryInteractor.swift
//  BestCalculator
//
//  Created by talgar osmonov on 20/5/21.
//

import Foundation

protocol HistoryBusinessLogic {

}

protocol HistoryDataStore {

}

final class HistoryInteractor: HistoryBusinessLogic, HistoryDataStore {

  // MARK: - Public Properties

  var presenter: HistoryPresentationLogic?
  lazy var worker: HistoryWorkingLogic = HistoryWorker()

  // MARK: - Private Properties
  
  //

  // MARK: - Business Logic
  
  //
}
