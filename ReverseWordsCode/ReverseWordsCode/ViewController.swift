//
//  ViewController.swift
//  ReverseWordsCode
//
//  Created by Vladyslav Nhuien on 09.07.2022.
//
import SnapKit
import UIKit

class ViewController: UIViewController {
    // MARK: UIElements
    private let topSafeAreaView: UIView = {
        let view = UIView()
        view.layer.backgroundColor = Constants.Header.color
        return view
    }()
    private let headerView: UIView = {
        let view = UIView()
        view.layer.backgroundColor = Constants.Header.color
        return view
    }()
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.HeaderLabel.text
        label.textColor = Constants.HeaderLabel.textColor
        label.font = Constants.HeaderLabel.font
        return label
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.Title.text
        label.font = Constants.Title.font
        label.textColor = Constants.Title.textColor
        label.textAlignment = .center
        return label
    }()
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.Subtitle.text
        label.font = Constants.Subtitle.font
        label.textColor = Constants.Subtitle.textColor
        label.textAlignment = .center
        label.numberOfLines = Constants.Subtitle.numberOfLines
        return label
    }()
    private let reverseTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = Constants.ReverseTextField.placeholder
        textField.font = Constants.ReverseTextField.font
        textField.returnKeyType = .done
        return textField
    }()
    private let dividerView: UIView = {
        let view = UIView()
        view.layer.backgroundColor = Constants.Divider.inactiveColor
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
        textView.font = Constants.Result.font
        textView.textColor = Constants.Result.textColor
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
    
    // MARK: NSElements
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
        topSafeAreaView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(Constants.OffSet.side)
            make.top.equalToSuperview().inset(Constants.OffSet.Header.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.top)
          }
        // Header View
        view.addSubview(headerView)
        headerView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(Constants.OffSet.Header.side)
            make.top.equalTo(topSafeAreaView.snp.bottom).offset(Constants.OffSet.Header.top)
            make.height.equalTo(Constants.OffSet.Header.height)
          }
        // Header Label
        headerView.addSubview(headerLabel)
        headerLabel.snp.makeConstraints { make in
            make.centerX.equalTo(headerView.snp.centerX)
            make.bottom.equalTo(headerView.snp.bottom).offset(-Constants.OffSet.Header.labelBottom)
          }
        // Title Label
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(Constants.OffSet.side)
            make.top.equalTo(headerView.snp.bottom).offset(Constants.OffSet.Title.top)
          }
        // Subtitle Label
        view.addSubview(subtitleLabel)
        subtitleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(Constants.OffSet.Subtitle.side)
            make.top.equalTo(titleLabel.snp.bottom).offset(Constants.OffSet.Subtitle.top)
        }
        // Reverse Text Field
        view.addSubview(reverseTextField)
        reverseTextField.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(Constants.OffSet.side)
            make.top.equalTo(subtitleLabel.snp.bottom).offset(Constants.OffSet.ReverseTextField.top)
        }
        // Divider View
        view.addSubview(dividerView)
        dividerView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(Constants.OffSet.side)
            make.top.equalTo(reverseTextField.snp.bottom).offset(Constants.OffSet.Divider.top)
            make.height.equalTo(Constants.OffSet.Divider.height)
        }
        // Text View
        scrollView.addSubview(resultTextView)
        resultTextView.snp.makeConstraints { make in
            make.height.equalTo(scrollView.snp.height)
            make.width.equalTo(scrollView.snp.width)
        }
        // Scroll View
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(Constants.OffSet.side)
            make.top.equalTo(dividerView.snp.bottom).offset(Constants.OffSet.Scroll.top)
        }
        // Reverse Button
        view.addSubview(reverseButton)
        reverseButton.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(Constants.OffSet.Button.side)
            make.top.equalTo(scrollView.snp.bottom).offset(Constants.OffSet.Button.top)
            make.bottom.equalToSuperview().offset(-Constants.OffSet.Button.bottom)
            make.height.equalTo(Constants.OffSet.Button.height)
        }
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
    
    @objc private func reverseWords(sender: UIButton) {
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
    
    @objc private func keyboardWillShow(sender: NSNotification) {
        guard let userInfo = sender.userInfo, let kbSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        reverseButton.snp.updateConstraints { make in
            make.bottom.equalToSuperview().offset(-(kbSize.height + 10))
        }
    }
    
    @objc private func keyboardWillHide(sender: NSNotification) {
        reverseButton.snp.updateConstraints { make in
            make.bottom.equalToSuperview().offset(-Constants.OffSet.Button.bottom)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
    // MARK: Text Field Delegate
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        dividerView.layer.backgroundColor = Constants.Divider.activeColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        dividerView.layer.backgroundColor = Constants.Divider.inactiveColor
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
        enum Header {
            static let color = UIColor(red: 0.976, green: 0.976, blue: 0.976, alpha: 0.94).cgColor
        }
        enum HeaderLabel {
            static let text = "Reverse Words"
            static let font = UIFont(name: "Roboto-Bold", size: 17) ?? UIFont.systemFont(ofSize: 17)
            static let textColor = UIColor(red: 0.129, green: 0.129, blue: 0.129, alpha: 1)
        }
        enum Title {
            static let text = "Reverse Words"
            static let font = UIFont(name: "Roboto-Bold", size: 34) ?? UIFont.systemFont(ofSize: 34)
            static let textColor = UIColor(red: 0.129, green: 0.129, blue: 0.129, alpha: 1)
        }
        enum Subtitle {
            static let text = "This application will reverse your words. Please type text below"
            static let font = UIFont(name: "Roboto-Regular", size: 17) ?? UIFont.systemFont(ofSize: 17)
            static let textColor = UIColor(red: 0.235, green: 0.235, blue: 0.263, alpha: 0.6)
            static let numberOfLines = 0
        }
        enum ReverseTextField {
            static let placeholder = "Text to reverse"
            static let font = UIFont(name: "Roboto-Regular", size: 17) ?? UIFont.systemFont(ofSize: 17)
        }
        enum Divider {
            static let inactiveColor = UIColor(red: 0.129, green: 0.129, blue: 0.129, alpha: 0.2).cgColor
            static let activeColor = UIColor(red: 0, green: 0.478, blue: 1, alpha: 1).cgColor
        }
        enum Result {
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
                static let height: CGFloat = 1
            }
            enum Scroll {
                static let top: CGFloat = 24
            }
            enum Button {
                static let side: CGFloat = 13
                static let top: CGFloat = 45
                static let bottom: CGFloat = {
                    let window = UIApplication.shared.windows.first
                    let bottomPadding = window?.safeAreaInsets.bottom ?? 0
                    return bottomPadding + 22
                }()
                static let height: CGFloat = 60
            }
        }
    }
}
