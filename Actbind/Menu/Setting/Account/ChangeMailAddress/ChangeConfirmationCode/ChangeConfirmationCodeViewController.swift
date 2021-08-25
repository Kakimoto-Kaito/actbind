//
//  ChangeConfirmationCodeViewController.swift
//  Actbind
//
//  Created by 柿本海斗 on 2021/06/11.
//

import AudioToolbox
import UIKit

class ChangeConfirmationCodeViewController: UIViewController, UIGestureRecognizerDelegate {
    let userDefaults = UserDefaults(suiteName: "group.com.actbind")
    let api = KeyManager().getValue(key: "API") as? String
    
    var mailaddress = ""
    var confirmationCode = ""
    
    @IBOutlet weak var navigationBarTitle: UINavigationItem!
    @IBOutlet weak var confirmationCodeExplanationLabel: UILabel!
    @IBOutlet weak var confirmationCodeRequestButton: UIButton!
    @IBOutlet weak var confirmationCodeTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var nextButtonRight: NSLayoutConstraint!
    @IBOutlet weak var nextButtonLeft: NSLayoutConstraint!
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var errorViewBottom: NSLayoutConstraint!
    @IBOutlet weak var backButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true

        apiPostTheConfirmationCode()
        
        navigationBarTitle.title = "ninnsyouko-dowonyuuryoku".localized()
        
        if let userDefaults = userDefaults {
            let myColor = userDefaults.string(forKey: "mycolor")

            if myColor == "Original" {
                backButton.tintColor = UIColor(named: "BlackWhite")
                confirmationCodeRequestButton.setTitleColor(UIColor(named: "Blue"), for: .normal)
                confirmationCodeTextField.tintColor = UIColor(named: "Blue")
            } else {
                backButton.tintColor = UIColor(named: myColor!)
                confirmationCodeRequestButton.setTitleColor(UIColor(named: myColor!), for: .normal)
                confirmationCodeTextField.tintColor = UIColor(named: myColor!)
            }
        }

        confirmationCodeExplanationLabel.text = String(format: "ninnsyouko-dosetumei".localized(), mailaddress)
        
        confirmationCodeRequestButton.setTitle("ninnsyouko-dorikuesuto".localized(), for: .normal)
        
        confirmationCodeTextField.uiTextFieldSetting(placeholder: "ninnsyouko-do".localized())
        
        errorViewBottom.constant = -60
        
        nextButton.setTitle("tugihe".localized(), for: .normal)
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
    
    @IBAction func confirmationCodeRequestButtonTouchDown(_ sender: Any) {
        if let userDefaults = userDefaults {
            let myColor = userDefaults.string(forKey: "mycolor")
            
            if myColor == "Original" {
                confirmationCodeRequestButton.backgroundColor = UIColor(named: "BlueHalf")
            } else {
                confirmationCodeRequestButton.backgroundColor = UIColor(named: myColor! + "Half")
            }
        }
    }

    @IBAction func confirmationCodeRequestButtonTouchDragOutside(_ sender: Any) {
        confirmationCodeRequestButton.backgroundColor = UIColor.clear
    }

    @IBAction func confirmationCodeRequestButtonTouchUpInside(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        confirmationCodeRequestButton.backgroundColor = UIColor.clear
        
        view.endEditing(true)
        
        confirmationCodeTextField.text = ""

        // 乱数
        confirmationCode = String(Int.random(in: 100_000 ..< 1_000_000))
        
        confirmationCodeRequestButton.isEnabled = false
        confirmationCodeRequestButton.setTitleColor(UIColor(named: "EnabledButtonText"), for: .normal)
        confirmationCodeTextField.isEnabled = false
        confirmationCodeTextField.layer.borderColor = UIColor.lightGray.cgColor
        nextButton.isEnabled = false
        nextButton.setTitleColor(UIColor(named: "EnabledButtonText"), for: .normal)
        nextButton.backgroundColor = UIColor(named: "EnabledButton")
        backButton.isEnabled = false
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        apiPostTheConfirmationCode()
    }

    // キーボード以外をタップでキーボードが閉じる
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    // 完了キーをタップでキーボードが閉じる
    @IBAction func ConfirmationCodeTextFieldDidEndOnExit(_ sender: Any) {}
    
    @IBAction func ConfirmationCodeTextFieldEditingChanged(_ sender: Any) {
        if confirmationCodeTextField.text!.count == 6 {
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
        } else {
            nextButton.isEnabled = false
            nextButton.setTitleColor(UIColor(named: "EnabledButtonText"), for: .normal)
            nextButton.backgroundColor = UIColor(named: "EnabledButton")
        }
    }

    @IBAction func ConfirmationCodeTextFieldEditingDidBegin(_ sender: Any) {
        if let userDefaults = userDefaults {
            let myColor = userDefaults.string(forKey: "mycolor")
            
            if myColor == "Original" || myColor == "Blue" {
                confirmationCodeTextField.layer.borderColor = UIColor.systemBlue.cgColor
            } else if myColor == "Red" {
                confirmationCodeTextField.layer.borderColor = UIColor.systemRed.cgColor
            } else if myColor == "Orange" {
                confirmationCodeTextField.layer.borderColor = UIColor.systemOrange.cgColor
            } else if myColor == "Yellow" {
                confirmationCodeTextField.layer.borderColor = UIColor.systemYellow.cgColor
            } else if myColor == "Green" {
                confirmationCodeTextField.layer.borderColor = UIColor.systemGreen.cgColor
            } else {
                confirmationCodeTextField.layer.borderColor = UIColor.systemPurple.cgColor
            }
        }
    }

    @IBAction func ConfirmationCodeTextFieldEditingDidEnd(_ sender: Any) {
        confirmationCodeTextField.layer.borderColor = UIColor.lightGray.cgColor
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

        // 認証コードが正しい時
        if confirmationCodeTextField.text == confirmationCode {
            let storyBoard = UIStoryboard(name: "SaveNewInformation", bundle: nil)
            let nextVC = storyBoard.instantiateInitialViewController()
            let vc = (nextVC as? SaveNewInformationViewController)
            
            // 値の設定
            vc!.mailaddress = mailaddress
            
            navigationController?.pushViewController(nextVC!, animated: true)
            // 認証コードが正しくない時
        } else {
            confirmationCodeTextField.layer.borderColor = UIColor.systemPink.cgColor
            errorLabel.text = "ninnsyouko-doera-".localized()
            errorView.errorViewTransition(value: 114)
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.error)
        }
    }
    
    func apiPostTheConfirmationCode() {
        let url = URL(string: api! + "confirmationcode")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST" // Postリクエストを送る(このコードがないとGetリクエストになる)
        request.addValue("application/json", forHTTPHeaderField: "content-type")
        // request.addValue("", forHTTPHeaderField: "authorization")
        
        // Message構造体を作成
        struct Body: Codable {
            let email: String
            let code: String
        }
        let encoder = JSONEncoder()
        let body = Body(email: mailaddress, code: confirmationCode)
        do {
            // EncodeしてhttpBodyに設定
            let data = try encoder.encode(body)
            request.httpBody = data
        } catch let encodeError as NSError {
            print("Encoder error: \(encodeError.localizedDescription)")
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            DispatchQueue.main.async {
                self.confirmationCodeRequestButton.isEnabled = true
                if let userDefaults = self.userDefaults {
                    let myColor = userDefaults.string(forKey: "mycolor")
                    
                    if myColor == "Original" {
                        self.confirmationCodeRequestButton.setTitleColor(UIColor(named: "Blue"), for: .normal)
                    } else {
                        self.confirmationCodeRequestButton.setTitleColor(UIColor(named: myColor!), for: .normal)
                    }
                }
                self.confirmationCodeTextField.isEnabled = true
                self.nextButton.isEnabled = true
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

    @IBAction func backBottonAction(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        navigationController?.popViewController(animated: true)
    }
}
