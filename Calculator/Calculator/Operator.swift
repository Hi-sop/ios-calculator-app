//
//  Operator.swift
//  Calculator
//
//  Created by Eddy on 2022/03/16.
//

import Foundation

enum Operator: Character, CaseIterable {
    case add = "+"
    case subtract = "-"
    case divide = "/"
    case multiply = "*"
    
    private func calculate(lhs: Double, rhs: Double) -> Double {
        switch self {
        case .add:
            return add(lhs: lhs, rhs: rhs)
        case .subtract:
            return substract(lhs: lhs, rhs: rhs)
        case .divide:
            return divide(lhs: lhs, rhs: rhs)
        case .multiply:
            return multiply(lhs: lhs, rhs: rhs)
        }
    }
    
    func add(lhs: Double, rhs: Double) -> Double {
        return lhs + rhs
    }
    
    func substract(lhs: Double, rhs: Double) -> Double {
        return lhs - rhs
    }
    
    func divide(lhs: Double, rhs: Double) -> Double {
        return lhs / rhs
    }
    
    func multiply(lhs: Double, rhs: Double) -> Double {
        return lhs * rhs
    }
}

