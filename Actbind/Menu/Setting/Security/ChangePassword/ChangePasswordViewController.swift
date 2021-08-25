//
//  ChangePasswordViewController.swift
//  Actbind
//
//  Created by 柿本　海斗 on 2020/12/14.
//

import AudioToolbox
import UIKit

final class ChangePasswordViewController: UIViewController, UIGestureRecognizerDelegate {
    let userDefaults = UserDefaults(suiteName: "group.com.actbind")
    let api = KeyManager().getValue(key: "API") as? String

    @IBOutlet weak var navigationBarTitle: UINavigationItem!
    @IBOutlet weak var currentpasswordTextField: UITextField!
    @IBOutlet weak var passwordExplanationLabel: UILabel!
    @IBOutlet weak var newpasswordTextField: UITextField!
    @IBOutlet weak var newagainpasswordTextField: UITextField!
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var errorViewBottom: NSLayoutConstraint!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var saveButtonRight: NSLayoutConstraint!
    @IBOutlet weak var saveButtonLeft: NSLayoutConstraint!
    @IBOutlet weak var activityView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var checkmarkImage: UIImageView!
    @IBOutlet weak var activityLabel: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var cancelButtonRight: NSLayoutConstraint!
    @IBOutlet weak var cancelButtonLeft: NSLayoutConstraint!
    @IBOutlet weak var backButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true

        navigationBarTitle.title = "pasuwa-do".localized()

        if let userDefaults = userDefaults {
            let myColor = userDefaults.string(forKey: "mycolor")

            if myColor == "Original" {
                backButton.tintColor = UIColor(named: "BlackWhite")
                cancelButton.setTitleColor(UIColor(named: "Blue"), for: .normal)
                currentpasswordTextField.tintColor = UIColor(named: "Blue")
                newpasswordTextField.tintColor = UIColor(named: "Blue")
                newagainpasswordTextField.tintColor = UIColor(named: "Blue")
            } else {
                backButton.tintColor = UIColor(named: myColor!)
                cancelButton.setTitleColor(UIColor(named: myColor!), for: .normal)
                currentpasswordTextField.tintColor = UIColor(named: myColor!)
                newpasswordTextField.tintColor = UIColor(named: myColor!)
                newagainpasswordTextField.tintColor = UIColor(named: myColor!)
            }
        }

        backButton.image = UIImage(named: "back")

        currentpasswordTextField.uiTextFieldSetting(placeholder: "gennzainopasuwa-do".localized())

        passwordExplanationLabel.text = "pasuwa-dosetumei".localized()
        
        newpasswordTextField.uiTextFieldSetting(placeholder: "atarasiipasuwa-do".localized())
        
        newagainpasswordTextField.uiTextFieldSetting(placeholder: "atarasiipasuwa-domouitidonyuuryoku".localized())

        errorLabel.text = ""
        errorViewBottom.constant = -60

        saveButton.setTitle("hozonn".localized(), for: .normal)

        cancelButton.setTitle("kyannseru".localized(), for: .normal)

        activityView.cornerAll(value: 16, fulcrum: "")
        activityView.isHidden = true

        checkmarkImage.image = UIImage(named: "")
        activityLabel.text = "hennkounaiyousetteityuu".localized()
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
    @IBAction func currentpasswordDidEndOnExit(_ sender: Any) {}

    @IBAction func currentpasswordTextFieldEditingChanged(_ sender: Any) {
        // passwordTextFieldに入力された文字数を取得
        let nowpasswordCount = currentpasswordTextField.text!.count
        let newpasswordCount = newpasswordTextField.text!.count
        let newagainpasswordCount = newagainpasswordTextField.text!.count

        // パスワードが8文字以上の時
        if nowpasswordCount >= 8 {
            // パスワードが8文字以上の時
            if newpasswordCount >= 8 {
                // パスワードが8文字以上の時
                if newagainpasswordCount >= 8 {
                    saveButton.isEnabled = true
                    saveButton.setTitleColor(UIColor(named: "White"), for: .normal)
                    if let userDefaults = userDefaults {
                        let myColor = userDefaults.string(forKey: "mycolor")

                        if myColor == "Original" {
                            saveButton.backgroundColor = UIColor(named: "Blue")
                        } else {
                            saveButton.backgroundColor = UIColor(named: myColor!)
                        }
                    }
                    // パスワードが8文字未満の時
                } else {
                    saveButton.isEnabled = false
                    saveButton.setTitleColor(UIColor(named: "EnabledButtonText"), for: .normal)
                    saveButton.backgroundColor = UIColor(named: "EnabledButton")
                }
                // パスワードが8文字未満の時
            } else {
                saveButton.isEnabled = false
                saveButton.setTitleColor(UIColor(named: "EnabledButtonText"), for: .normal)
                saveButton.backgroundColor = UIColor(named: "EnabledButton")
            }
            // パスワードが8文字未満の時
        } else {
            saveButton.isEnabled = false
            saveButton.setTitleColor(UIColor(named: "EnabledButtonText"), for: .normal)
            saveButton.backgroundColor = UIColor(named: "EnabledButton")
        }
    }

    @IBAction func currentpasswordTextFieldEditingDidBegin(_ sender: Any) {
        if let userDefaults = userDefaults {
            let myColor = userDefaults.string(forKey: "mycolor")
            
            if myColor == "Original" || myColor == "Blue" {
                currentpasswordTextField.layer.borderColor = UIColor.systemBlue.cgColor
            } else if myColor == "Red" {
                currentpasswordTextField.layer.borderColor = UIColor.systemRed.cgColor
            } else if myColor == "Orange" {
                currentpasswordTextField.layer.borderColor = UIColor.systemOrange.cgColor
            } else if myColor == "Yellow" {
                currentpasswordTextField.layer.borderColor = UIColor.systemYellow.cgColor
            } else if myColor == "Green" {
                currentpasswordTextField.layer.borderColor = UIColor.systemGreen.cgColor
            } else {
                currentpasswordTextField.layer.borderColor = UIColor.systemPurple.cgColor
            }
        }
        newpasswordTextField.layer.borderColor = UIColor.lightGray.cgColor
        newagainpasswordTextField.layer.borderColor = UIColor.lightGray.cgColor
    }

    @IBAction func currentpasswordTextFieldEditingDidEnd(_ sender: Any) {
        currentpasswordTextField.layer.borderColor = UIColor.lightGray.cgColor
    }

    // 完了キーをタップでキーボードが閉じる
    @IBAction func newpasswordDidEndOnExit(_ sender: Any) {}

    @IBAction func newpasswordTextFieldEditingChanged(_ sender: Any) {
        // passwordTextFieldに入力された文字数を取得
        let nowpasswordCount = currentpasswordTextField.text!.count
        let newpasswordCount = newpasswordTextField.text!.count
        let newagainpasswordCount = newagainpasswordTextField.text!.count

        // パスワードが8文字以上の時
        if nowpasswordCount >= 8 {
            // パスワードが8文字以上の時
            if newpasswordCount >= 8 {
                // パスワードが8文字以上の時
                if newagainpasswordCount >= 8 {
                    saveButton.isEnabled = true
                    saveButton.setTitleColor(UIColor(named: "White"), for: .normal)
                    if let userDefaults = userDefaults {
                        let myColor = userDefaults.string(forKey: "mycolor")

                        if myColor == "Original" {
                            saveButton.backgroundColor = UIColor(named: "Blue")
                        } else {
                            saveButton.backgroundColor = UIColor(named: myColor!)
                        }
                    }
                    // パスワードが8文字未満の時
                } else {
                    saveButton.isEnabled = false
                    saveButton.setTitleColor(UIColor(named: "EnabledButtonText"), for: .normal)
                    saveButton.backgroundColor = UIColor(named: "EnabledButton")
                }
                // パスワードが8文字未満の時
            } else {
                saveButton.isEnabled = false
                saveButton.setTitleColor(UIColor(named: "EnabledButtonText"), for: .normal)
                saveButton.backgroundColor = UIColor(named: "EnabledButton")
            }
            // パスワードが8文字未満の時
        } else {
            saveButton.isEnabled = false
            saveButton.setTitleColor(UIColor(named: "EnabledButtonText"), for: .normal)
            saveButton.backgroundColor = UIColor(named: "EnabledButton")
        }
    }

    @IBAction func newpasswordTextFieldEditingDidBegin(_ sender: Any) {
        if let userDefaults = userDefaults {
            let myColor = userDefaults.string(forKey: "mycolor")
            
            if myColor == "Original" || myColor == "Blue" {
                newpasswordTextField.layer.borderColor = UIColor.systemBlue.cgColor
            } else if myColor == "Red" {
                newpasswordTextField.layer.borderColor = UIColor.systemRed.cgColor
            } else if myColor == "Orange" {
                newpasswordTextField.layer.borderColor = UIColor.systemOrange.cgColor
            } else if myColor == "Yellow" {
                newpasswordTextField.layer.borderColor = UIColor.systemYellow.cgColor
            } else if myColor == "Green" {
                newpasswordTextField.layer.borderColor = UIColor.systemGreen.cgColor
            } else {
                newpasswordTextField.layer.borderColor = UIColor.systemPurple.cgColor
            }
        }
        currentpasswordTextField.layer.borderColor = UIColor.lightGray.cgColor
        newagainpasswordTextField.layer.borderColor = UIColor.lightGray.cgColor
    }

    @IBAction func newpasswordTextFieldEditingDidEnd(_ sender: Any) {
        newpasswordTextField.layer.borderColor = UIColor.lightGray.cgColor
    }

    // 完了キーをタップでキーボードが閉じる
    @IBAction func newagainpasswordDidEndOnExit(_ sender: Any) {}

    @IBAction func newagainpasswordTextFieldEditingChanged(_ sender: Any) {
        // passwordTextFieldに入力された文字数を取得
        let nowpasswordCount = currentpasswordTextField.text!.count
        let newpasswordCount = newpasswordTextField.text!.count
        let newagainpasswordCount = newagainpasswordTextField.text!.count

        // パスワードが8文字以上の時
        if nowpasswordCount >= 8 {
            // パスワードが8文字以上の時
            if newpasswordCount >= 8 {
                // パスワードが8文字以上の時
                if newagainpasswordCount >= 8 {
                    saveButton.isEnabled = true
                    saveButton.setTitleColor(UIColor(named: "White"), for: .normal)
                    if let userDefaults = userDefaults {
                        let myColor = userDefaults.string(forKey: "mycolor")

                        if myColor == "Original" {
                            saveButton.backgroundColor = UIColor(named: "Blue")
                        } else {
                            saveButton.backgroundColor = UIColor(named: myColor!)
                        }
                    }
                    // パスワードが8文字未満の時
                } else {
                    saveButton.isEnabled = false
                    saveButton.setTitleColor(UIColor(named: "EnabledButtonText"), for: .normal)
                    saveButton.backgroundColor = UIColor(named: "EnabledButton")
                }
                // パスワードが8文字未満の時
            } else {
                saveButton.isEnabled = false
                saveButton.setTitleColor(UIColor(named: "EnabledButtonText"), for: .normal)
                saveButton.backgroundColor = UIColor(named: "EnabledButton")
            }
            // パスワードが8文字未満の時
        } else {
            saveButton.isEnabled = false
            saveButton.setTitleColor(UIColor(named: "EnabledButtonText"), for: .normal)
            saveButton.backgroundColor = UIColor(named: "EnabledButton")
        }
    }

    @IBAction func newagainpasswordTextFieldEditingDidBegin(_ sender: Any) {
        if let userDefaults = userDefaults {
            let myColor = userDefaults.string(forKey: "mycolor")
            
            if myColor == "Original" || myColor == "Blue" {
                newagainpasswordTextField.layer.borderColor = UIColor.systemBlue.cgColor
            } else if myColor == "Red" {
                newagainpasswordTextField.layer.borderColor = UIColor.systemRed.cgColor
            } else if myColor == "Orange" {
                newagainpasswordTextField.layer.borderColor = UIColor.systemOrange.cgColor
            } else if myColor == "Yellow" {
                newagainpasswordTextField.layer.borderColor = UIColor.systemYellow.cgColor
            } else if myColor == "Green" {
                newagainpasswordTextField.layer.borderColor = UIColor.systemGreen.cgColor
            } else {
                newagainpasswordTextField.layer.borderColor = UIColor.systemPurple.cgColor
            }
        }
        currentpasswordTextField.layer.borderColor = UIColor.lightGray.cgColor
        newpasswordTextField.layer.borderColor = UIColor.lightGray.cgColor
    }

    @IBAction func newagainpasswordTextFieldEditingDidEnd(_ sender: Any) {
        newagainpasswordTextField.layer.borderColor = UIColor.lightGray.cgColor
    }

    @IBAction func saveButtonTouchDown(_ sender: Any) {
        UIButton().uiButtonTapOn(item: saveButton, itemRight: saveButtonRight, itemLeft: saveButtonLeft)
    }

    @IBAction func saveButtonTouchDragOutside(_ sender: Any) {
        UIButton().uiButtonTapOff(item: saveButton, itemRight: saveButtonRight, itemLeft: saveButtonLeft)
    }

    @IBAction func saveButtonTouchUpInside(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        UIButton().uiButtonTapOff(item: saveButton, itemRight: saveButtonRight, itemLeft: saveButtonLeft)

        view.endEditing(true)

        let nowpasswordTextFieldNotwhitespaces = currentpasswordTextField.text!.stringCharacterSetRemove(characterSet: .whitespaces)
        let newpasswordTextFieldNotwhitespaces = newpasswordTextField.text!.stringCharacterSetRemove(characterSet: .whitespaces)
        let newagainpasswordTextFieldNotwhitespaces = newagainpasswordTextField.text!.stringCharacterSetRemove(characterSet: .whitespaces)

        if let userDefaults = userDefaults {
            let userId = userDefaults.integer(forKey: "userid")
            let password = userDefaults.string(forKey: "password")
            // パスワードが正しい時
            let afterNowPassword = nowpasswordTextFieldNotwhitespaces.stringReplacement()
            
            if password == afterNowPassword {
                // パスワードが正しい時
                if PasswordViewController.isValidPassword(newpasswordTextFieldNotwhitespaces) {
                    // パスワードが正しい時
                    if PasswordViewController.isValidPassword(newagainpasswordTextFieldNotwhitespaces) {
                        if newpasswordTextFieldNotwhitespaces == newagainpasswordTextFieldNotwhitespaces {
                            let afterNewPassword = newpasswordTextFieldNotwhitespaces.stringReplacement()
                            
                            if password == afterNewPassword {
                                navigationController?.popViewController(animated: true)
                            } else {
                                apiPassword(userId: userId, value: afterNewPassword)
                                saveButton.isEnabled = false
                                navigationController?.interactivePopGestureRecognizer?.isEnabled = false
                                backButton.isEnabled = false
                                cancelButton.isEnabled = false

                                activityView.isHidden = false
                                activityIndicator.startAnimating()
                            }
                        } else {
                            newpasswordTextField.layer.borderColor = UIColor.systemPink.cgColor
                            newagainpasswordTextField.layer.borderColor = UIColor.systemPink.cgColor
                            errorLabel.text = "pasuwa-dogaittisimasenn".localized()
                            errorView.errorViewTransition(value: 182)
                            let generator = UINotificationFeedbackGenerator()
                            generator.notificationOccurred(.error)
                        }
                        // パスワードが正しくない時
                    } else {
                        newagainpasswordTextField.layer.borderColor = UIColor.systemPink.cgColor
                        errorLabel.text = "pasuwa-doera-".localized()
                        errorView.errorViewTransition(value: 182)
                        let generator = UINotificationFeedbackGenerator()
                        generator.notificationOccurred(.error)
                    }
                    // パスワードが正しくない時
                } else {
                    newpasswordTextField.layer.borderColor = UIColor.systemPink.cgColor
                    errorLabel.text = "pasuwa-doera-".localized()
                    errorView.errorViewTransition(value: 182)
                    let generator = UINotificationFeedbackGenerator()
                    generator.notificationOccurred(.error)
                }
                // パスワードが正しくない時
            } else {
                currentpasswordTextField.layer.borderColor = UIColor.systemPink.cgColor
                errorLabel.text = "gennzainopasuwa-dogamatigatteimasu".localized()
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
    
    func apiPassword(userId: Int, value: String) {
        let url = URL(string: api! + "userchange")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST" // Postリクエストを送る(このコードがないとGetリクエストになる)
        request.addValue("application/json", forHTTPHeaderField: "content-type")
        // request.addValue("", forHTTPHeaderField: "authorization") //APIKey
        
        // 構造体を作成
        struct UserChange: Codable {
            let changeKey: String
            let userId: Int
            let password: String
        }
        
        let encoder = JSONEncoder()
        
        let body = UserChange(changeKey: "password", userId: userId, password: value)
        
        do {
            // EncodeしてhttpBodyに設定
            let data = try encoder.encode(body)
            request.httpBody = data
        } catch let encodeError as NSError {
            print("Encoder error: \(encodeError.localizedDescription)")
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in

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
                
                DispatchQueue.main.async {
                    if let userDefaults = self.userDefaults {
                        userDefaults.setValue(value, forKeyPath: "password")
                    }
                    
                    self.apiSuccess()
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
    
    func apiSuccess() {
        activityIndicator.stopAnimating()
        checkmarkImage.image = UIImage(named: "success")
        activityLabel.text = "hennkounaiyouhozonn".localized()
        
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.checkmarkImage.image = UIImage(named: "")
            self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
            
            // 2つ前のViewControllerに戻る
            let index = self.navigationController!.viewControllers.count - 3
            self.navigationController?.popToViewController(self.navigationController!.viewControllers[index], animated: true)
        }
    }
    
    func apiError() {
        activityIndicator.stopAnimating()
        checkmarkImage.image = UIImage(named: "error")
        activityLabel.text = "era-".localized()
        
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.error)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.checkmarkImage.image = UIImage(named: "")
            self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
            
            // 2つ前のViewControllerに戻る
            let index = self.navigationController!.viewControllers.count - 3
            self.navigationController?.popToViewController(self.navigationController!.viewControllers[index], animated: true)
        }
    }
}
