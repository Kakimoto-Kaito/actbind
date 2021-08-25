//
//  SignUpConfirmationCodeViewController.swift
//  Actbind
//
//  Created by 柿本　海斗 on 2020/11/28.
//

import AudioToolbox
import UIKit

class SignUpConfirmationCodeViewController: UIViewController, UIGestureRecognizerDelegate {
    let api = KeyManager().getValue(key: "API") as? String
    
    var name1 = ""
    var name2 = ""
    var mailaddress = ""
    var confirmationCode = ""

    @IBOutlet weak var signUpConfirmationCodeTitleLabel: UILabel!
    @IBOutlet weak var confirmationCodeExplanationLabel: UILabel!
    @IBOutlet weak var confirmationCodeRequestButton: UIButton!
    @IBOutlet weak var confirmationCodeTextField: UITextField!
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
        
        apiPostTheConfirmationCode()
        
        signUpConfirmationCodeTitleLabel.text = "ninnsyouko-dowonyuuryoku".localized()
        
        confirmationCodeExplanationLabel.text = String(format: "ninnsyouko-dosetumei".localized(), mailaddress)
        
        confirmationCodeRequestButton.setTitle("ninnsyouko-dorikuesuto".localized(), for: .normal)
        
        confirmationCodeTextField.uiTextFieldSetting(placeholder: "ninnsyouko-do".localized())
        
        errorViewBottom.constant = -60
        
        nextButton.setTitle("tugihe".localized(), for: .normal)
        
        let attributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 12.0)]
        haveAccountButton.setTitleTextAttributes(attributes, for: UIControl.State.normal)
        haveAccountButton.title = "akaunntowoomotinokata".localized()
    }

    @IBAction func confirmationCodeRequestButtonTouchDown(_ sender: Any) {
        confirmationCodeRequestButton.backgroundColor = UIColor(named: "BlueHalf")
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
        haveAccountButton.isEnabled = false
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
            nextButton.backgroundColor = UIColor(named: "Blue")
        } else {
            nextButton.isEnabled = false
            nextButton.setTitleColor(UIColor(named: "EnabledButtonText"), for: .normal)
            nextButton.backgroundColor = UIColor(named: "EnabledButton")
        }
    }

    @IBAction func ConfirmationCodeTextFieldEditingDidBegin(_ sender: Any) {
        confirmationCodeTextField.layer.borderColor = UIColor.systemBlue.cgColor
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
            let storyBoard = UIStoryboard(name: "SignUpPassword", bundle: nil)
            let nextVC = storyBoard.instantiateInitialViewController()
            let vc = (nextVC as? SignUpPasswordViewController)
            
            // 値の設定
            vc!.name1 = name1
            vc!.name2 = name2
            vc!.mailaddress = mailaddress
            
            navigationController?.pushViewController(nextVC!, animated: true)
            // 認証コードが正しくない時
        } else {
            confirmationCodeTextField.layer.borderColor = UIColor.systemPink.cgColor
            errorLabel.text = "ninnsyouko-doera-".localized()
            errorView.errorViewTransition(value: 163)
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
                self.confirmationCodeRequestButton.setTitleColor(UIColor(named: "Blue"), for: .normal)
                self.confirmationCodeTextField.isEnabled = true
                self.nextButton.isEnabled = true
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
    
    @IBAction func haveAccountButton(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        dismiss(animated: true, completion: nil)
    }
}
