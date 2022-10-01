//  Created by Aejong on 2022/09/27

import XCTest
@testable import Calculator

class FormulaTests: XCTestCase {
    var sut: Formula!
    var operands: CalculatorItemQueueByLinkedList<Double>!
    var operators: CalculatorItemQueueByLinkedList<Operator>!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        operands = CalculatorItemQueueByLinkedList()
        operators = CalculatorItemQueueByLinkedList()
    }
    
    func test_피연산자2개_연산자1개로_이루어진Formula에서_result함수호출시_연산결과가반환되어야한다() {
        // given
        operands.enqueue(1)
        operands.enqueue(2)
        
        operators.enqueue(.add)
        
        sut = Formula(operands: operands, operators: operators)
        
        // when
        var result:Double = 0
        do {
            result = try sut.result()
        } catch {
            
        }
        
        // then
        XCTAssertEqual(result, 3.0)
    }
    
    func test_3개이상의피연산자와_모두같은연산자로만이루어진Formula에서_result함수호출시_연산결과가반환되어야한다() {
        // given
        operands.enqueue(1)
        operands.enqueue(2)
        operands.enqueue(3)
        
        operators.enqueue(.add)
        operators.enqueue(.add)
        
        sut = Formula(operands: operands, operators: operators)
        
        // when
        var result:Double = 0
        do {
            result = try sut.result()
        } catch {
            
        }
        
        // then
        XCTAssertEqual(result, 6.0)
    }
    
    func test_3개이상의피연산자를_각각다른연산자를통해서도_연산이가능해야한다() {
        // given
        operands.enqueue(1)
        operands.enqueue(2)
        operands.enqueue(3)
        operands.enqueue(4)
        operands.enqueue(5)
        
        operators.enqueue(.add)
        operators.enqueue(.multiply)
        operators.enqueue(.divide)
        operators.enqueue(.subtract)
        
        sut = Formula(operands: operands, operators: operators)
        
        // when
        var result:Double = 0
        do {
            result = try sut.result()
        } catch {
            
        }
        
        // then
        XCTAssertEqual(result, -2.75)
    }
    
    func test_0으로나누었을때_오류를발생시켜야한다() {
        // given
        operands.enqueue(1)
        operands.enqueue(0)
        
        operators.enqueue(.divide)
        
        sut = Formula(operands: operands, operators: operators)
        
        // when, then
        XCTAssertThrowsError(try sut.result()) {error in
            print(error,"가 발생했습니다")
        }
    }
}
