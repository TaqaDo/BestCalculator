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
    lazy var tangensView: TangensViewLogic = TangensView()
    lazy var greenView: GreenViewLogic = GreenView()
    
    
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
        viewModel.fetchTangens()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        
    }
    
    
    // MARK: - Private Methods
    
    private func delegates() {
        coordinatesView.delegate = self
        buttonsView.delegate = self
        tangensView.delegate = self
        greenView.delegate = self
    }
    
    private func configure() {
        configureCoordinatesView()
        configureBottomView()
        configureResultView()
    }
    
    private func configureCoordinatesView() {
        view.addSubview(coordinatesView)
        coordinatesView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func configureBottomView() {
        view.addSubview(buttonsView)
        view.addSubview(greenView)
        
        greenView.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeArea.bottom)
            make.height.equalToSuperview().dividedBy(1.75)
            make.width.equalTo(25)
        }
        
        buttonsView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalTo(greenView.snp.leading)
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
        tangensView.setCollectionView(withDataSourceAndDelegate: self)
    }
    
    // MARK: - UI Actions
    
    
    
    //
}


// MARK: - GreenDelegate

extension HomeViewController: GreenDelegate {
    func clickGreenView() {
        view.addSubview(tangensView)
        tangensView.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.leading.equalToSuperview()
            make.bottom.equalTo(view.safeArea.bottom)
            make.height.equalToSuperview().dividedBy(1.75)
        }
        
        UIView.animate(withDuration: 0.4) {
            self.tangensView.frame.origin.x = self.view.frame.width
        }
    }
}

// MARK: - TangensDelegate

extension HomeViewController: TangensDelegate {
    func swipeRight() {
        UIView.animate(withDuration: 0.4) {
            self.tangensView.frame.origin.x = self.view.frame.height
        } completion: { _ in
            self.tangensView.removeFromSuperview()
        }
    }
}

// MARK: - ButtonsDelegate

extension HomeViewController: ButtonsDelegate {
    func swipeLeft() {
        view.addSubview(tangensView)
        tangensView.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.leading.equalToSuperview()
            make.bottom.equalTo(view.safeArea.bottom)
            make.height.equalToSuperview().dividedBy(1.75)
        }
        
        UIView.animate(withDuration: 0.4) {
            self.tangensView.frame.origin.x = self.view.frame.width
            self.tangensView.getCollectionView().reloadData()
        }
    }
}

// MARK: - ButtonsCellDelegate

extension HomeViewController: TangensCellDelegate {
    func clickForTangensRow(item: TangensModel) {
        self.viewModel.clickToTangensItem(item: item)
    }
}

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
            self.buttonsView.frame.origin.y = self.view.frame.height
            self.greenView.frame.origin.y = self.view.frame.height
            self.tangensView.frame.origin.y = self.view.frame.height
            self.resultView.alpha = 0
        }
    }
}

// MARK: - HomeViewModelOutput

extension HomeViewController: HomeViewModelOutput {
    func undoChanges() {
        viewModel.tangensModels.removeAll()
        viewModel.fetchTangens()
    }
    
    func changeTangens() {
        viewModel.tangensModels.removeAll()
        viewModel.fetchSecondTangens()
    }
    
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
        tangensView.getCollectionView().reloadData()
    }
}

// MARK: - UICVDelegate, UICVDataSource

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == buttonsView.getCollectionView() {
            return self.viewModel.buttonModels.count
        }
        
        return self.viewModel.tangensModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == buttonsView.getCollectionView() {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ButtonsCell.cellID, for: indexPath) as? ButtonsCell else {return UICollectionViewCell()}
            let item = self.viewModel.buttonModels[indexPath.row]
            cell.fill(model: item, delegate: self)
            return cell
            
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TangensCell.cellID, for: indexPath) as? TangensCell else {return UICollectionViewCell()}
            let item = self.viewModel.tangensModels[indexPath.row]
            cell.fill(model: item, delegate: self)
            return cell
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        
        if collectionView == buttonsView.getCollectionView() {
            UIView.animate(withDuration: 0.1) {
                if let cell = collectionView.cellForItem(at: indexPath) as? ButtonsCell {
                    cell.transform = .init(scaleX: 0.90, y: 0.90)
                    
                }
            }
        } else {
            UIView.animate(withDuration: 0.1) {
                if let cell = collectionView.cellForItem(at: indexPath) as? TangensCell {
                    cell.transform = .init(scaleX: 0.75, y: 0.75)
                    
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        
        if collectionView == buttonsView.getCollectionView() {
            UIView.animate(withDuration: 0.1) {
                if let cell = collectionView.cellForItem(at: indexPath) as? ButtonsCell {
                    cell.transform = .identity
                }
            }
        } else {
            UIView.animate(withDuration: 0.1) {
                if let cell = collectionView.cellForItem(at: indexPath) as? TangensCell {
                    cell.transform = .identity
                }
            }
        }
    }
}

// MARK: - UICVFlowLayout

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let item = self.viewModel.buttonModels[indexPath.row]
        
        if collectionView == buttonsView.getCollectionView() {
            if item.value == 0 {
                return CGSize(
                    width: ((self.buttonsView.getCollectionView().frame.width / 4) * 1),
                    height: (self.buttonsView.getCollectionView().frame.height / 5) - 1)
            } else {
                return CGSize(
                    width: (self.buttonsView.getCollectionView().frame.width / 4) - 1,
                    height: (self.buttonsView.getCollectionView().frame.height / 5) - 1)
            }
        } else {
            return CGSize(
                width: (self.tangensView.getCollectionView().frame.width / 4) - 1,
                height: (self.tangensView.getCollectionView().frame.height / 4) - 1)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}




