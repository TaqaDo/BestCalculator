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
    func exitClick()
}

protocol CoordinatesViewLogic: UIView {
    var delegate: CoordinateDelegate? {get set}
    var yResult: ((_ xArgument: Double) -> Double)? { get set }
    func getGraphView() -> GraphView
}

final class CoordinatesView: UIView {
    
    internal weak var delegate: CoordinateDelegate?
    
    var yResult: ((_ xArgument: Double) -> Double)? {
        didSet {
            self.graphView.functionY = self.yResult
        }
    }
    
    // MARK: - Views
    
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
        graph.backgroundColor = .mediumDark
        return graph
    }()
    
    private lazy var gesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
    
    private lazy var addGraph: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("⊡", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 36)
        button.tintColor = .lightGray
        return button
    }()
    
    private lazy var linesGraph: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("⊞", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 36)
        button.tintColor = .lightGray
        return button
    }()
    
    private lazy var zoomButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("⊕", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 36)
        button.tintColor = .lightGray
        button.addTarget(self, action: #selector(handleZoom), for: .touchUpInside)
        return button
    }()
    
    private lazy var unZoomButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("⊝", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 36)
        button.tintColor = .lightGray
        button.addTarget(self, action: #selector(handleUnZoom), for: .touchUpInside)
        return button
    }()
    
    private lazy var defaultZoomButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("⊕", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 36)
        button.tintColor = .lightGray
        button.addTarget(self, action: #selector(handleDefaultZoom), for: .touchUpInside)
        return button
    }()
    
    private lazy var exitButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("⊗", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 36)
        button.tintColor = .lightGray
        button.addTarget(self, action: #selector(handleExit), for: .touchUpInside)
        return button
    }()
    
    private lazy var bottomButtonsStack: UIStackView = {
       let stack = UIStackView(arrangedSubviews: [zoomButton, unZoomButton, defaultZoomButton, exitButton])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        return stack
    }()
    
    private lazy var navView: UIView = {
       let view = UIView()
        view.addSubview(addGraph)
        view.addSubview(linesGraph)
        linesGraph.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(20)
        }
        addGraph.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(20)
        }
        view.backgroundColor = .darkColor
        return view
    }()
    
    private lazy var bottomView: UIView = {
       let view = UIView()
        view.addSubview(bottomButtonsStack)
        bottomButtonsStack.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20)
        }
        view.backgroundColor = .darkColor
        return view
    }()
    
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
    
    @objc func handleExit() {
        self.delegate?.exitClick()
    }
    
    @objc func handleZoom() {
        graphView.scaleConstant = graphView.scaleConstant + 1
    }
    
    @objc func handleUnZoom() {
        graphView.scaleConstant = graphView.scaleConstant - 1
    }
    
    @objc func handleDefaultZoom() {
        graphView.scaleConstant = 30
    }
    
    // MARK: - Private Methods
    
    private func configure() {
        backgroundColor = .darkColor
        addSubviews()
        addConstraints()
    }
    
    private func addSubviews() {
        addSubview(graphView)
        addSubview(navView)
        addSubview(bottomView)
    }
    
    private func addConstraints() {
        graphView.snp.makeConstraints { make in
            make.top.equalTo(safeArea.top)
            make.bottom.equalTo(safeArea.bottom)
            make.leading.trailing.equalToSuperview()
        }
        navView.snp.makeConstraints { make in
            make.top.equalTo(safeArea.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(56)
        }
        bottomView.snp.makeConstraints { make in
            make.bottom.equalTo(safeArea.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(76)
        }
    }
}

// MARK: - OrdersViewLogic

extension CoordinatesView: CoordinatesViewLogic {
    func getGraphView() -> GraphView {
        return graphView
    }
}


