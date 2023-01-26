//
//  CalculatorItemQueue.swift
//  Calculator
//
//  Created by Seoyeon Hong on 2023/01/26.
//
//MARK: Queue 타입 구현
struct CalculatorItemQueue<T>: CalculateItem {
    
    private var head: Node<T>?
    
    var last: Node<T>? {
        if head == nil {
            return nil
        }
        var node = head
        while node?.nextData != nil {
            node = node?.nextData
        }
        return node
    }
    
    var isEmpty: Bool {
        if head == nil {
            return true
        }else {
            return false
        }
    }
    
    mutating func enqueue(_ element: T) {
        if let lastNode = last{
            lastNode.nextData = Node(data: element)
        }else {
            head = Node(data: element)
        }
    }
    
    mutating func dequeue() -> T? {
        if head == nil { return nil }
        
        if head?.nextData == nil {
            head = nil
            return head?.data
        }
        
        var node = head
        while node?.nextData?.nextData != nil {
            node = node?.nextData
        }
        
        return node?.data
    }
    
    mutating func removeAll() {
        guard head != nil else {
            return
        }
        
        head = nil
    }
    
}

//MARK: Node 타입 생성
class Node<T> {
    
    var data: T
    var nextData: Node?
    
    init(data: T, nextData: Node? = nil) {
        self.data = data
        self.nextData = nextData
    }
    
}
