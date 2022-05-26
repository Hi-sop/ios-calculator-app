//
//  Calculator - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var scrollViewContents: UIStackView!
    @IBOutlet weak var currendOperand: UILabel!
    @IBOutlet weak var currentOperator: UILabel!
    private var operationQueue: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clearScrollviewContent()
        // Do any additional setup after loading the view.
    }
    // MARK: - IBAction
    @IBAction func pressOperandButton(_ sender: UIButton) {
        guard currendOperand.text != "0" else {
            return
        }
        currendOperand?.text = currendOperand?.text ?? "" + (sender.currentTitle ?? "")
    }
    
    @IBAction func pressOperatorButton(_ sender: UIButton) {
        
    }
    
    @IBAction func pressAllClearButton(_ sender: UIButton) {
        clearScrollviewContent()
        clearCurrentOperand()
        clearCurrentOperator()
        
    }
    @IBAction func pressClearEntryButton(_ sender: UIButton) {
        clearCurrentOperand()
    }
    //MARK: - ViewController Method
    private func clearCurrentOperand() {
        currendOperand.text = "0"
    }
    private func clearCurrentOperator() {
        currentOperator.text = ""
    }
    private func clearScrollviewContent() {
        scrollViewContents.subviews.forEach { UIView in
            UIView.removeFromSuperview()
        }
    }
}

