//
//  FormulaTests.swift
//  FormulaTests
//
//  Created by MARY on 2023/06/06.
//

import XCTest
@testable import Calculator

final class FormulaTests: XCTestCase {
    var sut: Formula!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = Formula(operands: CalculatorItemQueue<Double>(),
                      operators: CalculatorItemQueue<Operator>())
    }

    func test_2더하기3곱하기3빼기1을연산큐와숫자큐에넣고_result를호출하면_14를반환한다() {
        // given
        sut.operands.enqueue(2.0)
        sut.operators.enqueue(.add)
        sut.operands.enqueue(3.0)
        sut.operators.enqueue(.multiply)
        sut.operands.enqueue(3.0)
        sut.operators.enqueue(.subtract)
        sut.operands.enqueue(1.0)
        
        // when
        let result = try! sut.result()

        // then
        XCTAssertEqual(result, 14)
    }
    
    func test_3빼기3곱하기2빼기3나누기6을연산큐와숫자큐에넣고_result를호출하면_14를반환한다() {
        // given
        sut.operands.enqueue(3.0)
        sut.operators.enqueue(.subtract)
        sut.operands.enqueue(3.0)
        sut.operators.enqueue(.multiply)
        sut.operands.enqueue(2.0)
        sut.operators.enqueue(.subtract)
        sut.operands.enqueue(3.0)
        sut.operators.enqueue(.divide)
        sut.operands.enqueue(6.0)
        
        // when
        let result = try! sut.result()

        // then
        XCTAssertEqual(result, -0.5)
    }
    
    func test_3을숫자큐에넣고_result를호출하면_invalidFormula오류를반환한다() {
        // given
        sut.operands.enqueue(3.0)

        // when, then
        XCTAssertThrowsError(try sut.result()) { error in
            XCTAssertEqual(error as? FormulaErrors, FormulaErrors.invalidFormula)
        }
    }
    
    func test_2나누기0을연산큐와숫자큐에넣고_result를호출하면_notDivisibleByZero오류를반환한다() {
        // given
        sut.operands.enqueue(2.0)
        sut.operators.enqueue(.divide)
        sut.operands.enqueue(0.0)
        
        // when, then
        XCTAssertThrowsError(try sut.result()) { error in
            XCTAssertEqual(error as? FormulaErrors, FormulaErrors.notDivisibleByZero)
        }
    }
}
