//
//  CalculatorItemQueue.swift
//  Calculator
//
//  Created by Erick on 2023/05/29.
//

struct CalculatorItemQueue {
    var queue: [CalculateItem] = []
    
    func count() -> Int {
        return queue.count
    }
    
    func isEmpty() -> Bool {
        return queue.isEmpty
    }
    
    mutating func enqueue(_ calculateItem: CalculateItem) {
        queue.append(calculateItem)
    }
    
    mutating func dequeue() -> CalculateItem? {
        return queue.isEmpty ? nil : queue.removeFirst()
    }
}
