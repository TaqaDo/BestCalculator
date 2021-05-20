//
//  HistoryBuilder.swift
//  BestCalculator
//
//  Created by talgar osmonov on 20/5/21.
//

import UIKit

protocol HistoryBuildingLogic: AnyObject {
  func makeScene(parent: UIViewController?) -> HistoryViewController
}

final class HistoryBuilder: HistoryBuildingLogic {
  
  // MARK: - Public Methods
    
  func makeScene(parent: UIViewController? = nil) -> HistoryViewController {
    let viewController = HistoryViewController()
    
    let interactor = HistoryInteractor()
    let presenter = HistoryPresenter()
    let router = HistoryRouter()

    interactor.presenter = presenter
    presenter.viewController = viewController
    
    router.parentController = parent
    router.viewController = viewController
    router.dataStore = interactor

    viewController.interactor = interactor
    viewController.router = router
    
    return viewController
  }
}
