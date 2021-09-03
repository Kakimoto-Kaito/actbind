//
//  SignUpBirthdayViewController.swift
//  Actbind
//
//  Created by 柿本　海斗 on 2020/12/17.
//

import AudioToolbox
import UIKit

final class SignUpBirthdayViewController: UIViewController, UIGestureRecognizerDelegate {
    var name1 = ""
    var name2 = ""
    var displayName = ""
    var mailaddress = ""
    var password = ""
    var gender = 0

    @IBOutlet weak var signUpBirthdayTitleLabel: UILabel!
    @IBOutlet weak var birthdayExplanationLabel: UILabel!
    @IBOutlet weak var birthdayTextField: UITextField!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var nextButtonRight: NSLayoutConstraint!
    @IBOutlet weak var nextButtonLeft: NSLayoutConstraint!
    @IBOutlet weak var birthdayPicker: UIDatePicker!
    @IBOutlet weak var haveAccountButton: UIBarButtonItem!

    var misscount = 0
    var birthday = ""
    var birthdayString = ""
    var birthdayOk = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true

        signUpBirthdayTitleLabel.text = "tannjyoubiwosenntaku".localized()

        birthdayExplanationLabel.text = "tannjyoubisetumei".localized()

        ageLabel.text = ""
        
        let textFieldPlaceholder = birthdayPicker.date.dateToStringTemplate(format: "yyyyMMMMd")
        birthdayTextField.uiTextFieldSetting(placeholder: textFieldPlaceholder)

        nextButton.setTitle("tugihe".localized(), for: .normal)

        let attributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 12.0)]
        haveAccountButton.setTitleTextAttributes(attributes, for: UIControl.State.normal)
        haveAccountButton.title = "akaunntowoomotinokata".localized()

        // 150年前のdateを取得
        let date150 = Date().dateChange(type: .year, value: -150)

        // ピッカー設定
        birthdayPicker.datePickerMode = UIDatePicker.Mode.date
        birthdayPicker.timeZone = TimeZone.current
        birthdayPicker.locale = Locale.current
        birthdayPicker.calendar = Calendar.current
        birthdayPicker.maximumDate = Date()
        birthdayPicker.minimumDate = date150
        if #available(iOS 13.4, *) {
            birthdayPicker.preferredDatePickerStyle = .wheels
        }
    }

    // キーボード以外をタップでキーボードが閉じる
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    @IBAction func birthdayPickerValueChanged(_ sender: Any) {
        birthdayTextField.text = birthdayPicker.date.dateToStringTemplate(format: "yyyyMMMMd")
        // 年齢を算出します
        let age = Calendar.current.dateComponents([.year], from: birthdayPicker.date, to: Date()).year
        let ageString = String(age!)

        if "language".localized() == "Arabic" {
            ageLabel.text = "sai".localized() + ageString
        } else {
            ageLabel.text = ageString + "sai".localized()
        }

        nextButton.isEnabled = true
        nextButton.setTitleColor(UIColor(named: "White"), for: .normal)
        nextButton.backgroundColor = UIColor(named: "Blue")
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
        
        // 選択された誕生日のyyyy-MM-ddを取得
        birthday = birthdayPicker.date.dateToString(format: "yyyy-MM-dd")

        // 選択された誕生日のyyyyMMddを取得
        birthdayString = birthdayPicker.date.dateToString(format: "yyyyMMdd")
        // 13年前のyyyyMMddを取得
        let birthdayTextFieldTextA = Date().dateChange(type: .year, value: -13)
        birthdayOk = birthdayTextFieldTextA.dateToString(format: "yyyyMMdd")
        
        if Int(birthdayString)! <= Int(birthdayOk)! {
            let storyBoard = UIStoryboard(name: "SignUpUserName", bundle: nil)
            let nextVC = storyBoard.instantiateInitialViewController()
            let vc = (nextVC as? SignUpUserNameViewController)
            
            // 値の設定
            vc!.name1 = name1
            vc!.name2 = name2
            vc!.displayName = displayName
            vc!.mailaddress = mailaddress
            vc!.password = password
            vc!.gender = gender
            vc!.birthday = birthday
            
            navigationController?.pushViewController(nextVC!, animated: true)
        } else if misscount == 0 || misscount == 1 {
            misscount += 1

            let alertTitle = "jissainotannjyoubi".localized()
            let okTitle = "OK".localized()

            let alertController = UIAlertController(title: alertTitle, message: nil, preferredStyle: .alert)

            let okButton = UIAlertAction(title: okTitle, style: UIAlertAction.Style.cancel, handler: nil)

            alertController.view.tintColor = UIColor(named: "BlackWhite")
            alertController.addAction(okButton)

            present(alertController, animated: true, completion: nil)

            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.error)
        } else {
            let alertTitle = "akaunntowosakuseidekimasenndesita".localized()
            let okTitle = "OK".localized()

            let alertController = UIAlertController(title: alertTitle, message: nil, preferredStyle: .alert)

            let okButton = UIAlertAction(title: okTitle, style: .cancel, handler: { _ in
                self.dismiss(animated: true, completion: nil)
            })

            alertController.view.tintColor = UIColor(named: "BlackWhite")
            alertController.addAction(okButton)

            present(alertController, animated: true, completion: nil)

            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.error)
        }
    }

    @IBAction func haveAccountButton(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        dismiss(animated: true, completion: nil)
    }
}
