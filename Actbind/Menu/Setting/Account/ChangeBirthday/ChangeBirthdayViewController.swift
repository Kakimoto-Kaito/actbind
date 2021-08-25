//
//  ChangeBirthdayViewController.swift
//  Actbind
//
//  Created by 柿本　海斗 on 2020/12/02.
//

import AudioToolbox
import UIKit

final class ChangeBirthdayViewController: UIViewController, UIGestureRecognizerDelegate {
    let userDefaults = UserDefaults(suiteName: "group.com.actbind")
    
    @IBOutlet weak var navigationBarTitle: UINavigationItem!
    @IBOutlet weak var birthdayTextField: UITextField!
    @IBOutlet weak var confirmationButton: UIButton!
    @IBOutlet weak var confirmationButtonRight: NSLayoutConstraint!
    @IBOutlet weak var confirmationButtonLeft: NSLayoutConstraint!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var birthdayPicker: UIDatePicker!

    var nowBirthday = ""
    var birthday = ""
    var birthdayString = ""
    var birthdayOk = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true

        navigationBarTitle.title = "tannjyoubi".localized()

        if let userDefaults = userDefaults {
            let myColor = userDefaults.string(forKey: "mycolor")
            let birthday = userDefaults.string(forKey: "birthday")

            if myColor == "Original" {
                backButton.tintColor = UIColor(named: "BlackWhite")
                confirmationButton.backgroundColor = UIColor(named: "Blue")
            } else {
                backButton.tintColor = UIColor(named: myColor!)
                confirmationButton.backgroundColor = UIColor(named: myColor!)
            }

            backButton.image = UIImage(named: "back")

            // Dateに変換
            let birthdayDate = birthday!.stringToDate(format: "yyyy-MM-dd")
            birthdayTextField.text = birthdayDate.dateToStringTemplate(format: "yyyyMMMMd")

            birthdayTextField.uiTextFieldSetting(placeholder: "tannjyoubi".localized())

            confirmationButton.setTitle("kakuninn".localized(), for: .normal)

            // 150年前のdateを取得
            let date150 = Date().dateChange(type: .year, value: -150)
            
            // ピッカー設定
            birthdayPicker.datePickerMode = UIDatePicker.Mode.date
            birthdayPicker.timeZone = NSTimeZone.local
            birthdayPicker.locale = Locale.current
            birthdayPicker.calendar = Calendar.current
            birthdayPicker.date = birthdayDate
            birthdayPicker.maximumDate = Date()
            birthdayPicker.minimumDate = date150
            if #available(iOS 13.4, *) {
                birthdayPicker.preferredDatePickerStyle = .wheels
            }
        }
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

    @IBAction func birthdayPickerValueChanged(_ sender: Any) {
        birthdayTextField.text = birthdayPicker.date.dateToStringTemplate(format: "yyyyMMMMd")
    }
    
    @IBAction func confirmationButtonTouchDown(_ sender: Any) {
        UIButton().uiButtonTapOn(item: confirmationButton, itemRight: confirmationButtonRight, itemLeft: confirmationButtonLeft)
    }
    
    @IBAction func confirmationButtonTouchDragOutside(_ sender: Any) {
        UIButton().uiButtonTapOff(item: confirmationButton, itemRight: confirmationButtonRight, itemLeft: confirmationButtonLeft)
    }
    
    @IBAction func confirmationButtonTouchUpInside(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        UIButton().uiButtonTapOff(item: confirmationButton, itemRight: confirmationButtonRight, itemLeft: confirmationButtonLeft)

        // 選択された誕生日のyyyy-MM-ddを取得
        birthday = birthdayPicker.date.dateToString(format: "yyyy-MM-dd")

        // 選択された誕生日のyyyyMMddを取得
        birthdayString = birthdayPicker.date.dateToString(format: "yyyyMMdd")

        // 13年前のyyyyMMddを取得
        let birthdayTextFieldTextA = Date().dateChange(type: .year, value: -13)
        birthdayOk = birthdayTextFieldTextA.dateToString(format: "yyyyMMdd")

        if let userDefaults = userDefaults {
            let birthday = userDefaults.string(forKey: "birthday")

            // Dateに変換
            let birthdayDate = birthday!.stringToDate(format: "yyyy-MM-dd")
            nowBirthday = birthdayDate.dateToString(format: "yyyyMMdd")
        }
        
        if birthdayString <= birthdayOk {
            if birthdayString == nowBirthday {
                navigationController?.popViewController(animated: true)
            } else {
                let storyBoard = UIStoryboard(name: "SaveNewInformation", bundle: nil)
                let nextVC = storyBoard.instantiateInitialViewController()
                let vc = (nextVC as? SaveNewInformationViewController)
                
                // 値の設定
                vc!.birthday = birthday
                vc!.birthdayString = birthdayTextField.text!
                
                navigationController?.pushViewController(nextVC!, animated: true)
            }
        } else {
            let alertText = "tannjyoubiwohennkoudekinai".localized()
            let message = ""
            let okText = "OK".localized()

            let alertController = UIAlertController(title: alertText, message: message, preferredStyle: .alert)

            let okButton = UIAlertAction(title: okText, style: .cancel, handler: { _ in
                self.navigationController?.popViewController(animated: true)
            })

            alertController.view.tintColor = UIColor(named: "BlackWhite")
            alertController.addAction(okButton)

            present(alertController, animated: true, completion: nil)
            
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.error)
        }
    }

    @IBAction func backButton(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        navigationController?.popViewController(animated: true)
    }
}
