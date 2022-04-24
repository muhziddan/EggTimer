//
//  ViewController.swift
//  EggTimer
//
//  Created by Muhammad Ziddan Hidayatullah on 23/04/22.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var additionalLabel: UILabel!
    
    let eggTime : [String : Int] = [
        "Soft": 5,
        "Medium": 8,
        "Hard": 12
    ]
    
    var timePassed = 0
    var timer = Timer()
    var player: AVAudioPlayer?
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        timer.invalidate()
        
        additionalLabel.alpha = 0.0
        progressView.progress = 0
        
        guard let title = sender.titleLabel?.text else { return }
        print(title)
        
        guard let result = eggTime[title] else {return}
        print(result)
        
        titleLabel.text = "Cooking your \(title) egg~"
        
        UIView.animate(withDuration: 0.5, delay: 0.2, options: .curveEaseIn, animations: {self.progressView.alpha = 1.0}, completion: nil)
        
        timeProgress(totalTime: result)
    }
    
    func timeProgress(totalTime: Int) {
        
        timePassed = 0
        
        self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (Timer) in
            if self.timePassed < totalTime {
                self.timePassed += 1
                print ("\(self.timePassed) seconds, progress \(Float(self.timePassed) / Float(totalTime))")
                self.progressView.setProgress(Float(self.timePassed) / Float(totalTime), animated: true)
            } else {
                Timer.invalidate()
                self.titleLabel.text = "Done!!!"
                self.playSound()
                UIView.animate(withDuration: 0.3, delay: 0.5, options: .curveEaseOut, animations: {
                    self.progressView.alpha = 0.0
                    self.additionalLabel.alpha = 1.0
                }, completion: nil)
            }
        }
    }
    
    func playSound() {
        
        guard let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            guard let player = player else { return }
            
            player.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
