//
//  ViewController.swift
//  QuizApp
//
//  Created by user on 1/1/21.
//

import UIKit

class ViewController: UIViewController {

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func startQuiz(_ sender: UIButton) {
        
        performSegue(withIdentifier: "toQuiz", sender: sender.titleLabel!.text)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destVC = segue.destination as! QuizVC
        
        destVC.level = sender as! String
        
    }


}

