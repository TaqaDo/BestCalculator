//
//  HistoryViewController.swift
//  BestCalculator
//
//  Created by talgar osmonov on 20/5/21.
//

import UIKit
import CoreData


final class HistoryViewController: UIViewController {
    
    // MARK: - Public Properties
    
    lazy var contentView: HistoryViewLogic = HistoryView()
    private lazy var viewModel: HistoryViewModelInput = {
       let model = HistoryViewModel(delegate: self)
        return model
    }()
    
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchResults()
        configure()
        delegates()

    }
    
    // MARK: - Requests
    
    //
    
    // MARK: - Private Methods
    
    private func delegates() {
        contentView.getTableView().delegate = self
        contentView.getTableView().dataSource = self
        viewModel.dataManager.fetchResultController.delegate = self
    }
    
    private func configure() {
        
    }
    
    // MARK: - UI Actions
    
    //
}



// MARK: - ViewModelDelegate

extension HistoryViewController: HistoryViewModelOutput {
    
}

// MARK: - NSFetchedResultsControllerDelegate

extension HistoryViewController: NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        
        case .insert:
            break
        case .delete:
            contentView.getTableView().deleteRows(at: [indexPath!], with: .middle)
        case .move:
            break
        case .update:
            break
        @unknown default:
            break
        }
        
    }
}

// MARK: - UITableViewDel/DS

extension HistoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionInfo = viewModel.dataManager.fetchResultController.sections?[section]
        return sectionInfo?.numberOfObjects ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HistoryCell.cellID, for: indexPath) as? HistoryCell else {return UITableViewCell()}
        let results = viewModel.dataManager.fetchResultController.object(at: indexPath)
        cell.setupData(input: results.inputResult ?? "", output: results.outputResult ?? "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        switch editingStyle {
        
        case .none:
            break
        case .delete:
            let equation = viewModel.dataManager.fetchResultController.object(at: indexPath)
            viewModel.dataManager.persistentContainer.viewContext.delete(equation)
            viewModel.dataManager.saveContext()
        case .insert:
            break
        @unknown default:
            break
        }
    }
}
