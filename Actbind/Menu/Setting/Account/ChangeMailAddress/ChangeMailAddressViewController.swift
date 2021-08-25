//
//  ChangeMailAddressViewController.swift
//  Actbind
//
//  Created by 柿本　海斗 on 2020/12/02.
//

import AudioToolbox
import UIKit

final class ChangeMailAddressViewController: UIViewController, UIGestureRecognizerDelegate {
    let userDefaults = UserDefaults(suiteName: "group.com.actbind")
    let api = KeyManager().getValue(key: "API") as? String

    @IBOutlet weak var navigationBarTitle: UINavigationItem!
    @IBOutlet weak var mailAddressExplanationLabel: UILabel!
    @IBOutlet weak var mailAddressTextField: UITextField!
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var errorTextLabel: UILabel!
    @IBOutlet weak var errorViewBottom: NSLayoutConstraint!
    @IBOutlet weak var confirmationButton: UIButton!
    @IBOutlet weak var confirmationButtonRight: NSLayoutConstraint!
    @IBOutlet weak var confirmationButtonLeft: NSLayoutConstraint!
    @IBOutlet weak var backButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true

        navigationBarTitle.title = "rennrakusakijyouhou".localized()

        if let userDefaults = userDefaults {
            let myColor = userDefaults.string(forKey: "mycolor")
            let mailaddress = userDefaults.string(forKey: "mailaddress")

            if myColor == "Original" {
                backButton.tintColor = UIColor(named: "BlackWhite")
                confirmationButton.backgroundColor = UIColor(named: "Blue")
                mailAddressTextField.tintColor = UIColor(named: "Blue")
            } else {
                backButton.tintColor = UIColor(named: myColor!)
                confirmationButton.backgroundColor = UIColor(named: myColor!)
                mailAddressTextField.tintColor = UIColor(named: myColor!)
            }

            mailAddressTextField.text = mailaddress
        }
        
        backButton.image = UIImage(named: "back")
        
        mailAddressExplanationLabel.text = "me-ruadoresusetumei".localized()

        mailAddressTextField.uiTextFieldSetting(placeholder: "me-ruadoresu".localized())
        
        errorTextLabel.text = ""
        errorViewBottom.constant = -60
        
        confirmationButton.setTitle("kakuninn".localized(), for: .normal)
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
    @IBAction func mailAddressTextFieldDidEndOnExit(_ sender: Any) {}
    
    @IBAction func mailAddressTextFieldEditingChanged(_ sender: Any) {
        if let userDefaults = userDefaults {
            let myColor = userDefaults.string(forKey: "mycolor")

            // mailAddressTextFieldが入力されていない時
            if mailAddressTextField.text == "" {
                confirmationButton.isEnabled = false
                confirmationButton.setTitleColor(UIColor(named: "EnabledButtonText"), for: .normal)
                confirmationButton.backgroundColor = UIColor(named: "EnabledButton")
                // mailAddressTextFieldが入力されている時
            } else {
                if myColor == "Original" {
                    confirmationButton.isEnabled = true
                    confirmationButton.setTitleColor(UIColor(named: "White"), for: .normal)
                    confirmationButton.backgroundColor = UIColor(named: "Blue")
                } else {
                    confirmationButton.isEnabled = true
                    confirmationButton.setTitleColor(UIColor(named: "White"), for: .normal)
                    confirmationButton.backgroundColor = UIColor(named: myColor!)
                }
            }
        }
    }

    @IBAction func mailAddressTextFieldEditingDidBegin(_ sender: Any) {
        if let userDefaults = userDefaults {
            let myColor = userDefaults.string(forKey: "mycolor")
            
            if myColor == "Original" || myColor == "Blue" {
                mailAddressTextField.layer.borderColor = UIColor.systemBlue.cgColor
            } else if myColor == "Red" {
                mailAddressTextField.layer.borderColor = UIColor.systemRed.cgColor
            } else if myColor == "Orange" {
                mailAddressTextField.layer.borderColor = UIColor.systemOrange.cgColor
            } else if myColor == "Yellow" {
                mailAddressTextField.layer.borderColor = UIColor.systemYellow.cgColor
            } else if myColor == "Green" {
                mailAddressTextField.layer.borderColor = UIColor.systemGreen.cgColor
            } else {
                mailAddressTextField.layer.borderColor = UIColor.systemPurple.cgColor
            }
        }
    }

    @IBAction func mailAddressTextFieldEditingDidEnd(_ sender: Any) {
        mailAddressTextField.layer.borderColor = UIColor.lightGray.cgColor
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
        
        mailAddressTextField.endEditing(true)
        
        // 入力されたメールアドレスを小文字にして代入
        let mailAddressMini = mailAddressTextField.text!.lowercased()

        let mailAddressMiniNotwhitespaces = mailAddressMini.stringCharacterSetRemove(characterSet: .whitespaces)

        if let userDefaults = userDefaults {
            let mailaddress = userDefaults.string(forKey: "mailaddress")

            // メールアドレスが正しい時
            if MailAddressViewController.isValidMailAddress(mailAddressTextField.text!) {
                if mailAddressMiniNotwhitespaces == mailaddress {
                    navigationController?.popViewController(animated: true)
                } else {
                    mailAddressTextField.isEnabled = false
                    confirmationButton.isEnabled = false
                    confirmationButton.setTitleColor(UIColor(named: "EnabledButtonText"), for: .normal)
                    confirmationButton.backgroundColor = UIColor(named: "EnabledButton")
                    backButton.isEnabled = false
                    navigationController?.interactivePopGestureRecognizer?.isEnabled = false
                    
                    apiMailaddressOnOff()
                }
                // メールアドレスが正しくない時
            } else {
                mailAddressTextField.layer.borderColor = UIColor.systemPink.cgColor
                errorTextLabel.text = "me-ruadoresuera-".localized()
                errorView.errorViewTransition(value: 114)
                let generator = UINotificationFeedbackGenerator()
                generator.notificationOccurred(.error)
            }
        }
    }

    @IBAction func backBottonAction(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        navigationController?.popViewController(animated: true)
    }
    
    func apiMailaddressOnOff() {
        // 入力されたメールアドレスを小文字にして代入
        let mailAddressMini = mailAddressTextField.text!.lowercased()
        let mailAddressMiniNotwhitespaces = mailAddressMini.stringCharacterSetRemove(characterSet: .whitespaces)
        // 乱数
        let confirmationCode = String(Int.random(in: 100_000 ..< 1_000_000))
        
        let url = URL(string: api! + "user")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST" // Postリクエストを送る(このコードがないとGetリクエストになる)
        request.addValue("application/json", forHTTPHeaderField: "content-type")
        // request.addValue("", forHTTPHeaderField: "authorization") //APIKey
        
        // 構造体を作成
        struct MailaddressOnOff: Codable {
            let OperationType: String
            let mailaddress: String
        }
        
        let encoder = JSONEncoder()
        
        let body = MailaddressOnOff(OperationType: "MAILADDRESS", mailaddress: mailAddressMiniNotwhitespaces)
        
        do {
            // EncodeしてhttpBodyに設定
            let data = try encoder.encode(body)
            request.httpBody = data
        } catch let encodeError as NSError {
            print("Encoder error: \(encodeError.localizedDescription)")
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                self.mailAddressTextField.isEnabled = true
                self.confirmationButton.isEnabled = true
                if let userDefaults = self.userDefaults {
                    let myColor = userDefaults.string(forKey: "mycolor")
                    
                    if myColor == "Original" {
                        self.confirmationButton.setTitleColor(UIColor(named: "White"), for: .normal)
                        self.confirmationButton.backgroundColor = UIColor(named: "Blue")
                    } else {
                        self.confirmationButton.setTitleColor(UIColor(named: "White"), for: .normal)
                        self.confirmationButton.backgroundColor = UIColor(named: myColor!)
                    }
                }
                self.backButton.isEnabled = true
                self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
            }

            // ここのエラーはクライアントサイドのエラー(ホストに接続できないなど)
            if let error = error {
                DispatchQueue.main.async {
                    print("クライアントエラー: \(error.localizedDescription)")
                    self.apiError()
                }
            }

            guard let data = data, let response = response as? HTTPURLResponse else {
                print("no data or no response")
                return
            }
            
            if response.statusCode == 200 {
                let json = String(data: data, encoding: .utf8)!
                print(json)
                
                if json == "[]" {
                    DispatchQueue.main.async {
                        let storyBoard = UIStoryboard(name: "ChangeConfirmationCode", bundle: nil)
                        let nextVC = storyBoard.instantiateInitialViewController()
                        let vc = (nextVC as? ChangeConfirmationCodeViewController)
                        
                        // 値の設定
                        // 値の設定
                        vc!.mailaddress = mailAddressMiniNotwhitespaces
                        vc!.confirmationCode = confirmationCode
                        
                        self.navigationController?.pushViewController(nextVC!, animated: true)
                    }
                } else {
                    DispatchQueue.main.async {
                        self.mailAddressTextField.layer.borderColor = UIColor.systemPink.cgColor
                        self.errorTextLabel.text = "siyoudekinaime-ruadoresu".localized()
                        self.errorView.errorViewTransition(value: 114)
                        let generator = UINotificationFeedbackGenerator()
                        generator.notificationOccurred(.error)
                    }
                }
            } else {
                DispatchQueue.main.async {
                    // レスポンスのステータスコードが200でない場合などはサーバサイドエラー
                    print("サーバエラー ステータスコード: \(response.statusCode)")
                    self.apiError()
                }
            }
        }
        task.resume()
    }
    
    func apiError() {
        errorTextLabel.text = "era-".localized()
        errorView.errorViewTransition(value: 182)
        
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.error)
    }
}
