//
//  CalculatorItemQueue.swift
//  Calculator
//
//  Created by Kay on 2022/05/17.
//

import Foundation

struct CalculatorItemQueue<T>: CalculateItem {
    private var queue: [T?] = []
    private var head: Int = 0
    
    var count: Int {
        return queue.count
    }
    
    var isEmpty: Bool {
        return queue.isEmpty
    }
    
    var front: T? {
        if queue.count == 0 {
            return nil
        } else {
            guard let element = queue[head] else { return nil}
            return element
        }
    }
    
    var rear: T? {
        if queue.count == 0 {
            return nil
        } else {
            guard let element = queue[queue.count - 1] else { return nil}
            return element
        }
    }
    
    mutating func enqueue(_ element: T) {
        queue.append(element)
    }
    
    mutating func dequeue() -> T? {
        if queue.count == 0 {
            return nil
        } else {
            guard let element = queue[head] else { return nil }
            head += 1
            return element
        }
    }
    
    mutating func clear() {
        queue.removeAll()
    }
}
