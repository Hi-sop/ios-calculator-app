//
//  CalculatorItemQueue.swift
//  Created by Wonbi on 2022/09/19.
//

import Foundation

struct CalculatorItemQueue {
    var input: [CalculateItem] = []
    var output: [CalculateItem] = []
    
    var isEmpty: Bool {
        input.isEmpty && output.isEmpty
    }
    
    var count: Int {
        input.count + output.count
    }
    
    mutating func enqueue(_ element: CalculateItem) {
        input.append(element)
    }
    
    mutating func dequeue() -> CalculateItem? {
        if output.isEmpty {
            output = input.reversed()
            input.removeAll()
        }
        return output.popLast()
    }
}
