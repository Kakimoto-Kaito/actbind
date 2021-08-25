//
//  SignUpAccountNameViewController.swift
//  Actbind
//
//  Created by 柿本　海斗 on 2020/12/17.
//

import AudioToolbox
import UIKit

final class SignUpUserNameViewController: UIViewController, UIGestureRecognizerDelegate {
    let api = KeyManager().getValue(key: "API") as? String
    
    var name1 = ""
    var name2 = ""
    var mailaddress = ""
    var password = ""
    var gender = 0
    var birthday = ""

    @IBOutlet weak var signUpUserNameTitleLabel: UILabel!
    @IBOutlet weak var userNameExplanationLabel: UILabel!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var errorViewBottom: NSLayoutConstraint!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var nextButtonRight: NSLayoutConstraint!
    @IBOutlet weak var nextButtonLeft: NSLayoutConstraint!
    @IBOutlet weak var haveAccountButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
        signUpUserNameTitleLabel.text = "yu-za-ne-muwonyuuryoku".localized()

        userNameExplanationLabel.text = "yu-za-ne-musetumei".localized()

        userNameTextField.uiTextFieldSetting(placeholder: "yu-za-ne-mu".localized())

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
    @IBAction func userNameTextFieldDidEndOnExit(_ sender: Any) {}

    @IBAction func userNameTextFieldEditingChanged(_ sender: Any) {
        // アカウントネームが正しい時
        if userNameTextField.text!.count >= 5, userNameTextField.text!.count <= 30 {
            nextButton.isEnabled = true
            nextButton.setTitleColor(UIColor(named: "White"), for: .normal)
            nextButton.backgroundColor = UIColor(named: "Blue")
            // アカウントネームが正しくない時
        } else {
            nextButton.isEnabled = false
            nextButton.setTitleColor(UIColor(named: "EnabledButtonText"), for: .normal)
            nextButton.backgroundColor = UIColor(named: "EnabledButton")
        }
    }

    @IBAction func userNameTextFieldEditingDidBegin(_ sender: Any) {
        userNameTextField.layer.borderColor = UIColor.systemBlue.cgColor
    }

    @IBAction func userNameTextFieldEditingDidEnd(_ sender: Any) {
        userNameTextField.layer.borderColor = UIColor.lightGray.cgColor
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

        // ユーザーネームが正しい時
        if UserNameViewController.isValidAccountName(userNameTextField.text!) {
            // ユーザーネームが数字だけでない時
            if !OnlyNumberViewController.isValidOnlyNumber(userNameTextField.text!) {
                // ユーザーネームがアンダーバーだけでない時
                if !OnlyUnderbarViewController.isValidOnlyUnderbar(userNameTextField.text!) {
                    userNameTextField.isEnabled = false
                    nextButton.isEnabled = false
                    nextButton.setTitleColor(UIColor(named: "EnabledButtonText"), for: .normal)
                    nextButton.backgroundColor = UIColor(named: "EnabledButton")
                    haveAccountButton.isEnabled = false
                    navigationController?.interactivePopGestureRecognizer?.isEnabled = false
                    
                    apiUserNameOnOff()
                    // ユーザーネームがアンダーバーだけの時
                } else {
                    userNameTextField.layer.borderColor = UIColor.systemPink.cgColor
                    errorLabel.text = "annda-ba-dakeera-".localized()
                    errorView.errorViewTransition(value: 163)
                    let generator = UINotificationFeedbackGenerator()
                    generator.notificationOccurred(.error)
                }
                // ユーザーネームが数字だけの時
            } else {
                userNameTextField.layer.borderColor = UIColor.systemPink.cgColor
                errorLabel.text = "suujidakeera-".localized()
                errorView.errorViewTransition(value: 163)
                let generator = UINotificationFeedbackGenerator()
                generator.notificationOccurred(.error)
            }
            // ユーザーネームが正しくない時
        } else {
            userNameTextField.layer.borderColor = UIColor.systemPink.cgColor
            errorLabel.text = "yu-za-ne-muera-".localized()
            errorView.errorViewTransition(value: 163)
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.error)
        }
    }

    @IBAction func haveAccountButton(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        dismiss(animated: true, completion: nil)
    }
    
    func apiUserNameOnOff() {
        // 入力された文字の大文字を小文字に
        let userNameMini = userNameTextField.text!.lowercased()
        let userNameMiniNotwhitespaces = userNameMini.stringCharacterSetRemove(characterSet: .whitespaces)
        
        let url = URL(string: api! + "user")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST" // Postリクエストを送る(このコードがないとGetリクエストになる)
        request.addValue("application/json", forHTTPHeaderField: "content-type")
        // request.addValue("", forHTTPHeaderField: "authorization") //APIKey
        
        // 構造体を作成
        struct UserNameOnOff: Codable {
            let OperationType: String
            let userName: String
        }
        
        let encoder = JSONEncoder()
        
        let body = UserNameOnOff(OperationType: "USERNAME", userName: userNameMiniNotwhitespaces)
        
        do {
            // EncodeしてhttpBodyに設定
            let data = try encoder.encode(body)
            request.httpBody = data
        } catch let encodeError as NSError {
            print("Encoder error: \(encodeError.localizedDescription)")
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                self.userNameTextField.isEnabled = true
                self.nextButton.isEnabled = true
                self.nextButton.setTitleColor(UIColor(named: "White"), for: .normal)
                self.nextButton.backgroundColor = UIColor(named: "Blue")
                self.haveAccountButton.isEnabled = true
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
                        let storyBoard = UIStoryboard(name: "SignUpCheck", bundle: nil)
                        let nextVC = storyBoard.instantiateInitialViewController()
                        let vc = (nextVC as? SignUpCheckViewController)
                        
                        // 値の設定
                        vc!.name1 = self.name1
                        vc!.name2 = self.name2
                        vc!.mailaddress = self.mailaddress
                        vc!.password = self.password
                        vc!.gender = self.gender
                        vc!.birthday = self.birthday
                        vc!.username = userNameMiniNotwhitespaces
                        
                        self.navigationController?.pushViewController(nextVC!, animated: true)
                    }
                } else {
                    DispatchQueue.main.async {
                        self.userNameTextField.layer.borderColor = UIColor.systemPink.cgColor
                        self.errorLabel.text = "siyoudekinaiyu-za-ne-mu".localized()
                        self.errorView.errorViewTransition(value: 163)
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
        errorLabel.text = "era-".localized()
        errorView.errorViewTransition(value: 182)
        
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.error)
    }
}
