//
//  NodeTests.swift
//  NodeTests
//
//  Created by Daehoon Lee on 2023/05/30.
//

import XCTest
@testable import Calculator

final class NodeTests: XCTestCase {
    var sut: Node<Int>!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = Node<Int>(data: 0, next: nil)
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
    }
    
    func test_init_data를0으로초기화한다() {
        // given
        let expectedData: Int = 0
        
        // when
        let testNode: Node = Node<Int>(data: expectedData, next: nil)
        
        // then
        XCTAssertEqual(testNode.data, expectedData)
    }
    
    func test_init_data를더하기연산자로초기화한다() {
        // given
        let expectedData: String = "+"
        
        // when
        let testNode: Node = Node<String>(data: expectedData, next: nil)
        
        // then
        XCTAssertEqual(testNode.data, expectedData)
    }
    
    func test_init_next를다음Node로초기화한다() {
        // given
        let expectedData: Int = 0
        let expectedNext: Node = Node(data: 1, next: nil)
        
        // when
        let testNode: Node = Node<Int>(data: expectedData, next: expectedNext)
        
        // then
        XCTAssertTrue(testNode.next === expectedNext)
    }
    
    func test_init_next의전달인자없이초기화한다() {
        // given
        let expectedData: Int = 0
        
        // when
        let testNode: Node = Node<Int>(data: expectedData)
        
        // then
        XCTAssertTrue(testNode.next == nil)
    }
}
