//
//  PostViewController.swift
//  Actbind
//
//  Created by 柿本海斗 on 2021/03/02.
//

import AudioToolbox
import Nuke
import UIKit
import UITextView_Placeholder

final class PostViewController: UIViewController, UIGestureRecognizerDelegate {
    let userDefaults = UserDefaults(suiteName: "group.com.actbind")
    let api = KeyManager().getValue(key: "API") as? String
    
    var delegate: HomeViewController?
    
    var postcolor = ""
    var postimage: UIImage?
    var section = 0

    @IBOutlet weak var navigationBarTitle: UINavigationItem!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var postButton: UIBarButtonItem!
    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var postColor: UIView!
    @IBOutlet weak var caption: UITextView!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var postDate: UILabel!
    @IBOutlet weak var activityView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var checkmarkImage: UIImageView!
    @IBOutlet weak var activityLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
        navigationBarTitle.title = "toukouwosakusei".localized()

        if let userDefaults = userDefaults {
            let userName = userDefaults.string(forKey: "username")!
            let myColor = userDefaults.string(forKey: "mycolor")
            let name1 = userDefaults.string(forKey: "name1")
            let name2 = userDefaults.string(forKey: "name2")
            let profileimage = userDefaults.string(forKey: "profileimage")

            if myColor == "Original" {
                backButton.tintColor = UIColor(named: "BlackWhite")
                postButton.tintColor = UIColor(named: "Blue")
                caption.tintColor = UIColor(named: "Blue")
            } else {
                backButton.tintColor = UIColor(named: myColor!)
                postButton.tintColor = UIColor(named: myColor!)
                caption.tintColor = UIColor(named: myColor!)
            }
            
            if profileimage == "Default" {
                userProfileImage.image = UIImage(named: "defaultProfileImage")
            } else {
                let profileImageUrlString = "https://www.actbind.com/" + userName + "/profile-image/" + profileimage!
                let userProfileImageURL = URL(string: profileImageUrlString)!
                Nuke.loadImage(with: userProfileImageURL, into: userProfileImage)
            }
            userProfileImage.cornerAll(value: 0, fulcrum: "width")

            nameLabel.text = name1! + " " + name2!
        }
        
        backButton.image = UIImage(named: "back")
        
        let attributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18.0)]
        postButton.setTitleTextAttributes(attributes, for: .normal)
        postButton.title = "syea".localized()
        
        postColor.backgroundColor = UIColor(named: postcolor)
        postColor.cornerAll(value: 0, fulcrum: "height")
        
        caption.placeholder = "kyapusyonnwonyuuryoku".localized()
        caption.placeholderColor = UIColor(named: "TextFieldText")
        caption.textContainerInset = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
        caption.sizeToFit()
        caption.layer.borderColor = UIColor.lightGray.cgColor
        caption.layer.borderWidth = 1.0
        
        postImage.image = postimage
        postImage.cornerAll(value: 16, fulcrum: "")
        
        postDate.text = "jikann".localized()
        
        activityView.cornerAll(value: 16, fulcrum: "")
        activityView.isHidden = true
        
        checkmarkImage.image = UIImage(named: "")
        activityLabel.text = "toukoutyuu".localized()
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
    
    @IBAction func postButtonAction(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        postButton.isEnabled = false
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        backButton.isEnabled = false
        caption.isEditable = false
        activityView.isHidden = false
        activityIndicator.startAnimating()
        
        if let userDefaults = userDefaults {
            let userId = userDefaults.integer(forKey: "userid")
            let userName = userDefaults.string(forKey: "username")
            apiPostThePostData(userId: userId, userName: userName!)
        }
    }
    
    func apiPostThePostData(userId: Int, userName: String) {
        let url = URL(string: api! + "post")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST" // Postリクエストを送る(このコードがないとGetリクエストになる)
        request.addValue("application/json", forHTTPHeaderField: "content-type")
        // request.addValue("", forHTTPHeaderField: "authorization") //APIKey
        
        // 構造体を作成
        struct Post: Codable {
            let OperationType: String
            let userId: Int
            let userName: String
            let color: String
            let image: String
            let caption: String
            let createDate: String
            let s3Date: String
        }
        
        let encoder = JSONEncoder()
        
        let imageData = postimage!.jpegData(compressionQuality: 1)
        let base64String = imageData!.base64EncodedString(options: .lineLength64Characters)
        
        let now = Date()
        let createDate = now.dateToString(format: "yyyy-MM-dd HH:mm:ss")
        let s3Date = now.dateToString(format: "yyyyMMddHHmmss")
        
        let body = Post(OperationType: "PUT", userId: userId, userName: userName, color: postcolor, image: base64String, caption: caption.text, createDate: createDate, s3Date: s3Date)
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
                
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                if let allPosts = try? decoder.decode([HomeViewController.Posts].self, from: data) {
                    DispatchQueue.main.async {
                        HomeViewController.allPosts = allPosts
                        print(allPosts)
                        print(allPosts.count)
                        
                        self.apiUser()
                    }
                    
                } else {
                    print("Unable parse JSON response")
                }
            } else {
                DispatchQueue.main.async {
                    // レスポンスのステータスコードが200でない場合などはサーバサイドエラー
                    print("サーバエラー ステータスコード: \(response.statusCode)")
                }
            }
        }
        task.resume()
    }
    
    func apiUser() {
        let url = URL(string: api! + "user")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST" // Postリクエストを送る(このコードがないとGetリクエストになる)
        request.addValue("application/json", forHTTPHeaderField: "content-type")
        // request.addValue("", forHTTPHeaderField: "authorization") //APIKey
        
        // 構造体を作成
        struct User: Codable {
            let OperationType: String
        }
        
        let encoder = JSONEncoder()
        
        let body = User(OperationType: "SCAN")
        
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
                
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                if let allUsers = try? decoder.decode([HomeViewController.Users].self, from: data) {
                    DispatchQueue.main.async {
                        HomeViewController.allUsers = allUsers
                        print(allUsers)
                        print(allUsers.count)
                        
                        scrollSwitch = "on"
                        toHomeView = "on"
                        
                        self.apiSuccess()
                    }
                    
                } else {
                    print("Unable parse JSON response")
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
        activityLabel.text = "toukousimasita".localized()
        
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.checkmarkImage.image = UIImage(named: "")
            self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
            
            if self.section == 0 {
                self.dismiss(animated: true, completion: nil)
            } else {
                self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
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
            } else {
                self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func backBottonAction(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        navigationController?.popViewController(animated: true)
    }
}
