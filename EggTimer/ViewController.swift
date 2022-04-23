//
//  ViewController.swift
//  EggTimer
//
//  Created by Muhammad Ziddan Hidayatullah on 23/04/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    //    let eggTime : [String : Int] = [
    //        "Soft": 300,
    //        "Medium": 480,
    //        "Hard": 720
    //    ]
    
    let eggTime : [String : Int] = [
        "Soft": 5,
        "Medium": 8,
        "Hard": 12
    ]
    
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        timer.invalidate()
        
        guard let title = sender.titleLabel?.text else { return }
        print(title)
        
        guard var result = eggTime[title] else {return}
        print(result)
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (Timer) in
            if result > 0 {
                print ("\(result) seconds")
                result -= 1
            } else {
                Timer.invalidate()
                self.titleLabel.text = "Done!!!"
            }
        }
        
        //        if (title == "Soft") {
        //            print(softTime)
        //        } else if (title == "Medium") {
        //            print(mediumTime)
        //        } else if (title == "Hard") {
        //            print(hardTime)
        //        } else {
        //            print("Not Defined")
        //        }
        
        //        switch title {
        //        case "Soft": print(softTime)
        //        case "Medium": print(mediumTime)
        //        case "Hard": print(hardTime)
        //        default: print("Error")
        //        }
    }
}
