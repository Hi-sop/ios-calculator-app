import Foundation

struct CalculatorChecker {
    private(set) var enteringNumber = Sign.empty
    private(set) var calculationExpression: String = Sign.empty
    private var labelUpdateClosure: (String) -> Void
    
    init(updateClosure closure: @escaping (String) -> Void) {
        self.labelUpdateClosure = closure
    }
    
    mutating func appendingNumber(_ numberPad: String) {
        guard hasCurrentInput(enteringNumber) else {
            enteringNumber = numberPad
            labelUpdateClosure(enteringNumber)
            return
        }
        
        let addedEnteringNumber = enteringNumber.convertToDouble(appending: numberPad)
        enteringNumber = convertToDecimal(for: addedEnteringNumber)
        labelUpdateClosure(enteringNumber)
    }
    
    mutating func appendingExpression(_ operatorText: String) {
        
        let convertedNumber = convertToDecimal(for: enteringNumber.convertToDouble())
        calculationExpression += (operatorText + convertedNumber)
        enteringNumber = Sign.empty
        labelUpdateClosure(enteringNumber)
    }
    
    mutating func appendingZero(_ zeroPad: String) {
        guard isZero(enteringNumber) == false && hasCurrentInput(enteringNumber) else {
            enteringNumber = Sign.zero
            return
        }
        
        guard hasDot(enteringNumber) else {
            appendingNumber(zeroPad)
            return
        }

        enteringNumber += zeroPad
        labelUpdateClosure(enteringNumber)
    }
    
    mutating func appendingDot() {
        guard hasDot(enteringNumber) == false else { return }
        
        enteringNumber = hasCurrentInput(enteringNumber) ? (enteringNumber + Sign.dot) : Sign.zeroDot
        labelUpdateClosure(enteringNumber)
    }
    
    func appendingDot(_ currentText: String) -> String {
        if currentText == Sign.empty {
            return Sign.zero + Sign.dot
        }
        return currentText + Sign.dot
    }
    
    mutating func changeSign() {
        guard enteringNumber.contains(Sign.minus) == false else {
            enteringNumber = enteringNumber.replacingOccurrences(of: Sign.minus, with: Sign.empty)
            labelUpdateClosure(enteringNumber)
            return
        }
        enteringNumber = (Sign.minus + enteringNumber)
        labelUpdateClosure(enteringNumber)
    }
    
    mutating func initialState() {
        calculationExpression = Sign.empty
        initialEnteringNumber()
    }
    
    mutating func initialEnteringNumber() {
        enteringNumber = Sign.empty
        labelUpdateClosure(enteringNumber)
    }
    
    func hasCurrentInput(_ currentText: String) -> Bool {
        if currentText == Sign.empty || currentText == Sign.space {
            return false
        }
        return true
    }
    
    private func hasDot(_ currentText: String) -> Bool {
        return currentText.contains(Sign.dot) ? true : false
    }
    
    func isZero(_ currentText: String) -> Bool {
        return currentText == Sign.zero ? true : false
    }
    
    func calculate(with expression: String) -> Double {
        var formula = ExpressionParser.parse(from: expression.split(separator: ",").joined())
        return formula.result()
    }
    
    func convertToDecimal(for number: Double) -> String {
        let numberFormatter =  NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.roundingMode = .halfUp
        numberFormatter.maximumFractionDigits = 20
        return numberFormatter.string(for: number) ?? Sign.zero
    }
}
