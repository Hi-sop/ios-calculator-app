//
//  CalculatorTests.swift
//  CalculatorTests
//
//  Created by Hisop on 2023/10/05.
//

import XCTest
@testable import Calculator

final class CalculatorTests: XCTestCase {
    var sut: CalculateItemQueue!
    
    override func setUpWithError() throws {
        sut = CalculateItemQueue()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func test_enqueue() {
        sut.enqueue(value: 1, operatorType: .plus)
        sut.enqueue(value: 2, operatorType: .minus)
        
        XCTAssertEqual(sut.head?.value, 1)
        XCTAssertEqual(sut.head?.operatorType, .plus)

        XCTAssertEqual(sut.tail?.value, 2)
        XCTAssertEqual(sut.tail?.operatorType, .minus)
    }

    func test_dequeue() {
        sut.enqueue(value: 1, operatorType: .plus)
        sut.enqueue(value: 2, operatorType: .minus)
        
        sut.dequeue()
        
        XCTAssertEqual(sut.head?.value, 2)
        XCTAssertEqual(sut.head?.operatorType, .minus)
    }
    
    func test_isEmpty() {
        var result = sut.isEmpty()
        var expectation = true
        XCTAssertEqual(result, expectation)
        
        sut.enqueue(value: 1, operatorType: .plus)
        result = sut.isEmpty()
        expectation = false
        XCTAssertEqual(result, expectation)
    }
    
    func test_clear() {
        var expectation = true
        
        sut.enqueue(value: 1, operatorType: .plus)
        sut.enqueue(value: 2, operatorType: .minus)
        sut.enqueue(value: 3, operatorType: .multiplication)
        sut.enqueue(value: 4, operatorType: .division)
        
        sut.clear()
        var result = sut.isEmpty()
        
        XCTAssertEqual(result, expectation)
    }
}
