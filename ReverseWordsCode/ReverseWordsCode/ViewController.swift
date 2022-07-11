//
//  ViewController.swift
//  ReverseWordsCode
//
//  Created by Vladyslav Nhuien on 09.07.2022.
//

import UIKit

class ViewController: UIViewController {
    // MARK: UIElements
    private let topSafeAreaView: UIView = {
        let view = UIView()
        view.layer.backgroundColor = Constants.HeaderView.color
        return view
    }()
    
    private let headerView: UIView = {
        let view = UIView()
        view.layer.backgroundColor = Constants.HeaderView.color
        return view
    }()
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.TitleLabel.text
        label.textColor = Constants.HeaderLabel.textColor
        label.font = Constants.HeaderLabel.font
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.TitleLabel.text
        label.font = Constants.TitleLabel.font
        label.font = Constants.TitleLabel.font
        label.textColor = Constants.TitleLabel.textColor
        label.textAlignment = .center
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.SubtitleLabel.text
        label.font = Constants.SubtitleLabel.font
        label.textColor = Constants.SubtitleLabel.textColor
        label.textAlignment = .center
        label.numberOfLines = Constants.SubtitleLabel.numberOfLines
        return label
    }()
    
    private let reverseTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = Constants.ReverseTextField.placeholder
        textField.font = Constants.SubtitleLabel.font
        textField.returnKeyType = .done
        return textField
    }()
    
    private let dividerView: UIView = {
        let view = UIView()
        view.layer.backgroundColor = Constants.DividerView.color
        return view
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isScrollEnabled = true
        return scrollView
    }()
    
    private let resultTextView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.font = Constants.ResultTextView.font
        textView.textColor = Constants.ResultTextView.textColor
        return textView
    }()
    
    private let reverseButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.ReverseButton.titleLabelReverse, for: .normal)
        button.layer.backgroundColor = Constants.ReverseButton.inactiveBackgroundColor
        button.layer.cornerRadius = Constants.ReverseButton.cornerRadius
        button.isEnabled = false
        return button
    }()
    
    private var reverseButtonBottomConstraint: NSLayoutConstraint?
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        defaultConfiguration()
        observeKeyboardNotificaton()
    }
    // MARK: Methods
    private func setupUI() {
        // Top Safe Area
        view.addSubview(topSafeAreaView)
        topSafeAreaView.translatesAutoresizingMaskIntoConstraints = false
        topSafeAreaView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: Constants.OffSet.Header.side).isActive = true
        topSafeAreaView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: Constants.OffSet.Header.side).isActive = true
        topSafeAreaView.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.OffSet.Header.top).isActive = true
        topSafeAreaView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        // Header View
        view.addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: Constants.OffSet.Header.side).isActive = true
        headerView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: Constants.OffSet.Header.side).isActive = true
        headerView.topAnchor.constraint(equalTo: topSafeAreaView.bottomAnchor, constant: Constants.OffSet.Header.top).isActive = true
        headerView.heightAnchor.constraint(equalToConstant: Constants.OffSet.Header.height).isActive = true
        // Header Label
        headerView.addSubview(headerLabel)
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor).isActive = true
        headerLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -Constants.OffSet.Header.labelBottom).isActive = true
        // Title Label
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: Constants.OffSet.side).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -Constants.OffSet.side).isActive = true
        titleLabel.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: Constants.OffSet.Title.top).isActive = true
        // Subtitle Label
        view.addSubview(subtitleLabel)
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: Constants.OffSet.Subtitle.side).isActive = true
        subtitleLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -Constants.OffSet.Subtitle.side).isActive = true
        subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.OffSet.Subtitle.top).isActive = true
        // Reverse Text Field
        view.addSubview(reverseTextField)
        reverseTextField.translatesAutoresizingMaskIntoConstraints = false
        reverseTextField.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: Constants.OffSet.side).isActive = true
        reverseTextField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -Constants.OffSet.side).isActive = true
        reverseTextField.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: Constants.OffSet.ReverseTextField.top).isActive = true
        // Divider View
        view.addSubview(dividerView)
        dividerView.translatesAutoresizingMaskIntoConstraints = false
        dividerView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: Constants.OffSet.side).isActive = true
        dividerView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -Constants.OffSet.side).isActive = true
        dividerView.topAnchor.constraint(equalTo: reverseTextField.bottomAnchor, constant: Constants.OffSet.Divider.top).isActive = true
        // Text View
        scrollView.addSubview(resultTextView)
        resultTextView.translatesAutoresizingMaskIntoConstraints = false
        resultTextView.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: Constants.OffSet.ResultText.multiplier).isActive = true
        resultTextView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: Constants.OffSet.ResultText.multiplier).isActive = true
        // Scroll View
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: Constants.OffSet.side).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -Constants.OffSet.side).isActive = true
        scrollView.topAnchor.constraint(equalTo: dividerView.bottomAnchor, constant: Constants.OffSet.Scroll.top).isActive = true
        // Reverse Button
        view.addSubview(reverseButton)
        reverseButton.translatesAutoresizingMaskIntoConstraints = false
        reverseButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: Constants.OffSet.Button.side).isActive = true
        reverseButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -Constants.OffSet.Button.side).isActive = true
        reverseButton.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: Constants.OffSet.Button.top).isActive = true
        reverseButtonBottomConstraint = reverseButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor,constant: -Constants.OffSet.Button.bottom)
        reverseButtonBottomConstraint?.isActive = true
        reverseButton.heightAnchor.constraint(equalToConstant: Constants.OffSet.Button.height).isActive = true
    }
    
    @objc func reverseWords(sender: UIButton) {
        guard let textToReverse = reverseTextField.text else { return }
        let newTag = sender.tag + 1
        if newTag > 1 {
            sender.tag = 0
        } else {
            sender.tag = newTag
        }
        if sender.tag == 1 {
            let result = textToReverse.split(separator: " ").map { String($0.reversed())}.joined(separator: " ")
            resultTextView.text = result
            reverseButton.setTitle(Constants.ReverseButton.titleLabelClear, for: .normal)
        } else {
            resultTextView.text = ""
            reverseTextField.text = ""
            reverseButton.setTitle(Constants.ReverseButton.titleLabelReverse, for: .normal)
            reverseButton.layer.backgroundColor = Constants.ReverseButton.inactiveBackgroundColor
            reverseButton.isEnabled = false
        }
    }
    
    @objc func keyboardWillShow(sender: NSNotification) {
        guard let userInfo = sender.userInfo, let kbSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        reverseButtonBottomConstraint?.constant = -(kbSize.height + 10)
    }
    
    @objc func keyboardWillHide(sender: NSNotification) {
        reverseButtonBottomConstraint?.constant = -66
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    private func defaultConfiguration() {
        reverseTextField.delegate = self
        view.backgroundColor = .white
        reverseButton.addTarget(self, action: #selector(reverseWords), for: .touchUpInside)
    }
    
    private func observeKeyboardNotificaton() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}
//MARK: Text Field Delegate
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        dividerView.layer.backgroundColor = UIColor(red: 0, green: 0.478, blue: 1, alpha: 1).cgColor
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        dividerView.layer.backgroundColor = Constants.DividerView.color
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newText = ((textField.text ?? "") as NSString).replacingCharacters(in: range, with: string)
        if newText.isEmpty {
            reverseButton.layer.backgroundColor = Constants.ReverseButton.inactiveBackgroundColor
            reverseButton.isEnabled = false
        } else {
            reverseButton.layer.backgroundColor = Constants.ReverseButton.activeBackgroundColor
            reverseButton.isEnabled = true
        }
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
            static let font = UIFont(name: "Roboto-Bold", size: 17) ?? UIFont.systemFont(ofSize: 17)
        }
        enum TitleLabel {
            static let text = "Reverse Words"
            static let font = UIFont(name: "Roboto-Bold", size: 34) ?? UIFont.systemFont(ofSize: 34)
            static let textColor = UIColor(red: 0.129, green: 0.129, blue: 0.129, alpha: 1)
        }
        enum SubtitleLabel {
            static let text = "This application will reverse your words. Please type text below"
            static let font = UIFont(name: "Roboto-Regular", size: 17) ?? UIFont.systemFont(ofSize: 17)
            static let textColor = UIColor(red: 0.235, green: 0.235, blue: 0.263, alpha: 0.6)
            static let numberOfLines = 0
        }
        enum ReverseTextField {
            static let placeholder = "Text to reverse"
        }
        enum DividerView {
            static let color = UIColor(red: 0.129, green: 0.129, blue: 0.129, alpha: 0.2).cgColor
        }
        enum ResultTextView {
            static let font = UIFont(name: "Roboto-Regular", size: 24) ?? UIFont.systemFont(ofSize: 24)
            static let textColor = UIColor(red: 0, green: 0.478, blue: 1, alpha: 1)
        }
        enum ReverseButton {
            static let titleLabelReverse = "Reverse"
            static let titleLabelClear = "Clear"
            static let inactiveBackgroundColor = UIColor(red: 0, green: 0.478, blue: 1, alpha: 0.6).cgColor
            static let activeBackgroundColor = UIColor(red: 0, green: 0.478, blue: 1, alpha: 1).cgColor
            static let cornerRadius: CGFloat = 14
        }
        enum OffSet {
            static let side: CGFloat = 16
            enum Header {
                static let side: CGFloat = 0
                static let top: CGFloat = 0
                static let height: CGFloat = 38
                static let labelBottom: CGFloat = 10
            }
            enum Title {
                static let top: CGFloat = 64
            }
            enum Subtitle {
                static let side: CGFloat = 33
                static let top: CGFloat = 16
            }
            enum ReverseTextField {
                static let top: CGFloat = 69
            }
            enum Divider {
                static let top: CGFloat = 18
            }
            enum ResultText {
                static let multiplier: CGFloat = 1
            }
            enum Scroll {
                static let top: CGFloat = 24.5
            }
            enum Button {
                static let side: CGFloat = 13
                static let top: CGFloat = 45
                static let bottom: CGFloat = 66
                static let height: CGFloat = 60
            }
        }
    }
}
