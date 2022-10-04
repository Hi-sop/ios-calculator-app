//
//  UIStackView+.swift
//  Calculator
//
//  Created by SummerCat on 2022/10/04.
//

import Foundation

import UIKit

extension UIStackView {
    func removeAllSubviews() {
        self.arrangedSubviews.forEach {
            $0.removeFromSuperview()
        }
    }
}
