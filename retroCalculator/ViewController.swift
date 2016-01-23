//
//  ViewController.swift
//  retroCalculator
//


import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Equals = "="
        case Empty = "Empty"
    }
    
    var btnSound: AVAudioPlayer!
    
    var runningNumber = ""
    var leftVal = ""
    var rightVal = ""
    
    var currentOperation = Operation.Empty
    var result = ""
    
    @IBOutlet weak var lblResults: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let soundURL = NSURL(fileURLWithPath: path!)
        
        do {
           try btnSound = AVAudioPlayer(contentsOfURL: soundURL)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }

    
    @IBAction func numberPressed(btn: UIButton) {
        playSound()
        runningNumber += "\(btn.tag)"
        lblResults.text = runningNumber;
    }
    
    @IBAction func onDividePressed(sender: AnyObject) {
        processOperation(Operation.Divide)
    }
    
    @IBAction func onMultiplyPressed(sender: AnyObject) {
        processOperation(Operation.Multiply)
    }
    
    @IBAction func onMinusPressed(sender: AnyObject) {
        processOperation(Operation.Subtract)
    }
  
    @IBAction func onAddPressed(sender: AnyObject) {
        processOperation(Operation.Add)
    }

    @IBAction func onEqualPressed(sender: AnyObject) {
        processOperation(Operation.Equals)
    }
    
    func processOperation(op: Operation) {
        playSound()
        
        if currentOperation != Operation.Empty {
            //DO some math
            
            if runningNumber != "" {
                
                rightVal = runningNumber
                runningNumber = ""
                
                switch currentOperation {
                case Operation.Multiply:
                    result = "\(Double(leftVal)! * Double(rightVal)!)"
                case Operation.Divide:
                    result = "\(Double(leftVal)! / Double(rightVal)!)"
                case Operation.Add:
                    result = "\(Double(leftVal)! + Double(rightVal)!)"
                case Operation.Subtract:
                    result = "\(Double(leftVal)! - Double(rightVal)!)"
                default:
                    result = leftVal
                }
                
                leftVal = result
                lblResults.text = result
            }
            
            currentOperation = op
            
            
        } else {
            //first time operator has been pressed
            leftVal = runningNumber
            runningNumber = ""
            currentOperation =  op
            
        }
        
    }
    
    func playSound() {
        if btnSound.playing {
            btnSound.stop()
        }
        
        btnSound.play()
    }
}

