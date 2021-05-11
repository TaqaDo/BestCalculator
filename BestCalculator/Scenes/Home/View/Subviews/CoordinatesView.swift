//
//  HomeView.swift
//  BestCalculator
//
//  Created by talgar osmonov on 3/5/21.
//

import SnapKit
import UIKit
import QuartzCore
import SpriteKit

protocol CoordinateDelegate: AnyObject {
    func clickView()
}

protocol CoordinatesViewLogic: UIView {
    var delegate: CoordinateDelegate? {get set}
    var yResult: ((_ xArgument: Double) -> Double)? { get set }
}

final class CoordinatesView: UIView {
    
    internal weak var delegate: CoordinateDelegate?
    
    private lazy var graphView: GraphView = {
          let graph = GraphView()
        
        let scaleHandler = #selector(graph.changeScale(byReactingTo:))
        let pinchRecognizer = UIPinchGestureRecognizer(target: graph, action: scaleHandler)
        graph.addGestureRecognizer(pinchRecognizer)
        
        let panHandler = #selector(graph.changePosition(byReactingTo:))
        let panRecognizer = UIPanGestureRecognizer(target: graph, action: panHandler)
        panRecognizer.maximumNumberOfTouches = 1
        panRecognizer.minimumNumberOfTouches = 1
        graph.addGestureRecognizer(panRecognizer)
                    
        let doubleTapHandler = #selector(graph.resetTheCenterCoordinate(byReactingTo:))
        let doubleTapRecognizer = UITapGestureRecognizer(target: graph, action: doubleTapHandler)
        doubleTapRecognizer.numberOfTapsRequired = 2
        doubleTapRecognizer.numberOfTouchesRequired = 1
        graph.addGestureRecognizer(doubleTapRecognizer)
        graph.backgroundColor = .systemGray
        return graph
    }()
    
    var yResult: ((_ xArgument: Double) -> Double)? {
        didSet {
            self.graphView.functionY = self.yResult
        }
    }
    
    // MARK: - Views
    private lazy var gesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
    
    //
    
    // MARK: - Init
    
    override init(frame: CGRect = CGRect.zero) {
        super.init(frame: frame)
        configure()
        self.addGestureRecognizer(gesture)
        
    
        
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - UI Actions
    
    @objc func viewTapped() {
        self.delegate?.clickView()
        
    }
    
    // MARK: - Private Methods
    
    private func configure() {
        backgroundColor = .lightGray
        addSubviews()
        addConstraints()
    }
    
    private func addSubviews() {
        addSubview(graphView)
    }
    
    private func addConstraints() {
        graphView.snp.makeConstraints { make in
            make.top.equalTo(safeArea.top)
            make.bottom.equalTo(safeArea.bottom)
            make.leading.trailing.equalToSuperview()
        }
    }
}

// MARK: - OrdersViewLogic

extension CoordinatesView: CoordinatesViewLogic {
    
}

