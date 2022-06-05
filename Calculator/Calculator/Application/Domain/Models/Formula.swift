//
//  Formula.swift
//  Calculator
//
//  Created by 나이든별, 민쏜
//

struct Formula {
    let operands: CalculatorItemQueue<Double>
    let operators: CalculatorItemQueue<Operator>
    
    func result() throws -> Double {
        let operands = self.operands
        let operators = self.operators
        
        guard var result = operands.dequeue()?.data else { throw CalculatorError.noRemainingValue }
        
        while let mathOperator = operators.dequeue()?.data,
              let currentNumber = operands.dequeue()?.data {
            result = try mathOperator.calculate(lhs: result, rhs: currentNumber)
        }
        
        return result
    }
}
