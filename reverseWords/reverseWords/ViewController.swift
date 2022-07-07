//
//  ViewController.swift
//  reverseWords
//
//  Created by Vladyslav Nhuien on 21.06.2022.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate{
//MARK: IBOutlets
    @IBOutlet weak var reverseTF: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var reverseBtn: UIButton!
    @IBOutlet weak var divider: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var navBarHeader: UIView!
    @IBOutlet weak var scrollingResultLabel: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //textfields tuning
        reverseTF.delegate = self
        reverseTF.returnKeyType = .done
        reverseTF.font = UIFont(name: "Roboto-Regular", size: 17)
        reverseTF.addTarget(self, action: #selector(editingTF), for: .editingDidBegin)
        reverseTF.addTarget(self, action: #selector(endEditingTF), for: .editingDidEnd)
        reverseTF.addTarget(self, action: #selector(startTyping), for: .editingChanged)
        
        //navigation bar tuning
        navBar.titleTextAttributes = [.font : UIFont(name: "Roboto-Bold", size: 17)!]
        
        //navigation bar header tuning
        navBarHeader.layer.backgroundColor = UIColor(red: 0.976, green: 0.976, blue: 0.976, alpha: 0.94).cgColor
        
        //buttons tuning
        reverseBtn.layer.backgroundColor = UIColor(red: 0, green: 0.478, blue: 1, alpha: 0.6).cgColor
        reverseBtn.layer.cornerRadius = 14
        
        //labels tuning
        titleLabel.textColor = UIColor(red: 0.129, green: 0.129, blue: 0.129, alpha: 1)
        titleLabel.font = UIFont(name: "Roboto-Bold", size: 34)
        resultLabel.textColor = UIColor(red: 0, green: 0.478, blue: 1, alpha: 1)
        resultLabel.font = UIFont(name: "Roboto-Regular", size: 24)
        subTitleLabel.textColor = UIColor(red: 0.235, green: 0.235, blue: 0.263, alpha: 0.6)
        subTitleLabel.font = UIFont(name: "Roboto-Regular", size: 17)
        
        //divider tuning
        divider.layer.backgroundColor = UIColor(red: 0.129, green: 0.129, blue: 0.129, alpha: 0.2).cgColor
        
        //move view depending on keyboard
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil);
        
    }
    
//MARK: Methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true) //when click on 'done'kb hides
        return false
    }
    
    @objc func editingTF(sender: UITextField) {
        if sender == reverseTF {
            divider.layer.backgroundColor = UIColor(red: 0, green: 0.478, blue: 1, alpha: 1).cgColor
        }
    }
    
    @objc func endEditingTF(sender: UITextField) {
        if sender == reverseTF {
            divider.layer.backgroundColor = UIColor(red: 0.129, green: 0.129, blue: 0.129, alpha: 0.2).cgColor
        }
    }
    @objc func startTyping(sender: UITextField) {
        if sender == reverseTF {
            reverseBtn.layer.backgroundColor = UIColor(red: 0, green: 0.478, blue: 1, alpha: 1).cgColor
        }
    }
   
    @objc func keyboardWillShow(sender: NSNotification) {
        guard let userInfo = sender.userInfo, let kbSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return } // keyboard size calculation
        self.view.frame.origin.y = -(kbSize.height - 66) //move view upward
    }
    
    @objc func keyboardWillHide(sender: NSNotification) {
        self.view.frame.origin.y = 0 //move view to original position
    }
    
    //alert if textfield is empty
    func alert(title: String, message: String, style: UIAlertController.Style) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        let action = UIAlertAction(title: "OK", style: .default)  { (action) in
            
        }
        alertController.addAction(action)
        self.present(alertController, animated: true)
    }
    
//MARK: IBActions
    //action that reverse
    @IBAction func reverseButton(_ sender: UIButton) {
        guard let textToReverse = reverseTF.text else { return }
        if reverseTF.text!.count > 0 {
            sender.tag = sender.tag + 1
            if sender.tag > 1 {sender.tag = 0}
            switch sender.tag {
            case 1:
                resultLabel.text = textToReverse.split(separator: " ").map { String($0.reversed())}.joined(separator: " ")
                reverseBtn.setTitle("Clear", for: .normal)
            default:
                resultLabel.text = ""
                reverseTF.text = ""
                reverseBtn.setTitle("Reverse", for: .normal)
                reverseBtn.layer.backgroundColor = UIColor(red: 0, green: 0.478, blue: 1, alpha: 0.6).cgColor
            }
        } else {
            self.alert(title: "Warning", message: "Enter text first!", style: .alert)
        }
    }
    //Hide kb when tapped
    @IBAction func tapTGR(_ sender: Any) {
        reverseTF.resignFirstResponder()
    }
}

