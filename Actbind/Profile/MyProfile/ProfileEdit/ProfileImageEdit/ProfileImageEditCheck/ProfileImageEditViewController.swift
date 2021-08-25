//
//  ProfileImageEditViewController.swift
//  Actbind
//
//  Created by 柿本海斗 on 2021/03/02.
//

import AudioToolbox
import UIKit

final class ProfileImageEditViewController: UIViewController, UIGestureRecognizerDelegate {
    let userDefaults = UserDefaults(suiteName: "group.com.actbind")
    let api = KeyManager().getValue(key: "API") as? String

    // 撮影画面で撮影した画像
    var profileimage: UIImage?
    var section = 0
    
    @IBOutlet weak var navigationBarTitle: UINavigationItem!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var activityView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var checkmarkImage: UIImageView!
    @IBOutlet weak var activityLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
        navigationBarTitle.title = "purofi-rusyasinn".localized()

        if let userDefaults = userDefaults {
            let myColor = userDefaults.string(forKey: "mycolor")

            if myColor == "Original" {
                backButton.tintColor = UIColor(named: "BlackWhite")
                saveButton.tintColor = UIColor(named: "Blue")
            } else {
                backButton.tintColor = UIColor(named: myColor!)
                saveButton.tintColor = UIColor(named: myColor!)
            }
        }
        
        backButton.image = UIImage(named: "back")
        
        let attributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18.0)]
        saveButton.setTitleTextAttributes(attributes, for: .normal)
        saveButton.title = "hozonn".localized()
        
        profileImage.image = profileimage
        profileImage.cornerAll(value: 0, fulcrum: "width")
        
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
    
    @IBAction func saveButton(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        saveButton.isEnabled = false
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        backButton.isEnabled = false
        
        activityView.isHidden = false
        activityIndicator.startAnimating()
        
        let profileImage = profileimage!.jpegData(compressionQuality: 1)
        let base64String = profileImage!.base64EncodedString(options: .lineLength64Characters)
        
        let now = Date()
        let s3Date = now.dateToString(format: "yyyyMMddHHmmss")
        if let userDefaults = userDefaults {
            let userId = userDefaults.integer(forKey: "userid")
            let userName = userDefaults.string(forKey: "username")
            apiProfileImage(userId: userId, userName: userName!, value: base64String, date: s3Date)
        }
    }

    @IBAction func backBottonAction(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        navigationController?.popViewController(animated: true)
    }
    
    func apiProfileImage(userId: Int, userName: String, value: String, date: String) {
        let url = URL(string: api! + "userchange")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST" // Postリクエストを送る(このコードがないとGetリクエストになる)
        request.addValue("application/json", forHTTPHeaderField: "content-type")
        // request.addValue("", forHTTPHeaderField: "authorization") //APIKey
        
        // 構造体を作成
        struct UserChange: Codable {
            let changeKey: String
            let userId: Int
            let userName: String
            let profileImage: String
            let s3Date: String
        }
        
        let encoder = JSONEncoder()
        
        let body = UserChange(changeKey: "profileImage", userId: userId, userName: userName, profileImage: value, s3Date: date)
        
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
                        userDefaults.setValue(date + ".jpg", forKeyPath: "profileimage")
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
            
            if self.section == 0 {
                self.dismiss(animated: true, completion: nil)
            } else if self.section == 1 {
                self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
            } else {
                self.presentingViewController?.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
            }
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
            
            if self.section == 0 {
                self.dismiss(animated: true, completion: nil)
            } else if self.section == 1 {
                self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
            } else {
                self.presentingViewController?.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
            }
        }
    }
}
