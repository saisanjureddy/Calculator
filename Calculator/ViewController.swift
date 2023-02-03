//  ViewController.swift
//  Calculator
//
//  Created by Apptist Inc. on 2023-01-26.
//

import UIKit
import AVKit
import AVFoundation /**/

class ViewController: UIViewController {
    //audio player property to retain when playing sound required
    var player: AVAudioPlayer?

    // MARK: - The View Controller Controls The View.
    // MARK: - IBOulet - Reference A UI Element.
    
    // Display Screen:
    
    @IBOutlet var outputLbl: UILabel!
    
    // Properties
    
    // Variable For Current Number On Screen In Label:
    var numberOnScreen: Double = 0
    
    // Variable For The Previously Entered Number:
    var previousNumber: Double = 0
    
    // This Variable Will Check If Operators Have Been Selected:
    var performingMath = false
    
    // This Variable Will Know What Operation Is Being Pressed:
    var operation = 0    // A Number Will Represent Each Operation
    
    // Variable To Play A Sound When Button Is Clicked:
    var btnSound: AVAudioPlayer!
    
    override func viewDidLoad()
    {
        // Do Any Additional Setup After Loading The View.
        super.viewDidLoad()
    }
    
    // MARK: - IBAction - Perform An Action On A Button.
    
    // When A Number Button Is Pressed:
    @IBAction func numberBtn(_ sender: UIButton)
    {
        // To Play Sound:
        playSound()
        
        if performingMath == true
        {
            // If We Pressed An Operator:
            outputLbl.text = ""                             // Clear The Label On Calculator.
            outputLbl.text = String(sender.tag)             // Pass In The Number Of The Button Pressed.
            numberOnScreen = Double(outputLbl.text!)!       // Need To Set NumberOnScreen To Whatever The Output Label Is.
            performingMath = false
        }
        else
        {
            //If We Have NOT Pressed An Operator:
            outputLbl.text = outputLbl.text! + String(sender.tag)  // Append Whatever Is Pressed And Output To The Label.
            numberOnScreen = Double(outputLbl.text!)!              // Need To Set NumberOnScreen To Whatever The Output Label Is.
        }
    }
    
    // When An Operator Is Pressed:
    @IBAction func operators(_ sender: UIButton)
    {
        // To Play Sound:
        playSound()
        
        //10 = C
        //11 = EQUALS
        //12 = ADD
        //13 = SUBSTRACT
        //14 = DIV
        //15 = MUL
        //16 = PERCENTAGE
        
        if(outputLbl.text != "" && sender.tag != 11 && sender.tag != 10) {
            // If We Have Not Pressed Equals Or Clear The Output Label Is Not Empty.
            
            previousNumber = Double(outputLbl.text!)!
            
            // Operations:
            
            if sender.tag == 12
            {
                // ADD
                outputLbl.text = "+"
            }
            else if sender.tag == 13
            {
                // SUBSTRACT
                outputLbl.text = "-"
            }
            else if sender.tag == 14
            {
                // DIV
                outputLbl.text = "/"
            }
            else if sender.tag == 15
            {
                // MUL
                outputLbl.text = "*"
            }
            // We Will Know Which Operator Has Been Pressed.
            operation = sender.tag
            // We Have To Perform Math Now.
            performingMath = true
        } else if sender.tag == 11 {
            // Pressed Equals:
            if operation == 12
            {
                // Adding -
                outputLbl.text = String(previousNumber + numberOnScreen)
            }
            else if operation == 13
            {
                // Subtarcting -
                outputLbl.text = String(previousNumber - numberOnScreen)
            }
            else if operation == 14
            {
                // Dividing -
                outputLbl.text = String(previousNumber / numberOnScreen)
            }
            else if operation == 15
            {
                // Multiplying -
                outputLbl.text = String(previousNumber * numberOnScreen)
            }
            else if operation == 16
            {
                // Finding Percentage -
                outputLbl.text = String(calculatePercentage(value: previousNumber, percentageVal: numberOnScreen))
            }
            
        }
        
        
        else if sender.tag == 10
        {
            // Pressed Clear:
            outputLbl.text = ""     // Clear The Output
            previousNumber = 0      // Reset
            numberOnScreen = 0      // Reset
        }
        
    }
    
    // Function For Percentage:
    public func calculatePercentage(value:Double,percentageVal:Double)->Double
    {
        let val = value * percentageVal
        return val / 100.0
    }
    
    // Function To Play Sound:
    func playSound()
    {
        //Sound source path/url and used to initialize in AVAudioPlayer
        guard let url = Bundle.main.url(forResource: "mixkit-single-classic-click-1116", withExtension: "wav") else { return }

        //error handling
        do
        {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

            //unwraping optionlal value
            guard let player = player else { return }
            player.play()
        }
        catch let error
        {
            print(error.localizedDescription)
        }
    }
}
