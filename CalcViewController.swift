//
//  CalcViewController.swift
//  Written in Swift 4
//
//  A simple integer calculator which can return floats
//  and will allow a user to continue operations on the
//  resulting value if desired
//
//  The calculator stores an expression in a string and
//  continuously evaluates it as the user adds new inputs
//
//  Created by William Schroeder on 2/2/19.
//  Copyright © 2019 DePaul University. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var output: UITextField!
    
    let operators = "+-*/"
    
    var expression = ""
    var equalsCalled = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        
        if let selection = sender.currentTitle {
            
            if "0"..."9" ~= selection {
                
                // Reset the expression if user starts a new chain of expressions,
                // otherwise reset only the display value
                if equalsCalled && !operators.contains(expression.last!) {
                    
                    clearHelper()
                    
                } else if equalsCalled {
                    
                    equalsCalled = false
                    output.text = ""
                }
                
                // Update the display value as numbers are pressed
                if let display = output.text {

                    var outTemp = display
                    outTemp += selection
                    
                    output.text = outTemp
                }
            
            // Ensure multiple consecutive operators are not added
            // to the expression
            } else if !operators.contains(expression.last!) {
                
                // Update the value on the display and convert the number to a float if necessary
                if let fNum = Double(expression) {
                    
                    expression = String(format:"%f", fNum)
                }
                
                equalsHelper()

            // Replace the last operator chosen with the new operator
            } else {
                
                expression.remove(at: expression.index(before: expression.endIndex))
                equalsHelper()
            }
            
            expression += selection
        }
    }
    
    @IBAction func clearPressed(_ sender: UIButton) {
        clearHelper()
    }
    
    // Runs the code to clear the display
    func clearHelper() {
        
        equalsCalled = false
        expression = ""
        output.text = expression
    }
    
    @IBAction func equalsPressed(_ sender: UIButton) {
        equalsHelper()
    }
    
    // Runs the code to find the current value of the expression
    func equalsHelper() {
        if let lastChar = expression.last {
        
            if "0"..."9" ~= lastChar {
                
                let expn = NSExpression(format: expression)
                let answer = expn.expressionValue(with: nil, context: nil) as! Double
                
                // Update the display value without trailing zeros
                let outTemp = String(format: "%g", answer)
                output.text = outTemp
                
                // Update the value of the expression
                expression = String(format: "%f", answer)
                equalsCalled = true
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
