//
//  QuizVC.swift
//  QuizApp
//
//  Created by user on 1/1/21.
//

import UIKit

class QuizVC: UIViewController {
    
    
    @IBOutlet weak var lbQuestion: UILabel!
    
    @IBOutlet weak var lbTimer: UILabel!
    
    @IBOutlet var btChoices: [UIButton]!
    
    
    
    var level: String?
    var x: Int!, y: Int!
    var choices: [Int] = []
//    var choices = [Int]()
//    var choices = Array<Int>()
    var count = 1
    var correct = 0
    var timer: Timer!
    var seconds: Int!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        print(level)
        // Do any additional setup after loading the view.
        generateQuestion()
        generteChoices()
        initTimer()
    }
    
    func initTimer() {
        if level == "Easy" {
            seconds = 30
        }
        else if level == "Normal" {
            seconds = 15
        }
        else {
            seconds = 5
        }
        
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { timer in
            
            if self.seconds == 0 {
                self.checkChoice(nil)
            }
            self.lbTimer.text = "\(self.seconds!)"
            self.seconds -= 1
        })
    }
    
    
    func generateQuestion() {
        x = Int.random(in: 0...10)
        y = Int.random(in: 0...10)
        lbQuestion.text = "What's \(x!) * \(y!) ?"
    }
    
    func generteChoices() {
        
        choices = []
        
        choices.append(x * y)
        for _ in 0...2 {
            let n = Int.random(in: 0...100)
            choices.append(n)
        }
        choices.shuffle()
        
        for i in 0...3 {
            
            let font = UIFont(name: "Noteworthy", size: 64)
            let label = NSAttributedString(string: "\(choices[i])", attributes: [NSAttributedString.Key.font : font])
            
            btChoices[i].setAttributedTitle(label, for: .normal)
        }
        
    }
    
    
    @IBAction func handleUserChoice(_ sender: UIButton) {
        
        let idx = btChoices.firstIndex(of: sender)
        checkChoice(idx)
    }
    
    
    
    
    func checkChoice(_ idx: Int?) {
        
        if let idx = idx {
            let userAnswer = choices[idx]
            if userAnswer == x*y {
                correct += 1
            }
        }
        
        count += 1
        if count <= 5 {
            generateQuestion()
            generteChoices()
            initTimer()
        }
        else {
            let resultDialog = UIAlertController(title: "Score", message: "You score \(correct) out of 5", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "Ok", style: .default) { _ in
                
                self.dismiss(animated: true, completion: nil)
                self.navigationController?.popViewController(animated: true)
                
            }
            
            resultDialog.addAction(okAction)
            timer.invalidate()
            self.present(resultDialog, animated: true, completion: nil)
        }
        
    }
  
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
