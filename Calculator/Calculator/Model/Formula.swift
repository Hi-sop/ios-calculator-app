//
//  Formula.swift
//  Calculator
//
//  Created by kaki on 2023/01/27.
//

struct Formula {
    var operands: CalculatorItemQueue<Double>
    var operaters: CalculatorItemQueue<Operator>
    
    mutating func result() -> Double {
        guard let lhsOperands = operands.dequeue() else { return .zero }
        var result = lhsOperands
        
        while let `operator` = operaters.dequeue(), let rhsOperands = operands.dequeue() {
            let lhsOperands = result
            result = `operator`.calculate(lhs: lhsOperands, rhs: rhsOperands)
        }
        
        return result
    }
}
