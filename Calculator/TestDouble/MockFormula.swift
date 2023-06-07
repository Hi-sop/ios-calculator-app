//
//  MockFormula.swift
//  Calculator
//
//  Created by Minseong Kang on 2023/06/06.
//

protocol MockFormulaProtocol {
	associatedtype T: CalculateItem
	associatedtype U: CalculateItem
	var operands: MockCalculatorItemQueue<T>? { get }
	var operators: MockCalculatorItemQueue<U>? { get }
	func result() -> Double
}

struct MockFormula<T: CalculateItem, U: CalculateItem>: MockFormulaProtocol {
	var operands: MockCalculatorItemQueue<T>?
	var operators: MockCalculatorItemQueue<U>?
	
	func result() -> Double {
		var operandsList: [Double] = []
		while let operands = operands?.dequeue() {
			guard let operand = operands as? Double else { return -1.0 }
			operandsList.append(operand)
		}
		
		let lhsOperand = operandsList[operandsList.startIndex]
		let rhsOperand = operandsList[operandsList.endIndex-1]

		guard let operators = operators?.dequeue() as? Operator else { return -3.0 }
		
		switch operators {
		case .add:
			return lhsOperand + rhsOperand
		case .subtract:
			return lhsOperand - rhsOperand
		case .divide:
			return lhsOperand / rhsOperand
		case .multiply:
			return lhsOperand * rhsOperand
		}
	}
	
	init(operands: MockCalculatorItemQueue<T>, operators: MockCalculatorItemQueue<U>) {
		self.operands = operands
		self.operators = operators
	}
}
