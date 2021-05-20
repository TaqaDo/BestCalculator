//
//  HistoryRouter.swift
//  BestCalculator
//
//  Created by talgar osmonov on 20/5/21.
//

import UIKit

protocol HistoryRoutingLogic {

}

protocol HistoryDataPassing {
  var dataStore: HistoryDataStore? { get }
}

final class HistoryRouter: HistoryRoutingLogic, HistoryDataPassing {

  // MARK: - Public Properties

  weak var parentController: UIViewController?
  weak var viewController: HistoryViewController?
  var dataStore: HistoryDataStore?
  
  // MARK: - Private Properties
  
  //

  // MARK: - Routing Logic
  
  //

  // MARK: - Navigation
  
  //

  // MARK: - Passing data
  
  //
}
