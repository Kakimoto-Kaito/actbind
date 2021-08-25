//
//  FeedbackViewController.swift
//  Actbind
//
//  Created by 柿本海斗 on 2021/06/13.
//

import UIKit
import UITextView_Placeholder

final class FeedbackViewController: UIViewController, UITextViewDelegate {
    let userDefaults = UserDefaults(suiteName: "group.com.actbind")
    let api = KeyManager().getValue(key: "API") as? String

    @IBOutlet weak var navigationBarTitle: UINavigationItem!
    @IBOutlet weak var rate1Button: UIButton!
    @IBOutlet weak var rate2Button: UIButton!
    @IBOutlet weak var rate3Button: UIButton!
    @IBOutlet weak var rate4Button: UIButton!
    @IBOutlet weak var rate5Button: UIButton!
    @IBOutlet weak var rateExplanationLabel: UILabel!
    @IBOutlet weak var feedbackTextView: UITextView!
    @IBOutlet weak var sendButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    var rateNumber = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        feedbackTextView.delegate = self
        
        navigationBarTitle.title = "fi-dobakku".localized()

        if let userDefaults = userDefaults {
            let myColor = userDefaults.string(forKey: "mycolor")

            if myColor == "Original" {
                sendButton.tintColor = UIColor(named: "Blue")
                cancelButton.tintColor = UIColor(named: "BlackWhite")
                feedbackTextView.tintColor = UIColor(named: "Blue")
            } else {
                sendButton.tintColor = UIColor(named: myColor!)
                cancelButton.tintColor = UIColor(named: myColor!)
                feedbackTextView.tintColor = UIColor(named: myColor!)
            }
        }
        
        rate1Button.cornerAll(value: 0, fulcrum: "width")
        rate1Button.backgroundColor = UIColor.clear
        rate1Button.layer.borderColor = UIColor.lightGray.cgColor
        rate1Button.layer.borderWidth = 4.0
        
        rate2Button.cornerAll(value: 0, fulcrum: "width")
        rate2Button.backgroundColor = UIColor.clear
        rate2Button.layer.borderColor = UIColor.lightGray.cgColor
        rate2Button.layer.borderWidth = 4.0
        
        rate3Button.cornerAll(value: 0, fulcrum: "width")
        rate3Button.backgroundColor = UIColor.clear
        rate3Button.layer.borderColor = UIColor.lightGray.cgColor
        rate3Button.layer.borderWidth = 4.0
        
        rate4Button.cornerAll(value: 0, fulcrum: "width")
        rate4Button.backgroundColor = UIColor.clear
        rate4Button.layer.borderColor = UIColor.lightGray.cgColor
        rate4Button.layer.borderWidth = 4.0
        
        rate5Button.cornerAll(value: 0, fulcrum: "width")
        rate5Button.backgroundColor = UIColor.clear
        rate5Button.layer.borderColor = UIColor.lightGray.cgColor
        rate5Button.layer.borderWidth = 4.0
        
        rateExplanationLabel.text = "houkokusetumei3".localized()
        
        feedbackTextView.becomeFirstResponder()
        feedbackTextView.text = ""
        feedbackTextView.placeholder = "houkokusetumei4".localized()
        feedbackTextView.placeholderColor = UIColor(named: "TextFieldText")
        feedbackTextView.textContainerInset = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
        feedbackTextView.sizeToFit()
        feedbackTextView.layer.borderColor = UIColor.lightGray.cgColor
        feedbackTextView.layer.borderWidth = 1.0
        
        let attributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18.0)]
        sendButton.setTitleTextAttributes(attributes, for: .normal)
        sendButton.title = "sousinn".localized()
        sendButton.isEnabled = false
        
        cancelButton.image = UIImage(named: "cancel")
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
    
    @IBAction func rate1ButtonTouchUpInside(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        rateNumber = 1
        
        if let userDefaults = userDefaults {
            let myColor = userDefaults.string(forKey: "mycolor")

            if myColor == "Original" {
                rate1Button.backgroundColor = UIColor(named: "Blue")
            } else {
                rate1Button.backgroundColor = UIColor(named: myColor!)
            }
        }
        rate2Button.backgroundColor = UIColor.clear
        rate3Button.backgroundColor = UIColor.clear
        rate4Button.backgroundColor = UIColor.clear
        rate5Button.backgroundColor = UIColor.clear
        
        if feedbackTextView.text == "" {
            sendButton.isEnabled = false
        } else {
            sendButton.isEnabled = true
        }
    }
    
    @IBAction func rate2ButtonTouchUpInside(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        rateNumber = 2
        
        if let userDefaults = userDefaults {
            let myColor = userDefaults.string(forKey: "mycolor")

            if myColor == "Original" {
                rate1Button.backgroundColor = UIColor(named: "Blue")
                rate2Button.backgroundColor = UIColor(named: "Blue")
            } else {
                rate1Button.backgroundColor = UIColor(named: myColor!)
                rate2Button.backgroundColor = UIColor(named: myColor!)
            }
        }
        rate3Button.backgroundColor = UIColor.clear
        rate4Button.backgroundColor = UIColor.clear
        rate5Button.backgroundColor = UIColor.clear
        
        if feedbackTextView.text == "" {
            sendButton.isEnabled = false
        } else {
            sendButton.isEnabled = true
        }
    }
    
    @IBAction func rate3ButtonTouchUpInside(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        rateNumber = 3
        
        if let userDefaults = userDefaults {
            let myColor = userDefaults.string(forKey: "mycolor")

            if myColor == "Original" {
                rate1Button.backgroundColor = UIColor(named: "Blue")
                rate2Button.backgroundColor = UIColor(named: "Blue")
                rate3Button.backgroundColor = UIColor(named: "Blue")
            } else {
                rate1Button.backgroundColor = UIColor(named: myColor!)
                rate2Button.backgroundColor = UIColor(named: myColor!)
                rate3Button.backgroundColor = UIColor(named: myColor!)
            }
        }
        rate4Button.backgroundColor = UIColor.clear
        rate5Button.backgroundColor = UIColor.clear
        
        if feedbackTextView.text == "" {
            sendButton.isEnabled = false
        } else {
            sendButton.isEnabled = true
        }
    }
    
    @IBAction func rate4ButtonTouchUpInside(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        rateNumber = 4
        
        if let userDefaults = userDefaults {
            let myColor = userDefaults.string(forKey: "mycolor")

            if myColor == "Original" {
                rate1Button.backgroundColor = UIColor(named: "Blue")
                rate2Button.backgroundColor = UIColor(named: "Blue")
                rate3Button.backgroundColor = UIColor(named: "Blue")
                rate4Button.backgroundColor = UIColor(named: "Blue")
            } else {
                rate1Button.backgroundColor = UIColor(named: myColor!)
                rate2Button.backgroundColor = UIColor(named: myColor!)
                rate3Button.backgroundColor = UIColor(named: myColor!)
                rate4Button.backgroundColor = UIColor(named: myColor!)
            }
        }
        rate5Button.backgroundColor = UIColor.clear
        
        if feedbackTextView.text == "" {
            sendButton.isEnabled = false
        } else {
            sendButton.isEnabled = true
        }
    }
    
    @IBAction func rate5ButtonTouchUpInside(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        rateNumber = 5
        
        if let userDefaults = userDefaults {
            let myColor = userDefaults.string(forKey: "mycolor")
            
            if myColor == "Original" {
                rate1Button.backgroundColor = UIColor(named: "Blue")
                rate2Button.backgroundColor = UIColor(named: "Blue")
                rate3Button.backgroundColor = UIColor(named: "Blue")
                rate4Button.backgroundColor = UIColor(named: "Blue")
                rate5Button.backgroundColor = UIColor(named: "Blue")
            } else {
                rate1Button.backgroundColor = UIColor(named: myColor!)
                rate2Button.backgroundColor = UIColor(named: myColor!)
                rate3Button.backgroundColor = UIColor(named: myColor!)
                rate4Button.backgroundColor = UIColor(named: myColor!)
                rate5Button.backgroundColor = UIColor(named: myColor!)
            }
        }
        
        if feedbackTextView.text == "" {
            sendButton.isEnabled = false
        } else {
            sendButton.isEnabled = true
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if feedbackTextView.text == "" {
            sendButton.isEnabled = false
        } else {
            if rateNumber != 0 {
                sendButton.isEnabled = true
            }
        }
    }

    @IBAction func sendButtonAction(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        apiPostTheFeedback()
        dialog()
    }
    
    func apiPostTheFeedback() {
        let url = URL(string: api! + "feedback")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST" // Postリクエストを送る(このコードがないとGetリクエストになる)
        request.addValue("application/json", forHTTPHeaderField: "content-type")
        // request.addValue("", forHTTPHeaderField: "authorization") //APIKey
        
        // 構造体を作成
        struct Post: Codable {
            let rate: Int
            let text: String
        }
        
        let encoder = JSONEncoder()
        
        let body = Post(rate: rateNumber, text: feedbackTextView.text)
        
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
                }
            }
        }
        task.resume()
    }
    
    func dialog() {
        let alertTitle = "houkokuara-totaitoru".localized()
        let messageTitle = "houkokuara-tomesse-ji2".localized()
        let closeTitle = "tojiru".localized()

        let alertController = UIAlertController(title: alertTitle, message: messageTitle, preferredStyle: .alert)

        let closeButton = UIAlertAction(title: closeTitle, style: .default, handler: { _ in
            self.dismiss(animated: true, completion: nil)
        })

        alertController.view.tintColor = UIColor(named: "BlackWhite")
        alertController.addAction(closeButton)

        present(alertController, animated: true, completion: nil)
    }

    @IBAction func backBottonAction(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        dismiss(animated: true, completion: nil)
    }
}
