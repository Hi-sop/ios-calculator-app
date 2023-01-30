//
//  Node.swift
//  Calculator
//
//  Created by Harry on 2023/01/25.
//

final class Node<T> {
    let value: T
    var next: Node?
    
    init(value: T, next: Node? = nil) {
        self.value = value
        self.next = next
    }
    
    deinit {
        print("\(self.value) 노드 삭제!")
    }
}
