//
//  ViewController.swift
//  Calculator
//
//  Created by Apptist Inc. on 2023-01-26.
//

import UIKit
import AVKit

class ViewController: UIViewController {
    
    //MARK: - The view controller controls the view
    
    //MARK: - IBOulet - reference a UI Element
    @IBOutlet var outputLbl: UILabel! //screen
    
    //Properties
    var numberOnScreen: Double = 0 //current number on screen in label
    
    var previousNumber: Double = 0 //the previously entered number
    
    var performingMath = false //this will check if operators have been selected
    
    var operation = 0 //this will know what operation is being pressed
    
    //A number will represent each operation
    
    var btnSound: AVAudioPlayer! //To play a sound when button is clicked
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //MARK: - IBAction - perform an action on a button

    
    @IBAction func numberBtn(_ sender: UIButton) {
        //When a number button is pressed
        
        if performingMath == true {
            //If we have pressed an operator
            outputLbl.text = "" //clear the label on calculator
            outputLbl.text = String(sender.tag) //pass in the number of the button pressed
            numberOnScreen = Double(outputLbl.text!)! //need to set numberOnScreen to whatever the output label is
            performingMath = false
        } else {
            //If we have NOT pressed an operator
            outputLbl.text = outputLbl.text! + String(sender.tag) //append whatever is pressed and output to the label
            numberOnScreen = Double(outputLbl.text!)! //need to set numberOnScreen to whatever the output label is
        }
    }
    
    @IBAction func operators(_ sender: UIButton) {
        //When an operator is pressed
        
        //10 = C
        //11 = EQUALS
        //12 = ADD
        //13 = SUBSTRACT
        //14 = DIV
        //15 = MUL
        
        if(outputLbl.text != "" && sender.tag != 11 && sender.tag != 10) {
            //If we have not pressed equals or clear, and the output label is not empty
            previousNumber = Double(outputLbl.text!)!
            
            //Operations
            if sender.tag == 12 {
                //Add
                outputLbl.text = "+"
            } else if sender.tag == 13 {
                //subtract
                outputLbl.text = "-"
            } else if sender.tag == 14 {
                //div
                outputLbl.text = "/"
            } else if sender.tag == 15 {
                //mul
                outputLbl.text = "*"
            }
            
            operation = sender.tag //we will know which operator has been pressed
            
            performingMath = true //we know we have to do math now
        } else if sender.tag == 11 {
            //pressed equals
            
            if operation == 12 {
                //adding
                outputLbl.text = String(previousNumber + numberOnScreen)
            } else if operation == 13 {
                //sub
                outputLbl.text = String(previousNumber - numberOnScreen)
            } else if operation == 14 {
                //dividing
                outputLbl.text = String(previousNumber / numberOnScreen)
            } else if operation == 15 {
                //multiplying
                outputLbl.text = String(previousNumber * numberOnScreen)
            }
            
        } else if sender.tag == 10 {
            //pressed clear
            outputLbl.text = "" //clear the output
            previousNumber = 0 //reset
            numberOnScreen = 0 //reset
        }
        
    }

}

