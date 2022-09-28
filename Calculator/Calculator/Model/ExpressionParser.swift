//
//  ExpressionParser.swift
//  Calculator
//
//  Created by SummerCat on 2022/09/24.
//

import Foundation

enum ExpressionParser {
    static func parse(from input: String) -> Formula {
        let operandsQueue = parseOperands(from: input)
        let operatorsQueue = parseOperators(from: input)

        return Formula(operands: operandsQueue, operators: operatorsQueue)
    }
 
    private static func parseOperands(from input: String) -> CalculatorItemQueue<Double> {
        var operandsQueue = CalculatorItemQueue<Double>()
        
        componentsByOperators(from: input)
            .compactMap(Double.init)
            .forEach { operands in
                operandsQueue.enqueue(item: operands)
            }
        
        return operandsQueue
    }
    
    private static func componentsByOperators(from input: String) -> [String] {
        var inputCopy = input
        
        Operator.allCases
            .map(\.rawValue)
            .forEach { operatorSign in
                inputCopy = inputCopy.replacingOccurrences(of: "\(operatorSign)-", with: "\(operatorSign)")
            }
        
        return inputCopy.components(separatedBy: "")
    }
    
    private static func parseOperators(from input: String) -> CalculatorItemQueue<Operator> {
        var operatorsQueue = CalculatorItemQueue<Operator>()

        var removedNegativeSignAtFront = input
        if input.first == "-" {
            removedNegativeSignAtFront.removeFirst()
        }
        
        let operators = Operator.allCases.map { $0.rawValue }
        for operatorSign in operators {
            removedNegativeSignAtFront = removedNegativeSignAtFront
                .replacingOccurrences(of: "\(operatorSign)-", with: "\(operatorSign)")
        }
        
        removedNegativeSignAtFront.forEach {
            guard let operatorSign = Operator(rawValue: $0) else { return }
            operatorsQueue.enqueue(item: operatorSign)
        }
        
        return operatorsQueue
    }
}
