//
//  SignUpMailAddressViewController.swift
//  Actbind
//
//  Created by 柿本　海斗 on 2020/12/17.
//

import AudioToolbox
import UIKit

final class SignUpMailAddressViewController: UIViewController, UIGestureRecognizerDelegate {
    let api = KeyManager().getValue(key: "API") as? String
    
    var name1 = ""
    var name2 = ""

    @IBOutlet weak var signUpMailAddressTitleLabel: UILabel!
    @IBOutlet weak var mailAddressExplanationLabel: UILabel!
    @IBOutlet weak var mailAddressTextField: UITextField!
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

        signUpMailAddressTitleLabel.text = "me-ruadoresuwonyuuryoku".localized()

        mailAddressExplanationLabel.text = "me-ruadoresusetumei".localized()

        mailAddressTextField.uiTextFieldSetting(placeholder: "me-ruadoresu".localized())

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
    @IBAction func mailAddressTextFieldDidEndOnExit(_ sender: Any) {}

    @IBAction func mailAddressTextFieldEditingChanged(_ sender: Any) {
        // mailAddressTextFieldが入力されていない時
        if mailAddressTextField.text == "" {
            nextButton.isEnabled = false
            nextButton.setTitleColor(UIColor(named: "EnabledButtonText"), for: .normal)
            nextButton.backgroundColor = UIColor(named: "EnabledButton")
            // mailAddressTextFieldが入力されている時
        } else {
            nextButton.isEnabled = true
            nextButton.setTitleColor(UIColor(named: "White"), for: .normal)
            nextButton.backgroundColor = UIColor(named: "Blue")
        }
    }

    @IBAction func mailAddressTextFieldEditingDidBegin(_ sender: Any) {
        mailAddressTextField.layer.borderColor = UIColor.systemBlue.cgColor
    }

    @IBAction func mailAddressTextFieldEditingDidEnd(_ sender: Any) {
        mailAddressTextField.layer.borderColor = UIColor.lightGray.cgColor
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

        // メールアドレスが正しい時
        if MailAddressViewController.isValidMailAddress(mailAddressTextField.text!) {
            mailAddressTextField.isEnabled = false
            nextButton.isEnabled = false
            nextButton.setTitleColor(UIColor(named: "EnabledButtonText"), for: .normal)
            nextButton.backgroundColor = UIColor(named: "EnabledButton")
            haveAccountButton.isEnabled = false
            navigationController?.interactivePopGestureRecognizer?.isEnabled = false
            
            apiMailaddressOnOff()
            // メールアドレスが正しくない時
        } else {
            mailAddressTextField.layer.borderColor = UIColor.systemPink.cgColor
            errorLabel.text = "me-ruadoresuera-".localized()
            errorView.errorViewTransition(value: 163)
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.error)
        }
    }

    @IBAction func haveAccountButton(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        dismiss(animated: true, completion: nil)
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
                        let storyBoard = UIStoryboard(name: "SignUpConfirmationCode", bundle: nil)
                        let nextVC = storyBoard.instantiateInitialViewController()
                        let vc = (nextVC as? SignUpConfirmationCodeViewController)
                        
                        // 値の設定
                        vc!.name1 = self.name1
                        vc!.name2 = self.name2
                        vc!.mailaddress = mailAddressMiniNotwhitespaces
                        vc!.confirmationCode = confirmationCode
                        
                        self.navigationController?.pushViewController(nextVC!, animated: true)
                    }
                } else {
                    DispatchQueue.main.async {
                        self.mailAddressTextField.layer.borderColor = UIColor.systemPink.cgColor
                        self.errorLabel.text = "siyoudekinaime-ruadoresu".localized()
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
