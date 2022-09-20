//
//  CalculatorItemQueue.swift
//  Calculator
//
//  Created by Baem on 2022/09/20.
//

struct CalculatorItemQueue: CalculatorItem {
    var queue: [String] = [String]()
    
    mutating func addQueue(_ element: String) {
        queue.append(element)
    }
    
}
