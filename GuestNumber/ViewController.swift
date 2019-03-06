//
//  ViewController.swift
//  GuestNumber
//
//  Created by ShaoJen Chen on 2018/10/31.
//  Copyright © 2018 ShaoJenChen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var numbers = ["0","1","2","3","4","5","6","7","8","9"]
    
    var guessCount = 0
    
    @IBOutlet var inputNumberField: UITextField!
    
    @IBOutlet var answerTextLabel: UILabel!
    
    @IBOutlet var answerLabel: UILabel!
    
    @IBOutlet var guessResultLabel: UILabel!
    
    @IBOutlet var guessRecordTextView: UITextView!
    
    @IBOutlet weak var confirmBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.createRandomNumber()
        
    }

    @IBAction func cheatAction(_ sender: UIButton) {
        
        self.answerTextLabel.isHidden = false
        
        self.answerLabel.isHidden = false
        
    }
    
    @IBAction func cheatActionEnd(_ sender: UIButton) {
        
        self.answerTextLabel.isHidden = true
        
        self.answerLabel.isHidden = true
        
    }
    
    @IBAction func guessConfirm(_ sender: UIButton) {
        
        var a = 0
        
        var b = 0
        
        guard let guessNumberTexts = self.inputNumberField.text, guessNumberTexts != "" else { return }
        
        var guessNumberArray = [String]()
        
        for char in guessNumberTexts {
            
            guessNumberArray.append(String(char))
            
        }
        
        if Set(guessNumberArray).count != 4 {
            
            let alert = UIAlertController(title: "輸入錯誤", message: "請輸入不重複的4個數字!", preferredStyle: .alert)
            
            let action_ok = UIAlertAction(title: "OK", style: .cancel) { (action) in
                
                self.inputNumberField.resignFirstResponder()
                
            }
            
            alert.addAction(action_ok)
            
            self.present(alert, animated: true, completion: nil)
            
            return
        }
        
        
        for (index, guessNumber) in guessNumberArray.enumerated() {
            
            if numbers[index] == guessNumber {
                
                a += 1
                
            }
            else if numbers[0...3].contains(guessNumber) {
                
                b += 1
                
            }
            
        }
        
        self.guessCount += 1
        
        self.guessResultLabel.text = "\(a)A\(b)B"
        
        self.guessRecordTextView.text += "第\(self.guessCount)次  \(guessNumberTexts)  \(a)A\(b)B  \n"
        
        self.inputNumberField.resignFirstResponder()
        
        if a == 4 && b == 0 {
            
            self.guessRecordTextView.text += "答對了，答案就是\(guessNumberTexts)!"
            
            self.confirmBtn.isEnabled = false
            
            self.inputNumberField.isEnabled = false
            
        }
        
    }
    
    @IBAction func restartGame(_ sender: UIButton) {
        
        guessCount = 0
        
        self.createRandomNumber()
        
        self.guessRecordTextView.text = ""
        
        self.confirmBtn.isEnabled = true
        
        self.inputNumberField.isEnabled = true
        
        self.guessResultLabel.text = "0A0B"
    }
    
    func createRandomNumber() {
        
        self.answerLabel.text = ""
        
        numbers.shuffle()
        
        for number in numbers[0...3] {
            
            self.answerLabel.text?.append(contentsOf: number)
            
        }
        
    }
    
}

extension ViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let text = textField.text else { return true }
        
        let count = text.count + string.count - range.length
        
        return count <= 4
    }
    
}
