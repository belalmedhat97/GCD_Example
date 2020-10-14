//
//  ViewController.swift
//  GCD
//
//  Created by Belal medhat on 10/13/20.
//  Copyright © 2020 Belal medhat. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    let concurrentQueue = DispatchQueue(label: "cqueue",attributes: .concurrent) // concurrent queue operation done in concurrently  depending on the system's current conditions and resources. The decision on when to start a task is up to GCD
    
    let serialQueue = DispatchQueue(label: "squeue") // serial queue operation done in sequence output will be task 1, task 2,task 3
   



    
    override func viewDidLoad() {
        super.viewDidLoad()
        Progress1.progress = 0.0
        Progress2.progress = 0.0
        Progress3.progress = 0.0
      
        
        // Do any additional setup after loading the view.
    }
  
    @IBOutlet weak var Concurrent: UIButton!
    @IBOutlet weak var Serial: UIButton!
    @IBOutlet weak var Progress1: UIProgressView!
    @IBOutlet weak var Progress2: UIProgressView!
    @IBOutlet weak var Progress3: UIProgressView!
    @IBOutlet weak var TaskF1: UILabel!
    @IBOutlet weak var TaskF2: UILabel!
    @IBOutlet weak var TaskF3: UILabel!
    
    @IBAction func SerialButton(_ sender: Any) {
    
        ButtonPressedDisable(WorkSerial: false, WorkConcurrent: false)
        // MARK:- add serial tasks for different progressview
            serialQueue.async {
                self.performCalculation(5000, tag: Tasks.Task1, taskProgress: self.Progress1)
            }
            serialQueue.async {
                self.performCalculation(80000, tag: Tasks.Task2, taskProgress: self.Progress2)
                  }
            serialQueue.async {
                self.performCalculation(500, tag: Tasks.Task3, taskProgress: self.Progress3)
                  }
     
    }
    @IBAction func ConcurrentButton(_ sender: Any) {
        // MARK:- add concurrent tasks for different progressview
        ButtonPressedDisable(WorkSerial: false, WorkConcurrent: false)



        concurrentQueue.async {
            self.performCalculation(5000, tag: Tasks.Task1, taskProgress: self.Progress1)
        }
        concurrentQueue.async {
            self.performCalculation(80000, tag: Tasks.Task2, taskProgress: self.Progress2)
              }
        concurrentQueue.async {
            self.performCalculation(500, tag: Tasks.Task3, taskProgress: self.Progress3)
              }
    
    }
    // MARK:- Block serial and concurrent Button To not overlab the current calaculation to update progressView
    func ButtonPressedDisable(WorkSerial:Bool,WorkConcurrent:Bool){
        Concurrent.isUserInteractionEnabled = WorkConcurrent
        Serial.isUserInteractionEnabled = WorkSerial
    }
    @IBAction func Reset(_ sender: UIButton) {
        // reset all progressview and tasks time to inital value
            Progress1.progress = 0.0
            Progress2.progress = 0.0
            Progress3.progress = 0.0
            TaskF1.text = ""
            TaskF2.text = ""
            TaskF3.text = ""
        
        ButtonPressedDisable(WorkSerial: true, WorkConcurrent: true)

        

    }
    
    func performCalculation(_ iterations: Int, tag: Tasks,taskProgress:UIProgressView) {
        let start = CFAbsoluteTimeGetCurrent() // begin time for starting task
        for x in 0...iterations {
            // MARK:- Precantage for progressview calculation.

            let value:Float = Float((iterations - (iterations-x)))
            let ResultPrecntage = Float(value/Float(iterations))
            let ApproximatedValue = Float(String(format: "%.1f", ResultPrecntage))
            
            // MARK:- update the UI progressview using Main Thread
            DispatchQueue.main.async {

                taskProgress.setProgress(ApproximatedValue ?? 0.0, animated: true) // update progressView Indicator
                
            }
            }
            let end = CFAbsoluteTimeGetCurrent() // end time for starting task
        
        // MARK:- update tasks end time UI labels using Main Thread
            DispatchQueue.main.async {
                switch tag {
                case .Task1 :
             self.TaskF1.text = "Task 1 Finished : Time \(end-start)"
                case .Task2:
             self.TaskF2.text = "Task 2 Finished : Time \(end-start)"
                case .Task3:
             self.TaskF3.text = "Task 3 Finished : Time \(end-start)"

         }
        }

        }

}

// enum indicating the 3 tasks
enum Tasks:String{
    case Task1 = "Task 1"
    case Task2 = "Task 2"
    case Task3 = "Task 3"
}
