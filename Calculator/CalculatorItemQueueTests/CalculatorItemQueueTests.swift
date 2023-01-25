//  CalculatorItemQueueTests - CalculatorItemQueueTests.swift
//  created by vetto on 2023/01/25

import XCTest

final class CalculatorItemQueueTests: XCTestCase {
    var sut: CalculatorItemQueue<String>!
    
    override func setUpWithError() throws {
        sut = CalculatorItemQueue<String>()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    // isEmpty computed property test
    func test_head가_nil일_때_isQueueEmpty호출하면_true이다() {
        let result = sut.isEmpty
        let expectation = true
        
        XCTAssertEqual(result, expectation)
    }
    
    func test_CalculatorItemQueue에_Node를_추가하고_isQueueEmpty호출하면_false이다() {
        sut.head = Node(data: "head")
        
        let result = sut.isEmpty
        let expectation = false
        
        XCTAssertEqual(result, expectation)
    }
    
    // size computed property test
    func test_빈_queue에서_size를_호출하면_0이다() {
        let result = sut.size
        let expectation = 0
        
        XCTAssertEqual(result, expectation)
    }
    
    func test_queue에_Node를_1개넣고_size를_호출하면_1이다() {
        let headNode: Node = Node(data: "head")
        
        sut.head = headNode
        
        let result = sut.size
        let expectation = 1
        
        XCTAssertEqual(result, expectation)
    }
    
    func test_queue에_Node를_2개넣고_size를_호출하면_2이다() {
        let headNode: Node = Node(data: "head")
        let nextNode: Node = Node(data: "next")
        
        sut.head = headNode
        sut.head?.next = nextNode
        
        let result = sut.size
        let expectation = 2
        
        XCTAssertEqual(result, expectation)
    }
    
    // enqueue method test
    func test_빈_큐에_enqueue하면_head에_들어간다() {
        sut.enqueue(newData: Node(data: "head"))
        
        let result = sut.head?.data
        let expectation = "head"
        
        XCTAssertEqual(result, expectation)
    }
    
    func test_빈_큐에_enqueue하면_head랑_tail에_들어간다() {
        sut.enqueue(newData: Node(data: "head"))
        
        let result = sut.tail?.data
        let expectation = "head"
        
        XCTAssertEqual(result, expectation)
    }
    
    func test_큐에_두번_enqueue해도_head는_바뀌지_않는다() {
        sut.enqueue(newData: Node(data: "head"))
        sut.enqueue(newData: Node(data: "tail"))
        
        let result = sut.head?.data
        let expectation = "head"
        
        XCTAssertEqual(result, expectation)
    }
    
    func test_큐에_enqueue를_여러변하면_tail에_추가된다() {
        sut.enqueue(newData: Node(data: "head"))
        sut.enqueue(newData: Node(data: "middle"))
        sut.enqueue(newData: Node(data: "tail"))
        
        let result = sut.tail?.data
        let expectation = "tail"
        
        XCTAssertEqual(result, expectation)
    }
    
    // dequeue method test
    func test_빈_큐에_dequeue하면_nil이_반환되면_true() {
        let result = sut.dequeue()
        let expectation = result == nil ? true : false
        
        XCTAssertTrue(expectation)
    }
    
    func test_빈_큐의_하나의_node를_넣고_dequeue를_한번_하면_head의_data값이_반환된다() {
        sut.head = Node(data: "head")
        
        let result = sut.dequeue()
        let expectation = "head"
        
        XCTAssertEqual(result, expectation)
    }
    
    func test_빈_큐의_하나의_node를_넣고_dequeue를_한번_하면_head의_값이_nil이_된다() {
        sut.head = Node(data: "head")
        
        let _ = sut.dequeue()
        let result = sut.head
        let expectation = result == nil ? true : false
        
        XCTAssertTrue(expectation)
    }
    
    func test_빈_큐의_두개의_node를_넣고_dequeue를_한번_하면_head의_값이_다음값으로_바뀐다() {
        sut.head = Node(data: "head")
        sut.head?.next = Node(data: "middle")
        
        let _ = sut.dequeue()
        let result = sut.head?.data
        let expectation = "middle"
        
        XCTAssertEqual(result, expectation)
    }
    
    func test_빈_큐의_두개의_node를_넣고_dequeue를_두번_하면_head의_값이_nil이된다() {
        sut.head = Node(data: "head")
        sut.head?.next = Node(data: "middle")
        
        let _ = sut.dequeue()
        let _ = sut.dequeue()
        let result = sut.head
        let expectation = result == nil ? true : false
        
        XCTAssertTrue(expectation)
    }
    
    func test_빈_큐의_두개의_node를_넣고_dequeue를_두번_하면_tail의_값이_nil이된다() {
        sut.head = Node(data: "head")
        sut.head?.next = Node(data: "middle")

        let _ = sut.dequeue()
        let _ = sut.dequeue()
        let result = sut.tail
        let expectation = result == nil ? true : false
        
        XCTAssertTrue(expectation)
    }
    
    // peek test
    func test_빈_큐에서_peek연산_프로퍼티_실행하면_nil이_나온다() {
        let result = sut.peek
        let expectation = result == nil ? true : false
        
        XCTAssertTrue(expectation)
    }
    
    func test_큐에_한개의_노드를_넣고_peek을_실행하면_head의_값이_나온다() {
        sut.head = Node(data: "head")
        
        let result = sut.peek
        let expectation = "head"
        
        XCTAssertEqual(result, expectation)
    }
    
    func test_큐에_두개의_노드를_넣고_하나를_삭제한_후_peek을_실행하면_바뀐_head의_값이_나온다() {
        sut.head = Node(data: "head")
        sut.head?.next = Node(data: "middle")
        
        sut.head = sut.head?.next
        let result = sut.peek
        let expectation = "middle"
        
        XCTAssertEqual(result, expectation)
    }
    
    // clear method test
    func test_큐에_두개의_노드를_넣고_clear메소드를_호출하면_head가_nil이_된다() {
        sut.head = Node(data: "head")
        sut.head?.next = Node(data: "middle")
        
        sut.clear()
        
        let result = sut.head
        let expectation = result == nil ? true : false
        
        XCTAssertTrue(expectation)
    }
    
    func test_큐에_두개의_노드를_넣고_clear메소드를_호출하면_tail가_nil이_된다() {
        sut.head = Node(data: "head")
        sut.head?.next = Node(data: "middle")
        
        sut.clear()
        
        let result = sut.tail
        let expectation = result == nil ? true : false
        
        XCTAssertTrue(expectation)
    }
}
