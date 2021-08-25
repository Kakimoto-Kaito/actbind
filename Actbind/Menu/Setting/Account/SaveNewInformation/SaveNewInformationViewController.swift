//
//  SaveNewInformationViewController.swift
//  Actbind
//
//  Created by 柿本　海斗 on 2020/12/03.
//

import AudioToolbox
import UIKit

final class SaveNewInformationViewController: UIViewController, UIGestureRecognizerDelegate {
    let userDefaults = UserDefaults(suiteName: "group.com.actbind")
    let api = KeyManager().getValue(key: "API") as? String

    var name1 = ""
    var name2 = ""
    var mailaddress = ""
    var gender = 0
    var genderString = ""
    var birthday = ""
    var birthdayString = ""
    
    @IBOutlet weak var navigationBarTitle: UINavigationItem!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var currentValueTitleLabel: UILabel!
    @IBOutlet weak var currentValueLabel: UILabel!
    @IBOutlet weak var newValueTitleLabel: UILabel!
    @IBOutlet weak var newValueLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true

        navigationBarTitle.title = "atarasiijyouhouhozonn".localized()

        let newName = name1 + " " + name2

        if let userDefaults = userDefaults {
            let myColor = userDefaults.string(forKey: "mycolor")
            let nowName = userDefaults.string(forKey: "name1")! + " " + userDefaults.string(forKey: "name2")!
            let mailaddressNow = userDefaults.string(forKey: "mailaddress")
            let genderNow = userDefaults.string(forKey: "gender")
            let birthdayNow = userDefaults.string(forKey: "birthday")

            if myColor == "Original" {
                backButton.tintColor = UIColor(named: "BlackWhite")
                cancelButton.setTitleColor(UIColor(named: "Blue"), for: .normal)
                passwordTextField.tintColor = UIColor(named: "Blue")
            } else {
                backButton.tintColor = UIColor(named: myColor!)
                cancelButton.setTitleColor(UIColor(named: myColor!), for: .normal)
                passwordTextField.tintColor = UIColor(named: myColor!)
            }
        
            backButton.image = UIImage(named: "back")

            if newName == " " {
                if mailaddress == "" {
                    if gender == 0 {
                        currentValueTitleLabel.text = "gennzainotannjyoubi".localized()
                        // Dateに変換
                        let birthdayDate = birthdayNow!.stringToDate(format: "yyyy-MM-dd")
                        currentValueLabel.text = birthdayDate.dateToStringTemplate(format: "yyyyMMMMd")
                        newValueTitleLabel.text = "atarasiitannjyoubi".localized()
                        newValueLabel.text = birthdayString
                    } else {
                        currentValueTitleLabel.text = "gennzainoseibetu".localized()
                        if genderNow == "1" {
                            currentValueLabel.text = "dannsei".localized()
                        } else if genderNow == "2" {
                            currentValueLabel.text = "jyosei".localized()
                        } else {
                            currentValueLabel.text = "sonota".localized()
                        }
                        newValueTitleLabel.text = "atarasiiseibetu".localized()
                        newValueLabel.text = genderString
                    }
                } else {
                    currentValueTitleLabel.text = "gennzainome-ruadoresu".localized()
                    currentValueLabel.text = mailaddressNow
                    newValueTitleLabel.text = "atarasiime-ruadoresu".localized()
                    newValueLabel.text = mailaddress
                }
            } else {
                currentValueTitleLabel.text = "gennzainonamae".localized()
                currentValueLabel.text = nowName
                newValueTitleLabel.text = "atarasiinamae".localized()
                newValueLabel.text = newName
            }
        }

        passwordLabel.text = "hozonnpasuwa-do".localized()
        
        passwordTextField.uiTextFieldSetting(placeholder: "pasuwa-do".localized())
        
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
    @IBAction func passwordDidEndOnExit(_ sender: Any) {}
    
    @IBAction func passwordTextFieldEditingChanged(_ sender: Any) {
        // passwordTextFieldに入力された文字数を取得
        let passwordCount = passwordTextField.text!.count
        
        // パスワードが8文字以上の時
        if passwordCount >= 8 {
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

        let newName = name1 + name2

        let passwordTextFieldNotwhitespaces = passwordTextField.text!.stringCharacterSetRemove(characterSet: .whitespaces)

        if let userDefaults = userDefaults {
            let password = userDefaults.string(forKey: "password")
            // パスワードが正しい時
            let afterPassword = passwordTextFieldNotwhitespaces.stringReplacement()
            
            if password == afterPassword {
                saveButton.isEnabled = false
                passwordTextField.isEnabled = false
                navigationController?.interactivePopGestureRecognizer?.isEnabled = false
                backButton.isEnabled = false
                cancelButton.isEnabled = false

                activityView.isHidden = false
                checkmarkImage.isHidden = true
                activityIndicator.startAnimating()
                
                if let userDefaults = self.userDefaults {
                    let userId = userDefaults.integer(forKey: "userid")
                    if newName == "" {
                        if mailaddress == "" {
                            if gender == 0 {
                                apiBirthday(userId: userId, value: birthday)
                            } else {
                                apiGender(userId: userId, value: gender)
                            }
                        } else {
                            apiMailaddress(userId: userId, value: mailaddress)
                        }
                    } else {
                        apiName(userId: userId, value1: name1, value2: name2)
                    }
                }
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
        
        if mailaddress == "" {
            navigationController?.popViewController(animated: true)
        } else {
            // 2つ前のViewControllerに戻る
            let index = navigationController!.viewControllers.count - 3
            navigationController?.popToViewController(navigationController!.viewControllers[index], animated: true)
        }
    }

    @IBAction func backBottonAction(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        navigationController?.popViewController(animated: true)
    }
    
    func apiBirthday(userId: Int, value: String) {
        let url = URL(string: api! + "userchange")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST" // Postリクエストを送る(このコードがないとGetリクエストになる)
        request.addValue("application/json", forHTTPHeaderField: "content-type")
        // request.addValue("", forHTTPHeaderField: "authorization") //APIKey
        
        // 構造体を作成
        struct UserChange: Codable {
            let changeKey: String
            let userId: Int
            let birthday: String
        }
        
        let encoder = JSONEncoder()
        
        let body = UserChange(changeKey: "birthday", userId: userId, birthday: value)
        
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
                        userDefaults.setValue(self.birthday, forKeyPath: "birthday")
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
    
    func apiGender(userId: Int, value: Int) {
        let url = URL(string: api! + "userchange")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST" // Postリクエストを送る(このコードがないとGetリクエストになる)
        request.addValue("application/json", forHTTPHeaderField: "content-type")
        // request.addValue("", forHTTPHeaderField: "authorization") //APIKey
        
        // 構造体を作成
        struct UserChange: Codable {
            let changeKey: String
            let userId: Int
            let gender: Int
        }
        
        let encoder = JSONEncoder()
        
        let body = UserChange(changeKey: "gender", userId: userId, gender: value)
        
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
                        userDefaults.setValue(self.gender, forKeyPath: "gender")
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
    
    func apiMailaddress(userId: Int, value: String) {
        let url = URL(string: api! + "userchange")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST" // Postリクエストを送る(このコードがないとGetリクエストになる)
        request.addValue("application/json", forHTTPHeaderField: "content-type")
        // request.addValue("", forHTTPHeaderField: "authorization") //APIKey
        
        // 構造体を作成
        struct UserChange: Codable {
            let changeKey: String
            let userId: Int
            let mailaddress: String
        }
        
        let encoder = JSONEncoder()
        
        let body = UserChange(changeKey: "mailaddress", userId: userId, mailaddress: value)
        
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
                        userDefaults.setValue(self.mailaddress, forKeyPath: "mailaddress")
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
    
    func apiName(userId: Int, value1: String, value2: String) {
        let url = URL(string: api! + "userchange")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST" // Postリクエストを送る(このコードがないとGetリクエストになる)
        request.addValue("application/json", forHTTPHeaderField: "content-type")
        // request.addValue("", forHTTPHeaderField: "authorization") //APIKey
        
        // 構造体を作成
        struct UserChange: Codable {
            let changeKey: String
            let userId: Int
            let name1: String
            let name2: String
        }
        
        let encoder = JSONEncoder()
        
        let body = UserChange(changeKey: "name", userId: userId, name1: value1, name2: value2)
        
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
                        userDefaults.setValue(self.name1, forKeyPath: "name1")
                        userDefaults.setValue(self.name2, forKeyPath: "name2")
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
