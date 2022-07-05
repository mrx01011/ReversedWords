//
//  ViewController.swift
//  reverseWords
//
//  Created by Vladyslav Nhuien on 21.06.2022.
//

import UIKit

class ViewController: UIViewController {
    //MARK: IBOutlets
    @IBOutlet weak var reserveTF: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var reserveBtn: UIButton!
    @IBOutlet weak var divider: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var navBarHeader: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navBar.titleTextAttributes = [.font : UIFont(name: "Roboto-Bold", size: 17)!]
        
        navBarHeader.layer.backgroundColor = UIColor(red: 0.976, green: 0.976, blue: 0.976, alpha: 0.94).cgColor
        
        reserveBtn.layer.backgroundColor = UIColor(red: 0, green: 0.478, blue: 1, alpha: 0.6).cgColor
        
        titleLabel.textColor = UIColor(red: 0.129, green: 0.129, blue: 0.129, alpha: 1)
        titleLabel.font = UIFont(name: "Roboto-Bold", size: 34)
        
        resultLabel.textColor = UIColor(red: 0, green: 0.478, blue: 1, alpha: 1)
        resultLabel.font = UIFont(name: "Roboto-Regular", size: 24)
        
        subTitleLabel.textColor = UIColor(red: 0.235, green: 0.235, blue: 0.263, alpha: 0.6)
        subTitleLabel.font = UIFont(name: "Roboto-Regular", size: 17)
        
        reserveBtn.layer.cornerRadius = 14
        divider.layer.backgroundColor = UIColor(red: 0.129, green: 0.129, blue: 0.129, alpha: 0.2).cgColor
        
        reserveTF.font = UIFont(name: "Roboto-Regular", size: 17)
        reserveTF.addTarget(self, action: #selector(editingTF), for: .editingDidBegin)
        reserveTF.addTarget(self, action: #selector(endEditingTF), for: .editingDidEnd)
        reserveTF.addTarget(self, action: #selector(startTyping), for: .editingChanged)
    
    }
    
    //MARK: Methods
    
    @objc func editingTF(sender: UITextField) {
        if sender == reserveTF {
            divider.layer.backgroundColor = UIColor(red: 0, green: 0.478, blue: 1, alpha: 1).cgColor
        }
    }
    
    @objc func endEditingTF(sender: UITextField) {
        if sender == reserveTF {
            divider.layer.backgroundColor = UIColor(red: 0.129, green: 0.129, blue: 0.129, alpha: 0.2).cgColor
        }
    }
    @objc func startTyping(sender: UITextField) {
        if sender == reserveTF {
            reserveBtn.layer.backgroundColor = UIColor(red: 0, green: 0.478, blue: 1, alpha: 1).cgColor
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first as? UITouch {
            view.endEditing(true)
        }
    }
    
    func alert(title: String, message: String, style: UIAlertController.Style) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        let action = UIAlertAction(title: "OK", style: .default)  { (action) in
            
        }
        alertController.addAction(action)
        self.present(alertController, animated: true)
    }
    
    //MARK: IBActions
    @IBAction func reserveButton(_ sender: UIButton) {
        guard let textToReserve = reserveTF.text else { return }
        if reserveTF.text!.count > 0 {
        sender.tag = sender.tag + 1
        if sender.tag > 1 {sender.tag = 0}
        switch sender.tag {
        case 1:
            resultLabel.text = textToReserve.split(separator: " ").map { String($0.reversed())}.joined(separator: " ")
            reserveBtn.setTitle("Clear", for: .normal)
        default:
            resultLabel.text = ""
            reserveTF.text = ""
            reserveBtn.setTitle("Reverse", for: .normal)
            reserveBtn.layer.backgroundColor = UIColor(red: 0, green: 0.478, blue: 1, alpha: 0.6).cgColor
        }
     } else {
            self.alert(title: "Warning", message: "Enter text first!", style: .alert)
     }
   }
}

