//
//  BioEditViewController.swift
//  Actbind
//
//  Created by 柿本海斗 on 2021/03/02.
//

import AudioToolbox
import UIKit
import UITextView_Placeholder

final class BioEditViewController: UIViewController, UITextViewDelegate, UIGestureRecognizerDelegate {
    let userDefaults = UserDefaults(suiteName: "group.com.actbind")
    let api = KeyManager().getValue(key: "API") as? String

    @IBOutlet weak var navigationBarTitle: UINavigationItem!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var bioTitleLabel: UILabel!
    @IBOutlet weak var bioTextView: UITextView!
    @IBOutlet weak var textCountLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var saveButtonRight: NSLayoutConstraint!
    @IBOutlet weak var saveButtonLeft: NSLayoutConstraint!
    @IBOutlet weak var activityView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var checkmarkImage: UIImageView!
    @IBOutlet weak var activityLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
        bioTextView.delegate = self

        navigationBarTitle.title = "jikosyoukaiwohennsyuu".localized()

        if let userDefaults = userDefaults {
            let myColor = userDefaults.string(forKey: "mycolor")
            let bio = userDefaults.string(forKey: "bio")

            if myColor == "Original" {
                backButton.tintColor = UIColor(named: "BlackWhite")
                bioTextView.tintColor = UIColor(named: "Blue")
            } else {
                backButton.tintColor = UIColor(named: myColor!)
                bioTextView.tintColor = UIColor(named: myColor!)
            }

            if bio == "" {
                bioTextView.text = ""
            } else {
                bioTextView.text = bio
            }
            
            textCountLabel.text = String(bio!.count) + "/100"
        }

        backButton.image = UIImage(named: "back")

        bioTitleLabel.text = "jikosyoukai".localized()

        if let userDefaults = userDefaults {
            let bio = userDefaults.string(forKey: "bio")
            if bio == "" {
                bioTextView.placeholder = "jikosyoukaiwonyuuryoku".localized()
            } else {
                bioTextView.placeholder = ""
            }
        }
        bioTextView.placeholderColor = UIColor(named: "TextFieldText")
        bioTextView.textContainerInset = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
        bioTextView.sizeToFit()
        bioTextView.layer.borderColor = UIColor.lightGray.cgColor
        bioTextView.layer.borderWidth = 1.0

        saveButton.setTitle("hozonn".localized(), for: .normal)
        
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

    func textViewDidChange(_ textView: UITextView) {
        let bioText = bioTextView.text
        let bioCount = bioTextView.text.count
        textCountLabel.text = String(bioCount) + "/100"

        if let userDefaults = userDefaults {
            let myColor = userDefaults.string(forKey: "mycolor")
            let bio = userDefaults.string(forKey: "bio")

            if bioCount < 100 {
                textCountLabel.textColor = UIColor(named: "BlackWhite")
                if bioCount == 90 {
                    let generator = UINotificationFeedbackGenerator()
                    generator.notificationOccurred(.warning)
                }
                if bio == bioText {
                    saveButton.isEnabled = false
                    saveButton.setTitleColor(UIColor(named: "EnabledButtonText"), for: .normal)
                    saveButton.backgroundColor = UIColor(named: "EnabledButton")
                } else {
                    saveButton.isEnabled = true
                    saveButton.setTitleColor(UIColor(named: "White"), for: .normal)
                    if myColor == "Original" {
                        saveButton.backgroundColor = UIColor(named: "Blue")
                    } else {
                        saveButton.backgroundColor = UIColor(named: myColor!)
                    }
                }
            } else if bioCount == 100 {
                textCountLabel.textColor = UIColor.label
                let generator = UINotificationFeedbackGenerator()
                generator.notificationOccurred(.error)

                if bio == bioText {
                    saveButton.isEnabled = false
                    saveButton.setTitleColor(UIColor(named: "EnabledButtonText"), for: .normal)
                    saveButton.backgroundColor = UIColor(named: "EnabledButton")
                } else {
                    saveButton.isEnabled = true
                    saveButton.setTitleColor(UIColor(named: "White"), for: .normal)
                    if myColor == "Original" {
                        saveButton.backgroundColor = UIColor(named: "Blue")
                    } else {
                        saveButton.backgroundColor = UIColor(named: myColor!)
                    }
                }
            } else {
                textCountLabel.textColor = UIColor.systemPink
                saveButton.isEnabled = false
                saveButton.setTitleColor(UIColor(named: "EnabledButtonText"), for: .normal)
                saveButton.backgroundColor = UIColor(named: "EnabledButton")
            }
        }
    }

    @IBAction func saveButtonTouchDown(_ sender: Any) {
        UIButton().uiButtonTapOn(item: saveButton, itemRight: saveButtonRight, itemLeft: saveButtonLeft)
    }

    @IBAction func saveButtonTouchDragOutside(_ sender: Any) {
        UIButton().uiButtonTapOff(item: saveButton, itemRight: saveButtonRight, itemLeft: saveButtonLeft)
    }

    // キーボード以外をタップでキーボードが閉じる
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    @IBAction func saveButtonTouchUpInside(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        UIButton().uiButtonTapOff(item: saveButton, itemRight: saveButtonRight, itemLeft: saveButtonLeft)
        
        saveButton.isEnabled = false
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        backButton.isEnabled = false
        bioTextView.isEditable = false
        activityView.isHidden = false
        activityIndicator.startAnimating()
        
        // データ登録・更新
        if let userDefaults = userDefaults {
            let userId = userDefaults.integer(forKey: "userid")
            apiBio(userId: userId, value: bioTextView.text)
        }
    }

    @IBAction func backBottonAction(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        navigationController?.popViewController(animated: true)
    }
    
    func apiBio(userId: Int, value: String) {
        let url = URL(string: api! + "userchange")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST" // Postリクエストを送る(このコードがないとGetリクエストになる)
        request.addValue("application/json", forHTTPHeaderField: "content-type")
        // request.addValue("", forHTTPHeaderField: "authorization") //APIKey
        
        // 構造体を作成
        struct UserChange: Codable {
            let changeKey: String
            let userId: Int
            let bio: String
        }
        
        let encoder = JSONEncoder()
        
        let body = UserChange(changeKey: "bio", userId: userId, bio: value)
        
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
                        userDefaults.setValue(value, forKeyPath: "bio")
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
            
            self.navigationController?.popViewController(animated: true)
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
            
            self.navigationController?.popViewController(animated: true)
        }
    }
}
