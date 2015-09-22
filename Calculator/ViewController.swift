//
//  ViewController.swift
//  Calculator
//
//  Created by Zhu Jicheng on 15/9/20.
//  Copyright (c) 2015年 Zhu Jicheng. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    @IBOutlet weak var display: UILabel!
    @IBOutlet weak var history: UILabel! //Task4
    
    var userIsInTheMiddleOfTypingANumber = false
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        history.text = history.text! + digit //Task4
        
        if userIsInTheMiddleOfTypingANumber {
            display.text = display.text! + digit

        } else {
            display.text = digit
            userIsInTheMiddleOfTypingANumber = true
        }
        //println("digit = \(digit)")
    }
    
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        history.text = history.text! + operation //Task4
            if userIsInTheMiddleOfTypingANumber {
                enter()
            }
        
        switch operation {
        case "×": performOperation { $0 * $1 }
        case "÷": performOperation { $1 / $0 }
        case "+": performOperation { $0 + $1 }
        case "−": performOperation { $1 - $0 }
        case "√": performOperation1 { sqrt($0) }
        case "sin": performOperation1 { sin($0) } //Task3
        case "cos": performOperation1 { cos($0) } //Task3
        default: break

        }
    }
    
    func performOperation(operation: (Double,Double) -> Double) {
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }
    
    func performOperation1(operation: Double -> Double) {
        if operandStack.count >= 1 {
            displayValue = operation(operandStack.removeLast())
            enter()
        }
    }
    
    var operandStack = Array<Double>()
    
    @IBAction func enter() {
            userIsInTheMiddleOfTypingANumber = false
            operandStack.append(displayValue)
            println("operandStack = \(operandStack)")
    }
    
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"
            userIsInTheMiddleOfTypingANumber = false
        }
    }


    @IBAction func clear(sender: UIButton) {
        display.text = "0"
        history.text = "History:"
    }

}


