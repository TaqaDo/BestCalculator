//
//  HomeViewController.swift
//  BestCalculator
//
//  Created by talgar osmonov on 3/5/21.
//

import UIKit
import SnapKit


final class HomeViewController: UIViewController {
    
    // MARK: - Public Properties
    
    lazy var coordinatesView: CoordinatesViewLogic = CoordinatesView()
    lazy var resultView: ResultViewLogic = ResultView()
    lazy var buttonsView: ButtonsViewLogic = ButtonsView()
    
    
    // MARK: - Private Properties
    
    private lazy var viewModel: HomeViewModelInput = {
        return HomeViewModel(delegate: self)
    }()
    
    //
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        delegates()
        viewModel.fetchButons()
    }
    
    
    // MARK: - Private Methods
    
    private func delegates() {
        coordinatesView.delegate = self
    }
    
    private func configure() {
        configureCoordinatesView()
        configureButtonsView()
        configureResultView()
    }
    
    private func configureCoordinatesView() {
        view.addSubview(coordinatesView)
        coordinatesView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func configureButtonsView() {
        view.addSubview(buttonsView)
        buttonsView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeArea.bottom)
            make.height.equalToSuperview().dividedBy(1.75)
        }
        
        buttonsView.setCollectionView(withDataSourceAndDelegate: self)
    }
    
    private func configureResultView() {
        view.addSubview(resultView)
        resultView.snp.makeConstraints { make in
            make.top.equalTo(view.safeArea.top)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(buttonsView.snp.top)
        }
    }
    
    // MARK: - UI Actions
    

    
    //
}

// MARK: - ButtonsCellDelegate

extension HomeViewController: ButtonsCellDelegate {
    func longClickRow(item: ButtonModel) {
        self.viewModel.longClickToItem(item: item)
    }
    
    func clickForRow(item: ButtonModel) {
        self.viewModel.clickToItem(item: item)
    }
}

// MARK: - CoordinateDelegate

extension HomeViewController: CoordinateDelegate {
    func clickView() {
        UIView.animate(withDuration: 0.3) {
            self.buttonsView.getCollectionView().frame.origin.y = self.view.frame.height
            self.resultView.alpha = 0
        }
    }
}

// MARK: - HomeViewModelOutput

extension HomeViewController: HomeViewModelOutput {
    func undoSetCoordinates() {
        configureResultView()
    }
    
    func setCoordinates() {
            self.resultView.removeFromSuperview()
            self.view.addSubview(self.resultView)
            self.resultView.snp.makeConstraints { make in
                make.top.equalTo(self.view.safeArea.top)
                make.leading.trailing.equalToSuperview()
                make.height.equalTo(200)
        }
    }
    
    func setResultText(text: String) {
        resultView.getOutputLabel().text = text
    }
    
    func setText(text: String) {
        resultView.getInputLabel().text = text
    }
    
    func reloadController() {
        buttonsView.getCollectionView().reloadData()
    }
}

// MARK: - UICVDelegate, UICVDataSource

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.viewModel.buttonModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ButtonsCell.cellID, for: indexPath) as? ButtonsCell else {return UICollectionViewCell()}
        
        let item = self.viewModel.buttonModels[indexPath.row]
        
        cell.fill(model: item, delegate: self)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.1) {
            if let cell = collectionView.cellForItem(at: indexPath) as? ButtonsCell {
                cell.transform = .init(scaleX: 0.94, y: 0.94)
                
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.1) {
            if let cell = collectionView.cellForItem(at: indexPath) as? ButtonsCell {
                cell.transform = .identity
            }
        }
    }
}

// MARK: - UICVFlowLayout

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let item = self.viewModel.buttonModels[indexPath.row]
        
        if item.value == 0 {
            return CGSize(
                width: ((self.buttonsView.getCollectionView().frame.width / 4) * 1),
                height: (self.buttonsView.getCollectionView().frame.height / 5) - 1
            )
        } else {
            return CGSize(
                width: (self.buttonsView.getCollectionView().frame.width / 4) - 1,
                height: (self.buttonsView.getCollectionView().frame.height / 5) - 1
            )
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}




