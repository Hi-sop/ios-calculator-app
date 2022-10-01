//  Created by Aejong on 2022/09/27.

struct Formula {
    var operands: CalculatorItemQueueByLinkedList<Double>
    var operators: CalculatorItemQueueByLinkedList<Operator>
    
    mutating func result() throws -> Double {
        var result: Double
        
        guard let initialValue: Double = operands.dequeue() else { return 0 }
        var calculatingValue: Double = initialValue
        
        while !operands.isEmpty {
            guard let rhs = operands.dequeue(),
                  let unitOperator = operators.dequeue() else { return 0 }
            
            calculatingValue = try unitOperator.calculate(lhs: calculatingValue, rhs: rhs)
        }
        result = calculatingValue
        
        return result
    }
}
