//
//  CalculatorItemQueue.swift
//  Calculator
//
//  Created by JeongTaek Han on 2021/11/09.
//

import Foundation

protocol CalculateItem { }

struct CalculatorItemQueue<Element> where Element: CalculateItem {
    private(set) var item: LinkedList<Element>
    
    var count: Int {
        self.item.count
    }
    
    var front: Element? {
        self.item.first
    }
    
    init() {
        self.item = LinkedList()
    }
    
    func enqueue(_ item: Element) {
        self.item.append(item)
    }
    
    @discardableResult
    func dequeue() -> Element? {
        self.item.remove(at: 0)
    }
}
