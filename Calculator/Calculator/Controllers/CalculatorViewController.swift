//
//  Calculator - CalculatorViewController.swift
//  Created by yagom.
//  Copyright © yagom. All rights reserved.
// 

import UIKit

final class CalculatorViewController: UIViewController {
    
    @IBOutlet weak var operatorLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var historyScrollView: UIScrollView!
    @IBOutlet weak var historyStackView: UIStackView!
    
    var currentOperand: String = Constant.defaultZero
    var currentOperator: String = Constant.empty
    private var calculateHistory: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUILabelText()
        clearCalculateHistory()
    }
    
    private func setUILabelText() {
        operatorLabel.text = Constant.empty
        resultLabel.text = Constant.zero
    }
    
    private func setDefaultOperand() {
        resultLabel.text = Constant.zero
        currentOperand = Constant.defaultZero
    }
    
    private func clearCalculateHistory() {
        historyStackView.subviews.forEach{ $0.removeFromSuperview() }
    }
    
    private func convertOperandToDouble() throws -> Double {
        guard let convertToDouble = Double(currentOperand) else { throw CalculatorError.convertFailToDouble }
        return convertToDouble
    }
    
    private func updateResultLabel() {
        do {
            let convertToDouble = try convertOperandToDouble()
            let currentExpression = applyNumberFormatter(number: convertToDouble)
            resultLabel.text = currentExpression
        } catch CalculatorError.convertFailToDouble {
            resultLabel.text = CalculatorError.convertFailToDouble.message
        } catch {
            resultLabel.text = CalculatorError.someError.message
        }
    }
    
    private func applyNumberFormatter(number: Double) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.usesSignificantDigits = true
        numberFormatter.maximumIntegerDigits = 20
        numberFormatter.maximumFractionDigits = 4
        numberFormatter.maximumSignificantDigits = 20
        guard let result = numberFormatter.string(for: number) else { return Constant.empty }
        
        return result
    }
    
    private func makeHistoryStackViewLabel(item: String) -> UILabel {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.textColor = .white
        label.text = "\(item)"
        label.textAlignment = .right
        label.numberOfLines = 0
        label.isHidden = true
        label.adjustsFontForContentSizeCategory = true
        UIView.animate(withDuration: 0.3) {
            label.isHidden = false
        }
        return label
    }
    
    private func updateCalculateHistory(currentOperator: String, currentOperand: String) {
        guard let operand = Double(currentOperand) else { return }
        
        let label = makeHistoryStackViewLabel(item: currentOperator + Constant.space + applyNumberFormatter(number: operand))
        historyStackView.addArrangedSubview(label)
        view.layoutIfNeeded()
        
        let contentOffsetValue: CGFloat = historyScrollView.contentSize.height - historyScrollView.frame.height
        historyScrollView.setContentOffset(CGPoint(x: 0, y: contentOffsetValue), animated: true)
    }
    
    @IBAction func tappedNumberPads(_ sender: UIButton) {
        let tappedNumber = sender.currentTitle
        guard let number = tappedNumber else { return }
        
        if currentOperand == Constant.defaultZero || currentOperand == Constant.zero {
            if number == Constant.doubleZero || currentOperator == Constant.calculate {
                return
            }
            currentOperand = number
        } else {
            currentOperand += number
        }
        
        updateResultLabel()
    }
    
    @IBAction func tappedOperatorPads(_ sender: UIButton) {
        if calculateHistory.isEmpty && currentOperand == Constant.defaultZero {
            return
        }
        
        let tappedOperator = sender.currentTitle
        guard let operators = tappedOperator else { return }
        
        operatorLabel.text = operators
        
        if currentOperator == Constant.calculate {
            currentOperator = operators
            setDefaultOperand()
            return
        }
        
        if currentOperand == Constant.defaultZero {
            currentOperator = operators
            return
        }
        
        calculateHistory.append(currentOperator)
        calculateHistory.append(currentOperand)
        
        updateCalculateHistory(currentOperator: currentOperator, currentOperand: currentOperand)
        currentOperator = operators
        setDefaultOperand()
    }
    
    @IBAction func tappedCalculate(_ sender: UIButton) {
        if currentOperand == Constant.defaultZero || calculateHistory.isEmpty || currentOperator == Constant.calculate {
            return
        }
        
        updateCalculateHistory(currentOperator: currentOperator, currentOperand: currentOperand)
        
        calculateHistory.append(currentOperator)
        calculateHistory.append(currentOperand)
        
        var removeFirstHistory = calculateHistory
        removeFirstHistory.removeFirst()
        
        currentOperator = Constant.calculate
        operatorLabel.text = Constant.empty
        
        let formula = ExpressionParser.parse(from: removeFirstHistory.joined())
        
        executeCalculate(formula)
    }
    
    private func executeCalculate(_ formula: Formula) {
        do {
            let result = try formula.result()
            if result.isNaN {
                resultLabel.text = Constant.nan
            } else {
                resultLabel.text = applyNumberFormatter(number: result)
            }
            currentOperand = Constant.zero
        } catch CalculatorError.noneOperand {
            resultLabel.text = CalculatorError.noneOperand.message
        } catch CalculatorError.noneOperator {
            resultLabel.text = CalculatorError.noneOperator.message
        } catch {
            resultLabel.text = CalculatorError.someError.message
        }
    }
    
    @IBAction func tappedDotPads(_ sender: UIButton) {
        if currentOperand.contains(Constant.dot) || currentOperand == Constant.defaultZero || currentOperator == Constant.calculate {
            return
        } else {
            currentOperand += Constant.dot
            updateResultLabel()
        }
    }
    
    @IBAction func tappedChangePositiveNegative(_ sender: UIButton) {
        if currentOperand == Constant.defaultZero || currentOperand == Constant.zero {
            return
        }
        
        if currentOperand.contains(Constant.negative) {
            currentOperand.removeFirst()
        } else {
            currentOperand = Constant.negative + currentOperand
        }
        
        updateResultLabel()
    }
    
    @IBAction func tappedAllClear(_ sender: UIButton) {
        setUILabelText()
        clearCalculateHistory()
        currentOperand = Constant.defaultZero
        currentOperator = Constant.empty
        calculateHistory.removeAll()
    }
    
    @IBAction func tappedClearEntry(_ sender: UIButton) {
        setDefaultOperand()
    }
}
