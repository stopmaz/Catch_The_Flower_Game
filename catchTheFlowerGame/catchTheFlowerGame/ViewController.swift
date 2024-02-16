//
//  ViewController.swift
//  catchTheFlowerGame
//
//  Created by melih can durmaz on 16.02.2024.
//

import UIKit

class ViewController: UIViewController {
    //variables
    var score = 0
    var timer = Timer()
    var counter = 0
    var mariArray = [UIImageView]()
    var hideTimer = Timer()
    var highScore = 0
    
    //views
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    
    @IBOutlet weak var mariImage1: UIImageView!
    @IBOutlet weak var mariImage2: UIImageView!
    @IBOutlet weak var mariImage3: UIImageView!
    @IBOutlet weak var mariImage4: UIImageView!
    @IBOutlet weak var mariImage5: UIImageView!
    @IBOutlet weak var mariImage6: UIImageView!
    @IBOutlet weak var mariImage7: UIImageView!
    @IBOutlet weak var mariImage8: UIImageView!
    @IBOutlet weak var mariImage9: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoreLabel.text = "Score: \(score)"
        //highscore_check
        let storedHighscore = UserDefaults.standard.object(forKey: "highscore")
        
        if storedHighscore == nil {
            highScore = 0
            highScoreLabel.text = "Highscore: \(highScore)"
        }
        if let newscore = storedHighscore as? Int {
            highScore = newscore
            highScoreLabel.text = "Highscore: \(highScore)"
        }
        
        //images
        mariImage1.isUserInteractionEnabled = true
        mariImage2.isUserInteractionEnabled = true
        mariImage3.isUserInteractionEnabled = true
        mariImage4.isUserInteractionEnabled = true
        mariImage5.isUserInteractionEnabled = true
        mariImage6.isUserInteractionEnabled = true
        mariImage7.isUserInteractionEnabled = true
        mariImage8.isUserInteractionEnabled = true
        mariImage9.isUserInteractionEnabled = true
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        mariImage1.addGestureRecognizer(recognizer1)
        mariImage2.addGestureRecognizer(recognizer2)
        mariImage3.addGestureRecognizer(recognizer3)
        mariImage4.addGestureRecognizer(recognizer4)
        mariImage5.addGestureRecognizer(recognizer5)
        mariImage6.addGestureRecognizer(recognizer6)
        mariImage7.addGestureRecognizer(recognizer7)
        mariImage8.addGestureRecognizer(recognizer8)
        mariImage9.addGestureRecognizer(recognizer9)
        
        mariArray = [mariImage1, mariImage2, mariImage3, mariImage4, mariImage5, mariImage6, mariImage7, mariImage8, mariImage9]
        
        //Timer
        counter = 30
        timeLabel.text = String(counter)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        
        hideTimer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(hideMari), userInfo: nil, repeats: true)
        
        
        hideMari()
        
    }
    
    //hideObject
    @objc func hideMari(){
        
        for mari in mariArray {
            mari.isHidden = true
        }
        let random = Int(arc4random_uniform(UInt32(mariArray.count - 1)))
        mariArray[random].isHidden = false
        
    }
    
    @objc func increaseScore(){
        
        score += 1
        scoreLabel.text = "Score: \(score)"
        
    }
    
    @objc func countDown(){
        
        counter -= 1
        timeLabel.text = String(counter)
        
        if counter == 0 {
            timer.invalidate()
            hideTimer.invalidate()
            
            for mari in mariArray {
                mari.isHidden = true
            }
            //HighScore
            if self.score > self.highScore{
                self.highScore = self.score
                highScoreLabel.text = "Highscore: \(self.highScore)"
                UserDefaults.standard.set(self.highScore, forKey: "highscore")
            }
            
            
            //Alert
            
            let alert = UIAlertController(title: "Times Up !", message: "Play again ?", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { (UIAlertAction) in
                
                //Replay function
                self.score = 0
                self.scoreLabel.text = "Score: \(self.score)"
                self.counter = 30
                self.timeLabel.text = String(self.counter)
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(self.hideMari), userInfo: nil, repeats: true)
                
            }
            
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true, completion: nil)
            
        }
        
    }
    
    
    

}

