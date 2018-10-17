//
//  ViewController.swift
//  Retro calculator
//
//  Created by Rebecca Wordsworth on 20/12/2016.
//  Copyright © 2016 Rebecca Wordsworth. All rights reserved.
//

import UIKit
import AVFoundation

class MainViewController: UIViewController {
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    @IBOutlet weak var outputLabel: UILabel!

    var currentOperation = Operation.Empty      // If we have pressed an op button, that state is stored here
    var runningNumber = ""                      // Current number that should be reflected by the label
    var leftVarStr = ""
    var rightVarStr = ""
    var result = ""
    var btnSound: AVAudioPlayer!
    
    
    @IBAction func clearPressed(_ sender: AnyObject) {
        currentOperation = .Empty
        runningNumber = ""
        leftVarStr = ""
        rightVarStr = ""
        result = ""
       
        outputLabel.text = "0"
    }
    
    
    @IBAction func buttonPressed(_ sender: AnyObject) {
        playSound()
        
        if let tag = sender.tag {
            runningNumber += "\(tag)"
            outputLabel.text = runningNumber
        }
    }
    
    
    @IBAction func onDividePressed(_ sender: AnyObject) {
        processOperation(operation: .Divide)
    }
    
    
    @IBAction func onMultiplyPressed(_ sender: AnyObject) {
        processOperation(operation: .Multiply)
    }
    
    
    @IBAction func onSubtractPressed(_ sender: AnyObject) {
        processOperation(operation: .Subract)
    }
    
    
    @IBAction func onAddPressed(_ sender: AnyObject) {
        processOperation(operation: .Add)
    }
    
    
    @IBAction func onEqualsPressed(_ sender: AnyObject) {
        processOperation(operation: currentOperation)
    }
    
    
    func playSound() {
        if btnSound.isPlaying {
            btnSound.stop()
        }
        
        btnSound.play()
    }

    
    func processOperation(operation: Operation) {
        playSound()
        
        if currentOperation != Operation.Empty {
            
            //A user selected an operator, but then selected another operator first enertered number
            if runningNumber != "" {
                
                rightVarStr = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Multiply {
                    result = "\(Double(leftVarStr)! * Double(rightVarStr)!)"
                    
                } else if currentOperation == Operation.Divide {
                    result = "\(Double(leftVarStr)! / Double(rightVarStr)!)"
                    
                } else if currentOperation  == Operation.Subract {
                    result = "\(Double(leftVarStr)! - Double(rightVarStr)!)"
                    
                } else if currentOperation == Operation.Add {
                    result = "\(Double(leftVarStr)! + Double(rightVarStr)!)"

                }
                
                leftVarStr = result
                outputLabel.text = result
            }
            
            currentOperation = operation
        } else {
            //this is the first time an opeartor has been pressed
            leftVarStr = runningNumber
            runningNumber = ""
            currentOperation = operation
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let soundURL = URL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOf: soundURL)
            btnSound.prepareToPlay()
            
        } catch let err as NSError {
            print(err.debugDescription)
            
        }
        
        outputLabel.text = "0"
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

