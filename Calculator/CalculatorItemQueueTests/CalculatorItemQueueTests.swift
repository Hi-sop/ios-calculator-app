//
//  CalculatorItemQueueTests.swift
//  CalculatorItemQueueTests
//
//  Created by Gundy on 2022/09/19.
//

import XCTest
@testable import Calculator

class CalculatorItemQueueTests: XCTestCase {
    var sut: CalculatorItemQueue<String>!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = CalculatorItemQueue<String>()
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
    }
    
    func test_enqueue호출시_data가비어있는지() {
        let input = Int.random(in: 1...9)
        
        sut.enqueue(String(input))
        
        XCTAssertFalse(sut.data.isEmpty)
    }
    
    func test_enqueue호출시_3을전달하면_data의마지막값과같은지() {
        let input = 3
        sut.enqueue(String(input))
        
        let result = sut.data[sut.data.count-1]
        
        XCTAssertEqual(result, "3")
    }
    
    func test_enqueue반복호출시_data의마지막값과_전달값7이같은지() {
        for _ in 1...5 {
            sut.enqueue(String(Int.random(in: 0...9)))
        }
        let input = 7
        sut.enqueue(String(input))
        
        let result = sut.data[sut.data.count-1]
        
        XCTAssertEqual(result, "7")
    }
    
    func test_dequeue호출시_반환값이있는지() {
        sut.data = [String(Int.random(in: 0...9))]
        
        let result = sut.dequeue()
        
        XCTAssertNotNil(result)
    }
}
