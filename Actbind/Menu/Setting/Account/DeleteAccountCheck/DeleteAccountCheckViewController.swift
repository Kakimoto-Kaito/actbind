//
//  DeleteYourAccountCheckViewController.swift
//  Actbind
//
//  Created by 柿本　海斗 on 2020/12/05.
//

import AudioToolbox
import UIKit

final class DeleteAccountCheckViewController: UIViewController, UIGestureRecognizerDelegate {
    let userDefaults = UserDefaults(suiteName: "group.com.actbind")
    
    @IBOutlet weak var navigationBarTitle: UINavigationItem!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var dereteTitleLabel: UILabel!
    @IBOutlet weak var dereteLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var errorViewBottom: NSLayoutConstraint!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var nextButtonRight: NSLayoutConstraint!
    @IBOutlet weak var nextButtonLeft: NSLayoutConstraint!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var cancelButtonRight: NSLayoutConstraint!
    @IBOutlet weak var cancelButtonLeft: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
        navigationBarTitle.title = "akaunntokannri".localized()
        
        dereteTitleLabel.text = "akaunntosakujyo".localized()
        dereteLabel.text = "akaunntosakujyosetumei".localized()

        if let userDefaults = userDefaults {
            let myColor = userDefaults.string(forKey: "mycolor")

            if myColor == "Original" {
                backButton.tintColor = UIColor(named: "BlackWhite")
                cancelButton.setTitleColor(UIColor(named: "Blue"), for: .normal)
                passwordTextField.tintColor = UIColor(named: "Blue")
            } else {
                backButton.tintColor = UIColor(named: myColor!)
                cancelButton.setTitleColor(UIColor(named: myColor!), for: .normal)
                passwordTextField.tintColor = UIColor(named: myColor!)
            }
        }
        
        backButton.image = UIImage(named: "back")
        
        passwordLabel.text = "sakujyopasuwa-do".localized()
        
        passwordTextField.uiTextFieldSetting(placeholder: "pasuwa-do".localized())
        
        errorLabel.text = ""
        errorViewBottom.constant = -60
        
        nextButton.setTitle("tugihe".localized(), for: .normal)
        
        cancelButton.setTitle("kyannseru".localized(), for: .normal)
    }
    
    // 画面に表示される直前に呼ばれます。
    // viewDidLoadとは異なり毎回呼び出されます。
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if toHomeView == "on" {
            let UINavigationController = tabBarController?.viewControllers?[0]
            tabBarController?.selectedViewController = UINavigationController
        }
    }
    
    // キーボード以外をタップでキーボードが閉じる
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    // 完了キーをタップでキーボードが閉じる
    @IBAction func passwordDidEndOnExit(_ sender: Any) {}
    
    @IBAction func passwordTextFieldEditingChanged(_ sender: Any) {
        // passwordTextFieldに入力された文字数を取得
        let passwordCount = passwordTextField.text!.count
        
        // パスワードが8文字以上の時
        if passwordCount >= 8 {
            nextButton.isEnabled = true
            nextButton.setTitleColor(UIColor(named: "White"), for: .normal)
            if let userDefaults = userDefaults {
                let myColor = userDefaults.string(forKey: "mycolor")
                if myColor == "Original" {
                    nextButton.backgroundColor = UIColor(named: "Blue")
                } else {
                    nextButton.backgroundColor = UIColor(named: myColor!)
                }
            }
            // パスワードが8文字未満の時
        } else {
            nextButton.isEnabled = false
            nextButton.setTitleColor(UIColor(named: "EnabledButtonText"), for: .normal)
            nextButton.backgroundColor = UIColor(named: "EnabledButton")
        }
    }

    @IBAction func passwordTextFieldEditingDidBegin(_ sender: Any) {
        if let userDefaults = userDefaults {
            let myColor = userDefaults.string(forKey: "mycolor")
            
            if myColor == "Original" || myColor == "Blue" {
                passwordTextField.layer.borderColor = UIColor.systemBlue.cgColor
            } else if myColor == "Red" {
                passwordTextField.layer.borderColor = UIColor.systemRed.cgColor
            } else if myColor == "Orange" {
                passwordTextField.layer.borderColor = UIColor.systemOrange.cgColor
            } else if myColor == "Yellow" {
                passwordTextField.layer.borderColor = UIColor.systemYellow.cgColor
            } else if myColor == "Green" {
                passwordTextField.layer.borderColor = UIColor.systemGreen.cgColor
            } else {
                passwordTextField.layer.borderColor = UIColor.systemPurple.cgColor
            }
        }
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
        
        passwordTextField.endEditing(true)

        let passwordTextFieldNotwhitespaces = passwordTextField.text!.stringCharacterSetRemove(characterSet: .whitespaces)

        if let userDefaults = userDefaults {
            let password = userDefaults.string(forKey: "password")

            // パスワードが正しい時
            let afterPassword = passwordTextFieldNotwhitespaces.stringReplacement()
            
            if password == afterPassword {
                let storyBoard = UIStoryboard(name: "DeleteAccount", bundle: nil)
                let nextVC = storyBoard.instantiateInitialViewController()
                
                navigationController?.pushViewController(nextVC!, animated: true)
                // パスワードが正しくない時
            } else {
                errorLabel.text = "pasuwa-doera-".localized()
                errorView.errorViewTransition(value: 182)
                let generator = UINotificationFeedbackGenerator()
                generator.notificationOccurred(.error)
            }
        }
    }

    @IBAction func cancelButtonTouchDown(_ sender: Any) {
        cancelButtonRight.constant = 25
        cancelButtonLeft.constant = 25

        if let userDefaults = userDefaults {
            let myColor = userDefaults.string(forKey: "mycolor")

            if myColor == "Original" {
                cancelButton.setTitleColor(UIColor(named: "BlueHalf"), for: .normal)
            } else {
                cancelButton.setTitleColor(UIColor(named: myColor! + "Half"), for: .normal)
            }
        }
    }

    @IBAction func cancelButtonTouchDragOutside(_ sender: Any) {
        cancelButtonRight.constant = 20
        cancelButtonLeft.constant = 20

        if let userDefaults = userDefaults {
            let myColor = userDefaults.string(forKey: "mycolor")

            if myColor == "Original" {
                cancelButton.setTitleColor(UIColor(named: "Blue"), for: .normal)
            } else {
                cancelButton.setTitleColor(UIColor(named: myColor!), for: .normal)
            }
        }
    }

    @IBAction func cancelButtonTouchUpInside(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        cancelButtonRight.constant = 20
        cancelButtonLeft.constant = 20

        if let userDefaults = userDefaults {
            let myColor = userDefaults.string(forKey: "mycolor")

            if myColor == "Original" {
                cancelButton.setTitleColor(UIColor(named: "Blue"), for: .normal)
            } else {
                cancelButton.setTitleColor(UIColor(named: myColor!), for: .normal)
            }
        }

        navigationController?.popViewController(animated: true)
    }

    @IBAction func backBottonAction(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        navigationController?.popViewController(animated: true)
    }
}
