//
//  DeleteYourAccountViewController.swift
//  Actbind
//
//  Created by 柿本　海斗 on 2020/12/02.
//

import AudioToolbox
import UIKit

final class DeleteAccountViewController: UIViewController, UIGestureRecognizerDelegate {
    let userDefaults = UserDefaults(suiteName: "group.com.actbind")
    let api = KeyManager().getValue(key: "API") as? String
    
    @IBOutlet weak var navigationBarTitle: UINavigationItem!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var arigatouLabel: UILabel!
    @IBOutlet weak var tanosimiLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var deleteButtonRight: NSLayoutConstraint!
    @IBOutlet weak var deleteButtonLeft: NSLayoutConstraint!
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

        navigationBarTitle.title = "akaunntosakujyo".localized()

        if let userDefaults = userDefaults {
            let myColor = userDefaults.string(forKey: "mycolor")

            if myColor == "Original" {
                backButton.tintColor = UIColor(named: "BlackWhite")
                cancelButton.backgroundColor = UIColor(named: "Blue")
            } else {
                backButton.tintColor = UIColor(named: myColor!)
                cancelButton.backgroundColor = UIColor(named: myColor!)
            }
        }

        backButton.image = UIImage(named: "back")
        
        arigatouLabel.text = "arigatou".localized()
        
        tanosimiLabel.text = "tanosimi".localized()
        
        deleteButton.setTitle("sakujyo".localized(), for: .normal)
        deleteButton.setTitleColor(UIColor(named: "Red"), for: .normal)
        
        cancelButton.setTitle("kyannseru".localized(), for: .normal)
        
        activityView.cornerAll(value: 16, fulcrum: "")
        activityView.isHidden = true
        
        checkmarkImage.image = UIImage(named: "")
        activityLabel.text = "akaunntowosakujyotyuu".localized()
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

    @IBAction func deleteButtonTouchDown(_ sender: Any) {
        deleteButtonRight.constant = 25
        deleteButtonLeft.constant = 25
    }

    @IBAction func deleteButtonTouchDragOutside(_ sender: Any) {
        deleteButtonRight.constant = 20
        deleteButtonLeft.constant = 20
    }

    @IBAction func deleteButtonTouchUpInside(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        deleteButtonRight.constant = 20
        deleteButtonLeft.constant = 20

        deleteButton.isEnabled = false
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        backButton.isEnabled = false
        cancelButton.isEnabled = false
        
        activityView.isHidden = false
        activityIndicator.startAnimating()
        
        if let userDefaults = userDefaults {
            let userId = userDefaults.integer(forKey: "userid")
            let userName = userDefaults.string(forKey: "username")!
            
            let key = userName + "/"
            print(key)
            apiDeleteUser(userId: userId, key: key)
        }
    }
    
    @IBAction func cancelButtonTouchDown(_ sender: Any) {
        UIButton().uiButtonTapOn(item: cancelButton, itemRight: cancelButtonRight, itemLeft: cancelButtonLeft)
    }
    
    @IBAction func cancelButtonTouchDragOutside(_ sender: Any) {
        UIButton().uiButtonTapOff(item: cancelButton, itemRight: cancelButtonRight, itemLeft: cancelButtonLeft)
    }
    
    @IBAction func cancelButtonTouchUpInside(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        UIButton().uiButtonTapOff(item: cancelButton, itemRight: cancelButtonRight, itemLeft: cancelButtonLeft)
        
        // 2つ前のViewControllerに戻る
        let index = navigationController!.viewControllers.count - 3
        navigationController?.popToViewController(navigationController!.viewControllers[index], animated: true)
    }
    
    @IBAction func backBottonAction(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        navigationController?.popViewController(animated: true)
    }
    
    func apiDeleteUser(userId: Int, key: String) {
        let url = URL(string: api! + "user")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST" // Postリクエストを送る(このコードがないとGetリクエストになる)
        request.addValue("application/json", forHTTPHeaderField: "content-type")
        // request.addValue("", forHTTPHeaderField: "authorization") //APIKey
        
        // 構造体を作成
        struct User: Codable {
            let OperationType: String
            let userId: Int
            let key: String
        }
        
        let encoder = JSONEncoder()
        
        let body = User(OperationType: "DELETE", userId: userId, key: key)
        
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
                        userDefaults.userDefaultsRemoveAll()
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
            
            let storyBoard = UIStoryboard(name: "RebootToLogin", bundle: nil)
            let nextVC = storyBoard.instantiateInitialViewController()
            self.present(nextVC!, animated: true) {}
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
