//
//  HomeViewModelTests.swift
//  BestCalculatorTests
//
//  Created by talgar osmonov on 31/5/21.
//

import XCTest
import Expression
@testable import BestCalculator

// MARK: - ViewModelOutput MOCK

class MockViewModelOutput: HomeViewModelOutput {
    var textTest: String?
    var resultTextTest: String?
    var doubleTest: ((_ xArgument: Double) -> Double)?
    
    func setText(text: String) {
        self.textTest = text
    }
    
    func setGraph(data: @escaping (Double) -> Double) {
        self.doubleTest = data
    }
    
    func setResultText(text: String) {
        self.resultTextTest = text
    }
    
    func setCoordinates() {
        
    }
    
    func undoSetCoordinates() {
        
    }
    
    func reloadController() {
        
    }
    
    func changeTangens() {
    
    }
    
    func undoChanges() {
        
    }
}

// MARK: - XCTestCase

class HomeViewModelTests: XCTestCase {
    
    var viewModel: HomeViewModelInput!
    var viewModelOutput: HomeViewModelOutput!
    var text: String!
    
    override func setUpWithError() throws {
        viewModel = HomeViewModel(delegate: MockViewModelOutput())
        viewModelOutput = MockViewModelOutput()
        text = "1+2+3"
    }

    override func tearDownWithError() throws {
        viewModel = nil
        viewModelOutput = nil
    }

    func testViewModelIsNotNil() throws {
        XCTAssertNotNil(viewModel, "is not nil")
        
    }
}
