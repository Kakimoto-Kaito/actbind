//
//  SignUpPasswordViewController.swift
//  Actbind
//
//  Created by 柿本　海斗 on 2020/12/17.
//

import AudioToolbox
import UIKit

final class SignUpPasswordViewController: UIViewController, UIGestureRecognizerDelegate {
    var name1 = ""
    var name2 = ""
    var displayName = ""
    var mailaddress = ""

    @IBOutlet weak var signUpPasswordTitleLabel: UILabel!
    @IBOutlet weak var passwordExplanationLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var nextButtonRight: NSLayoutConstraint!
    @IBOutlet weak var nextButtonLeft: NSLayoutConstraint!
    @IBOutlet weak var haveAccountButton: UIBarButtonItem!
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var errorViewBottom: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true

        signUpPasswordTitleLabel.text = "pasuwa-dowonyuuryoku".localized()

        passwordExplanationLabel.text = "pasuwa-dosetumei".localized()

        passwordTextField.uiTextFieldSetting(placeholder: "pasuwa-do".localized())

        errorViewBottom.constant = -60

        nextButton.setTitle("tugihe".localized(), for: .normal)

        let attributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 12.0)]
        haveAccountButton.setTitleTextAttributes(attributes, for: UIControl.State.normal)
        haveAccountButton.title = "akaunntowoomotinokata".localized()
    }

    // キーボード以外をタップでキーボードが閉じる
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    // 完了キーをタップでキーボードが閉じる
    @IBAction func passwordTextFieldDidEndOnExit(_ sender: Any) {}

    @IBAction func passwordTextFieldEditingChanged(_ sender: Any) {
        // passwordTextFieldに入力された文字数を取得
        let passwordCount = passwordTextField.text!.count

        // パスワードが8文字以上の時
        if passwordCount >= 8 {
            nextButton.isEnabled = true
            nextButton.setTitleColor(UIColor(named: "White"), for: .normal)
            nextButton.backgroundColor = UIColor(named: "Blue")
            // パスワードが8文字未満の時
        } else {
            nextButton.isEnabled = false
            nextButton.setTitleColor(UIColor(named: "EnabledButtonText"), for: .normal)
            nextButton.backgroundColor = UIColor(named: "EnabledButton")
        }
    }

    @IBAction func passwordTextFieldEditingDidBegin(_ sender: Any) {
        passwordTextField.layer.borderColor = UIColor.systemBlue.cgColor
    }

    @IBAction func passwordTextFieldEditingDidEnd(_ sender: Any) {
        passwordTextField.layer.borderColor = UIColor.lightGray.cgColor
    }

    @IBAction func nextButtonTouchDown(_ sender: Any) {
        UIButton().uiButtonTapOn(item: nextButton, itemRight: nextButtonRight, itemLeft: nextButtonLeft)
    }

    @IBAction func nextButtonTouchDragOutside(_ sender: Any) {
        UIButton().uiButtonTapOff(item: nextButton, itemRight: nextButtonRight, itemLeft: nextButtonLeft)
    }

    @IBAction func nextButtonTouchUpInside(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        UIButton().uiButtonTapOff(item: nextButton, itemRight: nextButtonRight, itemLeft: nextButtonLeft)

        view.endEditing(true)

        // パスワードが正しい時
        if PasswordViewController.isValidPassword(passwordTextField.text!) {
            let storyBoard = UIStoryboard(name: "SignUpGender", bundle: nil)
            let nextVC = storyBoard.instantiateInitialViewController()
            let vc = (nextVC as? SignUpGenderViewController)
            
            let passwordTextFieldNotwhitespaces = passwordTextField.text!.stringCharacterSetRemove(characterSet: .whitespaces)
            
            let afterPassword = passwordTextFieldNotwhitespaces.stringReplacement()
            
            // 値の設定
            vc!.name1 = name1
            vc!.name2 = name2
            vc!.displayName = displayName
            vc!.mailaddress = mailaddress
            vc!.password = afterPassword
            
            navigationController?.pushViewController(nextVC!, animated: true)
            // パスワードが正しくない時
        } else {
            passwordTextField.layer.borderColor = UIColor.systemPink.cgColor
            errorLabel.text = "pasuwa-doera-".localized()
            errorView.errorViewTransition(value: 163)
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.error)
        }
    }

    @IBAction func haveAccountButton(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        dismiss(animated: true, completion: nil)
    }
}
