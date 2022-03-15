//
//  CalculatorItemQueueTests.swift
//  CalculatorItemQueueTests
//
//  Created by 조민호 on 2022/03/14.
//

import XCTest
@testable import Calculator

class CalculatorItemQueueTests: XCTestCase {

    var sut: CalculatorItemQueue<Int>!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = CalculatorItemQueue<Int>()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
    }
    
    func test_1을_enqueue했을때_값이정상적으로추가되는지() {
        // given
        let input = 1
        
        // when
        sut.enqueue(input)
        
        // then
        XCTAssertEqual(sut.currentInputStack.first, 1)
    }
}
