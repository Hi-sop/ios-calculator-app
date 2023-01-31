//
//  FormulaTests.swift
//  FormulaTests
//
//  Created by kokkilE on 2023/01/30.
//

import XCTest
@testable import Calculator

final class FormulaTests: XCTestCase {
    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }
    
    func test_operator가operand보다1개적은다항식입력후_result호출시_다항식연산결과를반환한다() {
        // given
        let input = "1+2+3-1*4/10+8"
        let expectation: Double = 10

        // when
        var formula = ExpressionParser.parse(from: input)
        let result = formula.result()
        
        // then
        XCTAssertEqual(result, expectation)
    }

    func test_operand가먼저입력된_operator와operand개수가동일한다항식입력후_result호출시_다항식연산결과를반환한다() {
        // given
        let input = "1+10-6*"
        let expectation: Double = 5

        // when
        var formula = ExpressionParser.parse(from: input)
        let result = formula.result()
        
        // then
        XCTAssertEqual(result, expectation)
    }
    
    func test_다항식의연산이0나누기가입력된_result호출시_nan반환한다() {
        // given
        let input = "1+2/0"
        let expectation = true

        // when
        var formula = ExpressionParser.parse(from: input)
        let result = formula.result()
        
        // then
        XCTAssertEqual(result.isNaN, expectation)
    }
}
