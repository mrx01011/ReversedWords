//
//  ViewController.swift
//  ReverseWordsCode
//
//  Created by Vladyslav Nhuien on 09.07.2022.
//

import UIKit

class ViewController: UIViewController {
    // MARK: UIElements
    private let headerViewCode: UIView = {
        let headerView = UIView()
        headerView.layer.backgroundColor = Constants.HeaderView.color
        return headerView
    }()
    
    private let headerLabelCode: UILabel = {
        let headerLabel = UILabel()
        headerLabel.text = Constants.TitleLabel.text
        headerLabel.textColor = Constants.HeaderLabel.textColor
        if let font = Constants.HeaderLabel.font {
            headerLabel.font = Constants.HeaderLabel.font
        } else {
            headerLabel.font = UIFont.systemFont(ofSize: 17)
        }
        return headerLabel
    }()
    
    private let titleLabelCode: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = Constants.TitleLabel.text
        if let font = Constants.TitleLabel.font {
            titleLabel.font = Constants.TitleLabel.font
        } else {
            titleLabel.font = UIFont.systemFont(ofSize: 34)
        }
        titleLabel.font = Constants.TitleLabel.font
        titleLabel.textColor = Constants.TitleLabel.textColor
        titleLabel.textAlignment = .center
        return titleLabel
    }()
    
    private let subtitleLabelCode: UILabel = {
        let subtitleLabel = UILabel()
        subtitleLabel.text = Constants.SubtitleLabel.text
        if let font = Constants.SubtitleLabel.font {
            subtitleLabel.font = Constants.SubtitleLabel.font
        } else {
            subtitleLabel.font = UIFont.systemFont(ofSize: 17)
        }
        subtitleLabel.textColor = Constants.SubtitleLabel.textColor
        subtitleLabel.textAlignment = .center
        subtitleLabel.numberOfLines = Constants.SubtitleLabel.numberOfLines
        return subtitleLabel
    }()
    
    private let reverseTextFieldCode: UITextField = {
        let reverseTextField = UITextField()
        reverseTextField.placeholder = Constants.reverseTextField.placeholder
        if let font = Constants.SubtitleLabel.font {
            reverseTextField.font = Constants.SubtitleLabel.font
        } else {
            reverseTextField.font = UIFont.systemFont(ofSize: 17)
        }
        reverseTextField.returnKeyType = .done
        return reverseTextField
    }()
    
    private let dividerViewCode: UIView = {
        let dividerView = UIView()
        dividerView.layer.backgroundColor = Constants.dividerView.color
        return dividerView
    }()
    
    private let scrollViewCode: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isScrollEnabled = true
        return scrollView
    }()
    
    private let resultTextViewCode: UITextView = {
        let resultTextView = UITextView()
        resultTextView.isEditable = false
        if let font = Constants.resultTextView.font {
            resultTextView.font = Constants.resultTextView.font
        } else {
            resultTextView.font = UIFont.systemFont(ofSize: 24)
        }
        resultTextView.textColor = Constants.resultTextView.textColor
        return resultTextView
    }()
    
    private let reverseButtonCode: UIButton = {
        let reverseButton = UIButton()
        reverseButton.setTitle(Constants.reverseButton.titleLabelReverse, for: .normal)
        reverseButton.layer.backgroundColor = Constants.reverseButton.backgroundColorWhenTextFieldEmpty
        reverseButton.layer.cornerRadius = Constants.reverseButton.cornerRadius
        reverseButton.isEnabled = false
        return reverseButton
    }()
    private var reverseButtonBottomConstraint: NSLayoutConstraint?
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        reverseTextFieldCode.delegate = self
        view.backgroundColor = .white
        setupUI()
        reverseButtonCode.addTarget(self, action: #selector(reverseWords), for: .touchUpInside)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    // MARK: Methods
    private func setupUI() {
        // Header View
        view.addSubview(headerViewCode)
        headerViewCode.translatesAutoresizingMaskIntoConstraints = false
        headerViewCode.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 0).isActive = true
        headerViewCode.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: 0).isActive = true
        headerViewCode.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        headerViewCode.heightAnchor.constraint(equalToConstant: 88).isActive = true
        // Header Label
        headerViewCode.addSubview(headerLabelCode)
        headerLabelCode.translatesAutoresizingMaskIntoConstraints = false
        headerLabelCode.centerXAnchor.constraint(equalTo: headerViewCode.centerXAnchor).isActive = true
        headerLabelCode.bottomAnchor.constraint(equalTo: headerViewCode.bottomAnchor, constant: -10).isActive = true
        // Title Label
        view.addSubview(titleLabelCode)
        titleLabelCode.translatesAutoresizingMaskIntoConstraints = false
        titleLabelCode.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 16).isActive = true
        titleLabelCode.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -16).isActive = true
        titleLabelCode.topAnchor.constraint(equalTo: headerViewCode.bottomAnchor, constant: 64).isActive = true
        // Subtitle Label
        view.addSubview(subtitleLabelCode)
        subtitleLabelCode.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabelCode.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 33).isActive = true
        subtitleLabelCode.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -34).isActive = true
        subtitleLabelCode.topAnchor.constraint(equalTo: titleLabelCode.bottomAnchor, constant: 16).isActive = true
        // Reverse Text Field
        view.addSubview(reverseTextFieldCode)
        reverseTextFieldCode.translatesAutoresizingMaskIntoConstraints = false
        reverseTextFieldCode.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 16).isActive = true
        reverseTextFieldCode.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -16).isActive = true
        reverseTextFieldCode.topAnchor.constraint(equalTo: subtitleLabelCode.bottomAnchor, constant: 59).isActive = true
        // Divider View
        view.addSubview(dividerViewCode)
        dividerViewCode.translatesAutoresizingMaskIntoConstraints = false
        dividerViewCode.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 16).isActive = true
        dividerViewCode.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -16).isActive = true
        dividerViewCode.topAnchor.constraint(equalTo: reverseTextFieldCode.bottomAnchor, constant: 18).isActive = true
        dividerViewCode.heightAnchor.constraint(equalToConstant: 1).isActive = true
        // Text View
        scrollViewCode.addSubview(resultTextViewCode)
        resultTextViewCode.translatesAutoresizingMaskIntoConstraints = false
        resultTextViewCode.heightAnchor.constraint(equalTo: scrollViewCode.heightAnchor, multiplier: 1).isActive = true
        resultTextViewCode.widthAnchor.constraint(equalTo: scrollViewCode.widthAnchor, multiplier: 1).isActive = true
        // Scroll View
        view.addSubview(scrollViewCode)
        scrollViewCode.translatesAutoresizingMaskIntoConstraints = false
        scrollViewCode.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 16).isActive = true
        scrollViewCode.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -16).isActive = true
        scrollViewCode.topAnchor.constraint(equalTo: dividerViewCode.bottomAnchor, constant: 24.5).isActive = true
        // Reverse Button
        view.addSubview(reverseButtonCode)
        reverseButtonCode.translatesAutoresizingMaskIntoConstraints = false
        reverseButtonCode.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 13).isActive = true
        reverseButtonCode.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -13).isActive = true
        reverseButtonCode.topAnchor.constraint(equalTo: scrollViewCode.bottomAnchor, constant: 45).isActive = true
        reverseButtonBottomConstraint = reverseButtonCode.bottomAnchor.constraint(equalTo: self.view.bottomAnchor,constant: -66)
        reverseButtonBottomConstraint?.isActive = true
        reverseButtonCode.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    @objc func reverseWords(sender: UIButton) {
        guard let textToReverse = reverseTextFieldCode.text else { return }
        let newTag = sender.tag + 1
        if newTag > 1 {
            sender.tag = 0
        } else {
            sender.tag = newTag
        }
        if sender.tag == 1 {
            let result = textToReverse.split(separator: " ").map { String($0.reversed())}.joined(separator: " ")
            resultTextViewCode.text = result
            reverseButtonCode.setTitle(Constants.reverseButton.titleLabelClear, for: .normal)
        } else {
            resultTextViewCode.text = ""
            reverseTextFieldCode.text = ""
            reverseButtonCode.setTitle(Constants.reverseButton.titleLabelReverse, for: .normal)
            reverseButtonCode.layer.backgroundColor = Constants.reverseButton.backgroundColorWhenTextFieldEmpty
            reverseButtonCode.isEnabled = false
        }
    }
    @objc func keyboardWillShow(sender: NSNotification) {
        guard let userInfo = sender.userInfo, let kbSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        reverseButtonBottomConstraint?.constant = -(kbSize.height)
    }
    
    @objc func keyboardWillHide(sender: NSNotification) {
        reverseButtonBottomConstraint?.constant = -66
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
//MARK: Text Field Delegate
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        dividerViewCode.layer.backgroundColor = UIColor(red: 0, green: 0.478, blue: 1, alpha: 1).cgColor
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        dividerViewCode.layer.backgroundColor = Constants.dividerView.color
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        reverseButtonCode.layer.backgroundColor = Constants.reverseButton.backgroundColorWhenTextFieldNotEmpty
        reverseButtonCode.isEnabled = true
        return true
    }
}
// MARK: Constants
extension ViewController {
    private enum Constants {
        enum HeaderView {
            static let color = UIColor(red: 0.976, green: 0.976, blue: 0.976, alpha: 0.94).cgColor
        }
        enum HeaderLabel {
            static let textColor = UIColor(red: 0.129, green: 0.129, blue: 0.129, alpha: 1)
            static let font = UIFont(name: "Roboto-Bold", size: 17)
        }
        enum TitleLabel {
            static let text = "Reverse Words"
            static let font = UIFont(name: "Roboto-Bold", size: 34)
            static let textColor = UIColor(red: 0.129, green: 0.129, blue: 0.129, alpha: 1)
        }
        enum SubtitleLabel {
            static let text = "This application will reverse your words. Please type text below"
            static let font = UIFont(name: "Roboto-Regular", size: 17)
            static let textColor = UIColor(red: 0.235, green: 0.235, blue: 0.263, alpha: 0.6)
            static let numberOfLines = 0
        }
        enum reverseTextField {
            static let placeholder = "Text to reverse"
        }
        enum dividerView {
            static let color = UIColor(red: 0.129, green: 0.129, blue: 0.129, alpha: 0.2).cgColor
        }
        enum resultTextView {
            static let font = UIFont(name: "Roboto-Regular", size: 24)
            static let textColor = UIColor(red: 0, green: 0.478, blue: 1, alpha: 1)
        }
        enum reverseButton {
            static let titleLabelReverse = "Reverse"
            static let titleLabelClear = "Clear"
            static let backgroundColorWhenTextFieldEmpty = UIColor(red: 0, green: 0.478, blue: 1, alpha: 0.6).cgColor
            static let backgroundColorWhenTextFieldNotEmpty = UIColor(red: 0, green: 0.478, blue: 1, alpha: 1).cgColor
            static let cornerRadius: CGFloat = 14
        }
    }
}
