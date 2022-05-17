//
//  CalculatorTests.swift
//  CalculatorTests
//
//  Created by 이은찬 on 2022/05/16.
//

import XCTest
@testable import Calculator

class CalculatorTests: XCTestCase {
    var sut: CalculatorItemQueue<Any>!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = CalculatorItemQueue<Any>()
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
    }
    
    func test_비어있을때isEmpty가트루인지확인() {
        let result = sut.isEmpty
        XCTAssertTrue(result)
    }
    
    func test_들어있을때isEmpty가거짓인지확인() {
        sut.enqueue(1)
        let result = sut.isEmpty
        XCTAssertFalse(result)
    }
    
    func test_들어있을때count값확인() {
        sut.enqueue(1)
        sut.enqueue(2)
        sut.enqueue(5)
        let result = sut.count
        XCTAssertEqual(result, 3)
    }
    
    func test_dequeue가되는지확인() {
        sut.enqueue(1)
        sut.enqueue(2)
        sut.enqueue(3)
        sut.dequeue()
        let result = sut.count
        XCTAssertEqual(result, 2)
    }
    
    func test_removeAll하는지확인() {
        sut.enqueue(1)
        sut.enqueue(2)
        sut.enqueue(3)
        sut.removeAll()
        let result = sut.count
        XCTAssertEqual(result, 0)
    }
}
