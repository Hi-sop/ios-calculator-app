//
//  ArithmeticSign.swift
//  Calculator
//
//  Created by Yongwoo Marco on 2021/06/25.
//

import Foundation

enum ArithmeticError: Error {
    case downCastingError
}

protocol Arithmetic {

}
class Operand: Arithmetic {
    let value: Double
    
    init(_ value: Double) {
        self.value = value
    }
}
enum OperatorType {
    case addition
    case subtraction
    case mulitplication
    case division
}
class Operator: Arithmetic, Equatable, Comparable {
    static let higher: Array<OperatorType> = [.mulitplication, .division]
    static let lower: Array<OperatorType> = [.addition, .subtraction]
    static func == (lhs: Operator, rhs: Operator) -> Bool {
        return higher.contains(lhs.type) == higher.contains(rhs.type)
    }
    static func < (lhs: Operator, rhs: Operator) -> Bool {
        return lower.contains(lhs.type) && higher.contains(rhs.type)
    }
    static func > (lhs: Operator, rhs: Operator) -> Bool {
        return higher.contains(lhs.type) && lower.contains(rhs.type)
    }
    
    let type: OperatorType
    
    init(_ type: OperatorType) {
        self.type = type
    }
    func computeNumber(_ lhs: Double, _ rhs: Double) -> Double {
        switch type {
        case .addition:
            return lhs + rhs
        case .subtraction:
            return lhs - rhs
        case .mulitplication:
            return lhs * rhs
        case .division:
            return lhs / rhs
        }
    }
}
