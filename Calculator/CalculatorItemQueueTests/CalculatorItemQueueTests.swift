//
//  CalculatorItemQueueTests.swift
//  CalculatorItemQueueTests
//
//  Created by Gundy on 2022/09/19.
//

import XCTest
@testable import Calculator

class CalculatorItemQueueTests: XCTestCase {
    var sut: CalculatorItemQueue!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = CalculatorItemQueue()
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
    }
    
    func test_enqueue호출시_data가비어있는지() {
        // given
        let input = "0"
        
        // when
        sut.enqueue(input)
        
        // then
        XCTAssertFalse(sut.data.isEmpty)
    }
    
    func test_enqueue호출시_3을전달하면_data의마지막값과같은지() {
        // given
        let input = "3"
        
        // when
        sut.enqueue(input)
        if let result = sut.data.last as? String{
            // then
            XCTAssertEqual(result, "3")
        }
    }

    func test_enqueue반복호출시_data의마지막값과_전달값의마지막값이같은지() {
        // given
        let input = ["1", "3", "5", "7"]
        
        // when
        input.forEach{ sut.enqueue($0) }
        if let result = sut.data.last as? String{
            // then
            XCTAssertEqual(result, "7")
        }
    }

    func test_data가있을때_dequeue호출시_반환값이있는지() {
        // given
        sut.data = ["1"]
        
        // when
        let result = sut.dequeue()
        
        // then
        XCTAssertNotNil(result)
    }

    func test_data가없을때_dequeue호출시_nil을반환하는지() {
        // given
        sut.data = []
        
        // when
        let result = sut.dequeue()
        
        // then
        XCTAssertNil(result)
    }

    func test_data가있을때_dequeue호출시_data의카운트가감소하는지() {
        // given
        sut.data = ["1", "3", "5", "7"]
        
        // when
        sut.dequeue()
        let result = sut.data.count
        
        // then
        XCTAssert(result < 4)
    }

    func test_data가있을때_peek호출시_반환값이있는지() {
        // given
        sut.data = ["1"]
        
        // when
        let result = sut.peek
        
        // then
        XCTAssertNotNil(result)
    }

    func test_data가없을때_peek호출시_nil을반환하는지() {
        // given
        sut.data = []
        
        // when
        let result = sut.peek
        
        // then
        XCTAssertNil(result)
    }

    func test_data가있을때_peek호출시_data의카운트가변하는지() {
        // given
        sut.data = ["1", "3", "5", "7"]
        
        // when
        let _ = sut.peek
        let result = sut.data.count
        
        // then
        XCTAssert(result == 4)
    }

    func test_data가있을때_clear호출시_data가빈배열인지() {
        // given
        sut.data = ["1", "3", "5", "7"]
        
        // when
        sut.clear()
        let result = sut.data
        
        // then
        XCTAssert(result.isEmpty)
    }

    func test_data가있을때_count호출시_0이아닌지() {
        // given
        sut.data = ["1"]
        
        // when
        let result = sut.count
        
        // then
        XCTAssertNotEqual(result, 0)
    }

    func test_data의요소가4개일때_count호출시_4를반환하는지() {
        // given
        sut.data = ["1", "3", "5", "7"]
        
        // when
        let result = sut.count
        
        // then
        XCTAssertEqual(result, 4)
    }

    func test_data의요소가있을때_isEmpty호출시_false를반환하는지() {
        // given
        sut.data = ["1"]
        
        // when
        let result = sut.isEmpty
        
        // then
        XCTAssertFalse(result)
    }

    func test_data의요소가없을때_isEmpty호출시_true를반환하는지() {
        // given
        sut.data = []
        
        // when
        let result = sut.isEmpty
        
        // then
        XCTAssertTrue(result)
    }

    func test_capacity와count가같을때_isFull호출시_true를반환하는지() {
        // given
        sut.data.reserveCapacity(sut.data.count)
        
        // when
        let result = sut.isFull
        
        // then
        XCTAssertTrue(result)
    }

    func test_capacity와count가다를때_isFull호출시_false를반환하는지() {
        // given
        sut.data.reserveCapacity(sut.data.count + 1)
        
        // when
        let result = sut.isFull
        
        // then
        XCTAssertFalse(result)
    }

    func test_data의요소가4개일때_capasity_getter호출시_현재용량과같은지() {
        // given
        sut.data = ["1", "3", "5", "7"]
        
        // when
        let result = sut.capacity
        
        // then
        XCTAssertEqual(result, sut.data.capacity)
    }

    func test_capasity_setter호출시_기존용량과다른지() {
        // given
        let originCapacity = sut.capacity
        
        // when
        sut.capacity += 1
        let result = sut.capacity
        
        // then
        XCTAssertNotEqual(result, originCapacity)
    }

    func test_인덱스범위내에서_insert호출시_인덱스2에_입력값9가_위치하는지() {
        // given
        let input = "9"
        sut.data = ["1", "3", "5", "7"]
        
        // when
        sut.insert(input, at: 2)
        if let result = sut.data[2] as? String {
            // then
            XCTAssertEqual(result, "9")
        }
    }

    func test_인덱스범위내에서_remove호출시_인덱스의_값이변하는지() {
        // given
        sut.data = ["1", "3", "5", "7"]
        let input = 2
        guard let originValue = sut.data[input] as? String else {
            return
        }
        
        // when
        sut.remove(at: input)
        if let result = sut.data[input] as? String {
            // then
            XCTAssertNotEqual(result, originValue)
        }
    }
}
