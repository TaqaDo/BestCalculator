//
//  HomeViewModel.swift
//  BestCalculator
//
//  Created by talgar osmonov on 4/5/21.
//

import Foundation
import UIKit

protocol HomeViewModelInput {
    var text: String {get set}
    var buttonModels: [ButtonModel] {get set}
    func fetchButons()
    func clickToItem(item: ButtonModel)
}

protocol HomeViewModelOutput: AnyObject {
    func setText(text: String)
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
    
    private func handlerOperation(_ item: ButtonModel) {
        if let operation = item.operation {
            print("handlerOperation \(item.title ?? "title is nil") \(operation)")
            
            switch operation {
            case .multiplication:
                break
            case .division:
                break
            case .deduction:
                break
            case .addition:
                break
            case .percent:
                break
            case .comma:
                break
            case .clean:
                break
            case .braces:
                break
            case .result:
                break
            case .systemCoordinate:
                break
            }
        } else {
            delegate?.setText(text: "Error")
        }
    }
        
    private func handlerValue(_ item: ButtonModel) {
        if let value = item.value {
            print("handlerValue \(value)")
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
        buttonModels.append(ButtonModel(type: Type.value, title: "6", value: 6, colorHex: "#485063"))
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
        text = text + item.title
        delegate?.setText(text: text)
        
        if item.type == Type.operation {
            handlerOperation(item)
        } else if item.type == Type.value {
            handlerValue(item)
        } else {
            delegate?.setText(text: "Error")
        }
    }
}
