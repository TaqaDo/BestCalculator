//
//  HomeViewModelTests.swift
//  BestCalculatorTests
//
//  Created by talgar osmonov on 31/5/21.
//

import XCTest
import Expression
@testable import BestCalculator

class MockViewModelOutput: HomeViewModelOutput {
    var textTest: String?
    var resultTextTest: String?
    var doubleTest: ((_ xArgument: Double) -> Double)?
    var testBool: Bool?
    
    func setText(text: String) {
        textTest = text
    }
    
    func setGraph(data: @escaping (Double) -> Double) {
        doubleTest = data
    }
    
    func setResultText(text: String) {
        resultTextTest = text
    }
    
    func setCoordinates() {
        testBool = true
    }
    
    func undoSetCoordinates() {
        testBool = false
    }
    
    func reloadController() {
        
    }
    
    func changeTangens() {
        testBool = true
    }
    
    func undoChanges() {
        testBool = false
    }
}


// MARK: - XCTestCase

class HomeViewModelTests: XCTestCase{
   
    var viewModelOutput: MockViewModelOutput!
    var viewModel: HomeViewModelInput!
    
    override func setUpWithError() throws {
        viewModelOutput = MockViewModelOutput()
        viewModel = HomeViewModel(delegate: viewModelOutput)
    }

    override func tearDownWithError() throws {
        viewModel = nil
        viewModelOutput = nil
    }
    
    func testViewModelIsNotNil() throws {
        XCTAssertNotNil(viewModel, "is not nil")
    }
    
    func testClickToItem() throws {
        viewModel.clickToItem(item: ButtonModel(type: .value, title: "1", value: 1, operation: .none, colorHex: UIColor()))
        viewModel.clickToItem(item: ButtonModel(type: .value, title: "3", value: 1, operation: .none, colorHex: UIColor()))
        viewModel.clickToItem(item: ButtonModel(type: .value, title: "1", value: 1, operation: .none, colorHex: UIColor()))
        viewModel.clickToItem(item: ButtonModel(type: .operation, title: "*", value: 1, operation: .multiplication, colorHex: UIColor()))
        viewModel.clickToItem(item: ButtonModel(type: .value, title: "1", value: 1, operation: .none, colorHex: UIColor()))
        viewModel.clickToItem(item: ButtonModel(type: .value, title: "1", value: 1, operation: .none, colorHex: UIColor()))
        viewModel.clickToItem(item: ButtonModel(type: .value, title: "1", value: 1, operation: .none, colorHex: UIColor()))
        XCTAssertEqual(viewModelOutput.textTest, "131*111")
        XCTAssertEqual(viewModelOutput.resultTextTest, "")
    }
    
    func testClickToItemTangens() {
        viewModel.clickToTangensItem(item: TangensModel(title: "INV", operation: .INV, colorHex: UIColor()))
        XCTAssertEqual(viewModelOutput.testBool, true)
        viewModel.clickToTangensItem(item: TangensModel(title: "INV", operation: .INV2, colorHex: UIColor()))
        XCTAssertEqual(viewModelOutput.testBool, false)
        viewModel.clickToTangensItem(item: TangensModel(title: "sin", operation: .sin, colorHex: UIColor()))
        XCTAssertEqual(viewModelOutput.textTest, "LOH")
    }
    
    func testLongClickToItem() {
        viewModel.longClickToItem(item: ButtonModel(type: .operation, title: "DEL", operation: .clean, colorHex: UIColor()))
        XCTAssertEqual(viewModelOutput.textTest, "")
        XCTAssertEqual(viewModelOutput.resultTextTest, "")
    }
    
    func testOperations() {
        viewModel.text = "222+1"
        viewModel.operations(item: ButtonModel(type: .operation, title: "+", operation: .addition, colorHex: UIColor()))
        XCTAssertEqual(viewModelOutput.textTest, "222+1+")
    }
    
    func testChekForSetCoordinates() {
        viewModel.text = "11X"
        viewModel.checkForCoordinates()
        XCTAssertEqual(viewModelOutput.testBool, true)
    }
    
    func testChekForUndoSetCoordinates() {
        viewModel.text = "11"
        viewModel.checkForCoordinates()
        XCTAssertEqual(viewModelOutput.testBool, false)
    }
    
    func testSetGraph() {
        viewModel.coordinates(item: ButtonModel(type: .operation, title: "X", operation: .systemCoordinate, colorHex: UIColor()))
    }
    
    func testCleanNumbers() {
        viewModel.text = "111-22"
        viewModel.cleanNumbers()
        
        XCTAssertEqual(viewModelOutput.textTest, "111-2")
    }
    
    func testCleanAll() {
        viewModel.text = "111111"
        viewModel.cleanAll()
        XCTAssertEqual(viewModelOutput.textTest, "")
        XCTAssertEqual(viewModelOutput.resultTextTest, "")
    }
    
    func testGetResult() {
        viewModel.text = "1+2*3"
        viewModel.getResult()
        XCTAssertEqual(viewModelOutput.textTest, "7")
    }
    
    func testErrorGetResult() {
        viewModel.text = "ERROR"
        viewModel.getResult()
        XCTAssertEqual(viewModelOutput.textTest, "ERROR")
    }
    
    func testGetBottomResult() {
        viewModel.text = "10/2"
        viewModel.getBottomResult()
        XCTAssertEqual(viewModelOutput.resultTextTest, "5")
    }
    
    func testErrorGetBottomResult() {
        viewModel.text = "fail"
        viewModel.getBottomResult()
        XCTAssertEqual(viewModelOutput.textTest, "ERROR")
    }
    
    func testGetCleanBottomResult() {
        viewModel.text = "1+1+"
        viewModel.getCleanBottomResult()
        XCTAssertNotEqual(viewModelOutput.resultTextTest, "2")
    }
    
    func testGetResultBottomResult() {
        viewModel.text = "1+11"
        viewModel.getResultBottomResult()
        XCTAssertNotEqual(viewModelOutput.resultTextTest, "")
    }
    
    func testGetValueBottomResult() {
        viewModel.text = "111+1+1"
        viewModel.getValueBottomResult()
        XCTAssertEqual(viewModelOutput.resultTextTest, "113")
    }
    
    func testGetResultAndSaveToDatabase() {
        viewModel.text = "1+1"
        viewModel.getResultAndSaveToDatabase()
        XCTAssertEqual(viewModelOutput.textTest, "2")
    }

}
