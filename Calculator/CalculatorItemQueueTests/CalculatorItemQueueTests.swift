//
//  CalculatorItemQueueTests.swift
//  CalculatorItemQueueTests
//
//  Created by redmango1446 on 2023/06/01.
//

import XCTest
@testable import Calculator

final class CalculatorItemQueueTests: XCTestCase {
    var sut: CalculatorItemQueue<Int>!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = CalculatorItemQueue()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func test_dequeue_enqueue를_하지_않고_dequeue를_하면_Nil이_반환된다() {
        // given
        // when
        let result = sut.dequeue()
        
        // then
        XCTAssertNil(result)
    }
    
    func test_dequeue_1을_enqueue하고_dequeue를_하면_1이_반환된다() {
        // given
        sut.enqueue(1)
        
        // when
        let result = sut.dequeue()
        let expectedValue = 1
        
        // then
        XCTAssertEqual(result, expectedValue)
    }
    
    func test_dequeue_1과_2를_enqueue하고_dequeue를_하면_1이_반환된다() {
        // given
        sut.enqueue(1)
        sut.enqueue(2)
        
        // when
        let result = sut.dequeue()
        let expectedValue = 1
        
        // then
        XCTAssertEqual(result, expectedValue)
    }
    
    func test_dequeue_1과_2를_enqueue하고_dequeue를_2번_하면_2가_반환된다() {
        // given
        sut.enqueue(1)
        sut.enqueue(2)
        
        // when
        var result = sut.dequeue()
        result = sut.dequeue()
        let expectedValue = 2
        
        // then
        XCTAssertEqual(result, expectedValue)
    }
}
