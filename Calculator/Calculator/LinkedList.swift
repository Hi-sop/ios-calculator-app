//
//  LinkedList.swift
//  Calculator
//
//  Created by idinaloq on 2023/05/29.
//

struct LinkedList<T> {
    private(set) var head: Node<T>? {
        didSet {
            guard head == nil else {
                return
            }
            tail = nil
        }
    }
    
    private(set) var tail: Node<T>?
    
    var isEmpty: Bool {
        return head == nil
    }
    
    mutating func append(data: T) {
        let node: Node = Node(data: data)
        
        guard !isEmpty else {
            head = node
            tail = head
            return
        }
        tail?.next = node
        tail = node

    }
    
    mutating func removeFirst() -> T? {
        guard !isEmpty else {
            return nil
        }
        
        let headData = head?.data
        head = head?.next
        
        return headData
    }
    
    mutating func removeAll() {
        head = nil
        tail = nil
    }
}
