//
//  HomeViewModel.swift
//  BestCalculator
//
//  Created by talgar osmonov on 4/5/21.
//

import Foundation
import UIKit
import Expression

protocol HomeViewModelInput {
    var text: String {get set}
    var buttonModels: [ButtonModel] {get set}
    func fetchButons()
    func clickToItem(item: ButtonModel)
}

protocol HomeViewModelOutput: AnyObject {
    func setText(text: String)
    func setResultText(text: String)
    func setCoordinates()
    func undoSetCoordinates()
    func reloadController()
}

// MARK: - ViewModel

class HomeViewModel {
    
    private weak var delegate: HomeViewModelOutput?
    
    // MARK: - Properties
    
    var text: String = String()
    var buttonModels: [ButtonModel] = []
    
    // MARK: - Init
    
    init(delegate: HomeViewModelOutput) {
        self.delegate = delegate
    }
    
    // MARK: - Helper Methods
    
    private func checkForCoordinates() {
        let coordinates = text.contains("X")
        
        if coordinates {
            delegate?.setCoordinates()
        } else {
            delegate?.undoSetCoordinates()
        }
    }
    
    private func formatResult(result: Double) -> String {
        if result.truncatingRemainder(dividingBy: 1) == 0 {
            return String(format: "%.0f", result)
        } else {
            return String(format: "%.2f", result)
        }
    }
    
    private func cleanNumbers() {
        if !text.isEmpty {
            text.removeLast()
            delegate?.setText(text: text)
        }
    }
    
    private func coordinates(item: ButtonModel) {
        
        text = text + item.title
        delegate?.setText(text: text)
    }
    
    private func operations(item: ButtonModel) {
        if !text.isEmpty && text.last != "+" && text.last != "-" && text.last != "÷" && text.last != "×" && text.last != "%" && text.last != "," {
        text = text + item.title
        delegate?.setText(text: text)
        }
    }
    
    private func getResult() {
        
        let changeChars = text.replacingOccurrences(of: "÷", with: "/")
        let changeChars2 = changeChars.replacingOccurrences(of: "×", with: "*")
        let changeChars3 = changeChars2.replacingOccurrences(of: ",", with: ".")
        let changeChars4 = changeChars3.replacingOccurrences(of: "%", with: "%")
        let expression = Expression(changeChars4)
        
        do {
            let result = try expression.evaluate()
            print("Result: \(result)")
        } catch {
            print("Error: \(error)")
        }
        text = expression.description
        delegate?.setText(text: expression.description)
    }
    
    private func getBottomResult() {
        let changeChars = text.replacingOccurrences(of: "÷", with: "/")
        let changeChars2 = changeChars.replacingOccurrences(of: "×", with: "*")
        let changeChars3 = changeChars2.replacingOccurrences(of: ",", with: ".")
        let changeChars4 = changeChars3.replacingOccurrences(of: "%", with: "%")
        let expression = Expression(changeChars4)
        
        do {
            let result = try expression.evaluate()
            print("Result: \(result)")
        } catch {
            print("Error: \(error)")
        }
        
        delegate?.setResultText(text: expression.description)
    }
    
    
    private func handlerOperation(_ item: ButtonModel) {
        if let operation = item.operation {
            print("handlerOperation \(item.title ?? "title is nil") \(operation)")
            
            switch operation {
            case .multiplication:
                operations(item: item)
                delegate?.setResultText(text: "")
                checkForCoordinates()
            case .division:
                operations(item: item)
                delegate?.setResultText(text: "")
                checkForCoordinates()
            case .deduction:
                operations(item: item)
                delegate?.setResultText(text: "")
                checkForCoordinates()
            case .addition:
                operations(item: item)
                delegate?.setResultText(text: "")
                checkForCoordinates()
            case .percent:
                operations(item: item)
                delegate?.setResultText(text: "")
                checkForCoordinates()
            case .comma:
                operations(item: item)
                delegate?.setResultText(text: "")
                checkForCoordinates()
            case .clean:
                cleanNumbers()
                delegate?.setResultText(text: "")
                checkForCoordinates()
            case .braces:
                operations(item: item)
                delegate?.setResultText(text: "")
                checkForCoordinates()
            case .result:
                getResult()
                delegate?.setResultText(text: "")
                checkForCoordinates()
            case .systemCoordinate:
                coordinates(item: item)
                checkForCoordinates()
            }
        } else {
            delegate?.setText(text: "Error")
        }
    }
        
    private func handlerValue(_ item: ButtonModel) {
        if item.value != nil {
            text = text + item.title
            delegate?.setText(text: text)
            if text.contains("+") || text.contains("-") || text.contains("×") || text.contains("÷") {
            getBottomResult()
            }
        }
    }
    
}

// MARK: - Input

extension HomeViewModel: HomeViewModelInput {
    func fetchButons() {
        buttonModels.append(ButtonModel(type: Type.operation, title: "X", operation: Operation.systemCoordinate, colorHex: "#485063"))
        buttonModels.append(ButtonModel(type: Type.operation, title: "( )", operation: Operation.braces, colorHex: "#485063"))
        buttonModels.append(ButtonModel(type: Type.operation, title: "%", operation: Operation.percent, colorHex: "#485063"))
        buttonModels.append(ButtonModel(type: Type.operation, title: "DEL", operation: Operation.clean, colorHex: "#5d6475"))

        buttonModels.append(ButtonModel(type: Type.value, title: "7", value: 7, colorHex: "#485063"))
        buttonModels.append(ButtonModel(type: Type.value, title: "8", value: 8, colorHex: "#485063"))
        buttonModels.append(ButtonModel(type: Type.value, title: "9", value: 9, colorHex: "#485063"))
        buttonModels.append(ButtonModel(type: Type.operation, title: "÷", operation: Operation.division, colorHex: "#5d6475"))

        buttonModels.append(ButtonModel(type: Type.value, title: "4", value: 4, colorHex: "#485063"))
        buttonModels.append(ButtonModel(type: Type.value, title: "5", value: 5, colorHex: "#485063"))
        buttonModels.append(ButtonModel(type: Type.value, title: "6",  value: 6, colorHex: "#485063"))
        buttonModels.append(ButtonModel(type: Type.operation, title: "×", operation: Operation.multiplication, colorHex: "#5d6475"))

        buttonModels.append(ButtonModel(type: Type.value, title: "3", value: 3, colorHex: "#485063"))
        buttonModels.append(ButtonModel(type: Type.value, title: "2", value: 2, colorHex: "#485063"))
        buttonModels.append(ButtonModel(type: Type.value, title: "1", value: 1, colorHex: "#485063"))
        buttonModels.append(ButtonModel(type: Type.operation, title: "-", operation: Operation.deduction, colorHex: "#5d6475"))
        buttonModels.append(ButtonModel(type: Type.operation, title: ",", operation: Operation.comma, colorHex: "#485063"))
        buttonModels.append(ButtonModel(type: Type.value, title: "0", value: 0, colorHex: "#485063"))
        buttonModels.append(ButtonModel(type: Type.operation, title: "=", operation: Operation.result, colorHex: "#485063"))
        buttonModels.append(ButtonModel(type: Type.operation, title: "+", operation: Operation.addition, colorHex: "#5d6475"))
        
        delegate?.reloadController()
    }
    
    
    func clickToItem(item: ButtonModel) {
            
        if item.type == Type.operation {
            handlerOperation(item)
        } else if item.type == Type.value {
            handlerValue(item)
        } else {
            delegate?.setText(text: "Error")
        }
    }
}
