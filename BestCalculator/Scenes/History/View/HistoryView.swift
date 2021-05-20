//
//  HistoryView.swift
//  BestCalculator
//
//  Created by talgar osmonov on 20/5/21.
//

import SnapKit
import UIKit

protocol HistoryViewLogic: UIView {
    func getTableView() -> UITableView
}

final class HistoryView: UIView {
    
    // MARK: - Views
    
    private lazy var tableView: UITableView = {
       let tableView = UITableView()
        tableView.register(HistoryCell.self, forCellReuseIdentifier: HistoryCell.cellID)
        tableView.backgroundColor = .darkColor
        tableView.rowHeight = 100
        return tableView
    }()
    
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
        addSubviews()
        addConstraints()
    }
    
    private func addSubviews() {
        addSubview(tableView)
    }
    
    private func addConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - HistoryViewLogic

extension HistoryView: HistoryViewLogic {
    func getTableView() -> UITableView {
        return tableView
    }
}
