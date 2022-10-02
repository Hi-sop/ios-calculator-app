//
//  Calculator - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak private var inputNumberLabel: UILabel!
    @IBOutlet weak private var inputOperatorLabel: UILabel!
    @IBOutlet weak private var historyInputOperatorLabel: UILabel!
    @IBOutlet weak private var historyInputNumberLabel: UILabel!
    @IBOutlet weak private var historyInputStackView: UIStackView!
    @IBOutlet weak private var historyInputScrollView: UIScrollView!
    
    private let numberFormatter = NumberFormatter()
    private var formula = Formula(operands: CalculatorItemQueue<Double>(), operators: CalculatorItemQueue<Operator>())
    private var calculationFormula: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumSignificantDigits = 20
    }
    
    private func autoSlideScrollView() {
        historyInputScrollView.layoutIfNeeded()
        let bottomOffset = CGPoint(x: 0, y: historyInputScrollView.contentSize.height - historyInputScrollView.bounds.size.height + historyInputScrollView.contentInset.bottom)
            historyInputScrollView.setContentOffset(bottomOffset, animated: true)
    }
    
    private func addZero(inputText: String, zero: String) {
        let numberWithOutComma = inputText.replacingOccurrences(of: Literal.comma.value, with: "")
        let pointCount = numberWithOutComma.filter { $0 == Character(Literal.point.value) }.count
        
        if numberWithOutComma == Literal.numberZero.value && pointCount != 1 {
            return
        } else if numberWithOutComma != Literal.numberZero.value && pointCount != 1 {
            let numberWithOutComma = inputText.replacingOccurrences(of: Literal.comma.value, with: "")
            if let number: Double = Double(numberWithOutComma + zero) {
                inputNumberLabel.text = numberFormatter.string(for: number)
            }
        } else if numberWithOutComma != Literal.numberZero.value && pointCount == 1 {
            inputNumberLabel.text = inputText + zero
        }
    }
    
    private func addPoint(inputText: String, point: Character) {
        if inputText.filter({ $0 == point }).count >= 1 {
            return
        } else {
            inputNumberLabel.text = inputText + String(point)
        }
    }
    
    private func addNumber(inputText: String, number: String) {
        if inputText == Literal.numberZero.value {
            inputNumberLabel.text = "\(number)"
        } else {
            let numberWithOutComma = inputText.replacingOccurrences(of: Literal.comma.value, with: "")
            if let number: Double = Double(numberWithOutComma + number) {
                inputNumberLabel.text = numberFormatter.string(for: number)
            }
        }
    }
    
    private func makeHistoryInputLabel(inputText: String) -> UILabel {
        var inputLabel: UILabel {
            let inputLabel = UILabel()
            
            inputLabel.text = inputText
            inputLabel.textColor = UIColor.white
            inputLabel.translatesAutoresizingMaskIntoConstraints = false
            return inputLabel
        }
        return inputLabel
    }
    
    private func makeHistoryStactView(operatorLabel: UILabel, operandLabel: UILabel) -> UIStackView {
        var stackView: UIStackView {
            let stackView = UIStackView()
            
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.axis = .horizontal
            stackView.alignment = .fill
            stackView.distribution = .fill
            stackView.spacing = 8
            stackView.addArrangedSubview(operatorLabel)
            stackView.addArrangedSubview(operandLabel)
            return stackView
        }
        return stackView
    }
    
    private func convertOperator(operatorValue: String) -> String {
        switch operatorValue {
        case Literal.addition.value:
            return Literal.addition.value
        case Literal.subtraction.value:
            return Literal.subtraction.value
        case Literal.multiplication.value:
            return "*"
        case Literal.division.value:
            return "/"
        default:
            return ""
        }
    }
    
    private func addStackView(operatorText: String, inputText: String) {
        let operatorLabel = makeHistoryInputLabel(inputText: operatorText)
        let operandLabel = makeHistoryInputLabel(inputText: inputText)
        let stackView = makeHistoryStactView(operatorLabel: operatorLabel, operandLabel: operandLabel)
        historyInputStackView.addArrangedSubview(stackView)
        autoSlideScrollView()
    }
    
    private func addOperator(inputText: String, operatorValue: String) {
        let numberWithOutComma = inputText.replacingOccurrences(of: Literal.comma.value, with: "")
        let numberWithOutCommaAndInvertSign =
        numberWithOutComma.replacingOccurrences(of: Literal.invertSign.value, with: Literal.subtraction.value)
        
        if numberWithOutCommaAndInvertSign == Literal.numberZero.value && inputOperatorLabel.text == "" {
            return
        } else if numberWithOutCommaAndInvertSign == Literal.numberZero.value && operatorValue != "" {
            inputOperatorLabel.text = operatorValue
            calculationFormula.removeLast()
            calculationFormula += convertOperator(operatorValue: operatorValue)
        } else {
            guard let operatorText = inputOperatorLabel.text,
                  let doubleValue = numberFormatter.string(for: Double(numberWithOutCommaAndInvertSign)) else { return }
            
            addStackView(operatorText: operatorText, inputText: doubleValue)
            calculationFormula +=
            numberWithOutComma.replacingOccurrences(of: Literal.subtraction.value, with: Literal.invertSign.value)
            calculationFormula += convertOperator(operatorValue: operatorValue)
    
            inputNumberLabel.text = Literal.numberZero.value
            inputOperatorLabel.text = operatorValue
        }
    }
    
    private func showResult(inputText: String) {
        let numberWithOutComma = inputText.replacingOccurrences(of: Literal.comma.value, with: "")
        let numberWithOutCommaAndInvertSign =
        numberWithOutComma.replacingOccurrences(of: Literal.invertSign.value, with: Literal.subtraction.value)
        let operators = Operator.allCases.map { String($0.rawValue) }.joined()
        let separators = CharacterSet(charactersIn: operators)
        if calculationFormula.components(separatedBy: separators).count < 2 { return }
        
        if let operandValue = Double(numberWithOutCommaAndInvertSign),
           let operatorText = inputOperatorLabel.text,
           let doubleValue = numberFormatter.string(for: operandValue) {
            addStackView(operatorText: operatorText, inputText: doubleValue)
        }
        
        calculationFormula += numberWithOutComma
        formula = ExpressionParser.parse(from: calculationFormula)
        calculationFormula = ""
        
        if let result = numberFormatter.string(for: formula.result()),
           result != Literal.infinity.value {
            inputNumberLabel.text = String(result)
            inputOperatorLabel.text = ""
        } else {
            inputNumberLabel.text = Literal.NaN.value
            inputOperatorLabel.text = ""
        }
    }
    
    private func invertNumber(inputText: String) {
        if inputText == Literal.numberZero.value { return }
        
        if inputText.prefix(1) != Literal.invertSign.value {
            inputNumberLabel.text = Literal.invertSign.value + inputText
        } else {
            inputNumberLabel.text = inputText.replacingOccurrences(of: Literal.invertSign.value, with: "")
        }
    }
    
    private func deleteAllHistory() {
        calculationFormula = ""
        inputOperatorLabel.text = ""
        inputNumberLabel.text = Literal.numberZero.value
        
        for view in historyInputStackView.subviews {
            view.removeFromSuperview()
        }
    }
    
    @IBAction private func touchUpCalculatorButton(sender: UIButton) {
        guard let id = sender.restorationIdentifier,
              let inputText = inputNumberLabel.text else {
            return
        }
        
        switch id {
        case Literal.AC.buttonID:
            deleteAllHistory()
        case Literal.CE.buttonID:
            inputNumberLabel.text = Literal.numberZero.value
        case Literal.numberInvertion.buttonID:
            invertNumber(inputText: inputText)
        case Literal.division.buttonID:
            addOperator(inputText: inputText, operatorValue: Literal.division.value)
        case Literal.multiplication.buttonID:
            addOperator(inputText: inputText, operatorValue: Literal.multiplication.value)
        case Literal.subtraction.buttonID:
            addOperator(inputText: inputText, operatorValue: Literal.subtraction.value)
        case Literal.addition.buttonID:
            addOperator(inputText: inputText, operatorValue: Literal.addition.value)
        case Literal.result.buttonID:
            showResult(inputText: inputText)
        default:
            return
        }
    }
    
    @IBAction private func touchUpNumberButton(sender: UIButton) {
        guard let id = sender.restorationIdentifier,
              let inputText = inputNumberLabel.text else {
            return
        }
        
        switch id {
        case Literal.numberDoubleZero.buttonID:
            addZero(inputText: inputText , zero: Literal.numberDoubleZero.value)
        case Literal.numberZero.buttonID:
            addZero(inputText: inputText, zero: Literal.numberZero.value)
        case Literal.numberPoint.buttonID:
            addPoint(inputText: inputText, point: Character(Literal.numberPoint.value))
        case Literal.numberOne.buttonID:
            addNumber(inputText: inputText, number: Literal.numberOne.value)
        case Literal.numberTwo.buttonID:
            addNumber(inputText: inputText, number: Literal.numberTwo.value)
        case Literal.numberThree.buttonID:
            addNumber(inputText: inputText, number: Literal.numberThree.value)
        case Literal.numberFour.buttonID:
            addNumber(inputText: inputText, number: Literal.numberFour.value)
        case Literal.numberFive.buttonID:
            addNumber(inputText: inputText, number: Literal.numberFive.value)
        case Literal.numberSix.buttonID:
            addNumber(inputText: inputText, number: Literal.numberSix.value)
        case Literal.numberSeven.buttonID:
            addNumber(inputText: inputText, number: Literal.numberSeven.value)
        case Literal.numberEight.buttonID:
            addNumber(inputText: inputText, number: Literal.numberEight.value)
        case Literal.numberNine.buttonID:
            addNumber(inputText: inputText, number: Literal.numberNine.value)
        default:
            return
        }
    }
}
