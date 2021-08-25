//
//  DecorationViewController.swift
//  Actbind
//
//  Created by 柿本　海斗 on 2020/11/28.
//

import AudioToolbox
import UIKit

final class DecorationViewController: UIViewController, UIGestureRecognizerDelegate {
    let userDefaults = UserDefaults(suiteName: "group.com.actbind")
    let api = KeyManager().getValue(key: "API") as? String

    @IBOutlet weak var navigationBarTitle: UINavigationItem!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var selectColorLabel: UILabel!
    @IBOutlet weak var defaultButton: UIButton!
    @IBOutlet weak var defaultSpaceView: UIView!
    @IBOutlet weak var defaultBorderView: UIView!
    @IBOutlet weak var redButton: UIButton!
    @IBOutlet weak var redSpaceView: UIView!
    @IBOutlet weak var redBorderView: UIView!
    @IBOutlet weak var orangeButton: UIButton!
    @IBOutlet weak var orangeSpaceView: UIView!
    @IBOutlet weak var orangeBorderView: UIView!
    @IBOutlet weak var yellowButton: UIButton!
    @IBOutlet weak var yellowSpaceView: UIView!
    @IBOutlet weak var yellowBorderView: UIView!
    @IBOutlet weak var greenButton: UIButton!
    @IBOutlet weak var greenSpaceView: UIView!
    @IBOutlet weak var greenBorderView: UIView!
    @IBOutlet weak var blueButton: UIButton!
    @IBOutlet weak var blueSpaceView: UIView!
    @IBOutlet weak var blueBorderView: UIView!
    @IBOutlet weak var purpleButton: UIButton!
    @IBOutlet weak var purpleSpaceView: UIView!
    @IBOutlet weak var purpleBorderView: UIView!
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var okButtonRight: NSLayoutConstraint!
    @IBOutlet weak var okButtonLeft: NSLayoutConstraint!
    @IBOutlet weak var activityView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var checkmarkImage: UIImageView!
    @IBOutlet weak var activityLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true

        navigationBarTitle.title = "dekore-syonn".localized()

        if let userDefaults = userDefaults {
            let myColor = userDefaults.string(forKey: "mycolor")

            if myColor == "Original" {
                backButton.tintColor = UIColor(named: "BlackWhite")
                okButton.backgroundColor = UIColor(named: "Blue")
            } else {
                backButton.tintColor = UIColor(named: myColor!)
                okButton.backgroundColor = UIColor(named: myColor!)
            }

            if myColor == "Original" {
                selectColorLabel.text = "orijinaru".localized()

                defaultBorderView.backgroundColor = UIColor(named: "Border")
                redBorderView.backgroundColor = UIColor.clear
                orangeBorderView.backgroundColor = UIColor.clear
                yellowBorderView.backgroundColor = UIColor.clear
                greenBorderView.backgroundColor = UIColor.clear
                blueBorderView.backgroundColor = UIColor.clear
                purpleBorderView.backgroundColor = UIColor.clear
            } else if myColor == "Red" {
                selectColorLabel.text = "red".localized()

                defaultBorderView.backgroundColor = UIColor.clear
                redBorderView.backgroundColor = UIColor(named: "Border")
                orangeBorderView.backgroundColor = UIColor.clear
                yellowBorderView.backgroundColor = UIColor.clear
                greenBorderView.backgroundColor = UIColor.clear
                blueBorderView.backgroundColor = UIColor.clear
                purpleBorderView.backgroundColor = UIColor.clear
            } else if myColor == "Orange" {
                selectColorLabel.text = "orange".localized()

                defaultBorderView.backgroundColor = UIColor.clear
                redBorderView.backgroundColor = UIColor.clear
                orangeBorderView.backgroundColor = UIColor(named: "Border")
                yellowBorderView.backgroundColor = UIColor.clear
                greenBorderView.backgroundColor = UIColor.clear
                blueBorderView.backgroundColor = UIColor.clear
                purpleBorderView.backgroundColor = UIColor.clear
            } else if myColor == "Yellow" {
                selectColorLabel.text = "yellow".localized()

                defaultBorderView.backgroundColor = UIColor.clear
                redBorderView.backgroundColor = UIColor.clear
                orangeBorderView.backgroundColor = UIColor.clear
                yellowBorderView.backgroundColor = UIColor(named: "Border")
                greenBorderView.backgroundColor = UIColor.clear
                blueBorderView.backgroundColor = UIColor.clear
                purpleBorderView.backgroundColor = UIColor.clear
            } else if myColor == "Green" {
                selectColorLabel.text = "green".localized()

                defaultBorderView.backgroundColor = UIColor.clear
                redBorderView.backgroundColor = UIColor.clear
                orangeBorderView.backgroundColor = UIColor.clear
                yellowBorderView.backgroundColor = UIColor.clear
                greenBorderView.backgroundColor = UIColor(named: "Border")
                blueBorderView.backgroundColor = UIColor.clear
                purpleBorderView.backgroundColor = UIColor.clear
            } else if myColor == "Blue" {
                selectColorLabel.text = "blue".localized()

                defaultBorderView.backgroundColor = UIColor.clear
                redBorderView.backgroundColor = UIColor.clear
                orangeBorderView.backgroundColor = UIColor.clear
                yellowBorderView.backgroundColor = UIColor.clear
                greenBorderView.backgroundColor = UIColor.clear
                blueBorderView.backgroundColor = UIColor(named: "Border")
                purpleBorderView.backgroundColor = UIColor.clear
            } else if myColor == "Purple" {
                selectColorLabel.text = "purple".localized()

                defaultBorderView.backgroundColor = UIColor.clear
                redBorderView.backgroundColor = UIColor.clear
                orangeBorderView.backgroundColor = UIColor.clear
                yellowBorderView.backgroundColor = UIColor.clear
                greenBorderView.backgroundColor = UIColor.clear
                blueBorderView.backgroundColor = UIColor.clear
                purpleBorderView.backgroundColor = UIColor(named: "Border")
            }
        }
        
        backButton.image = UIImage(named: "back")
        
        defaultButton.cornerAll(value: 0, fulcrum: "width")
        defaultSpaceView.cornerAll(value: 0, fulcrum: "width")
        defaultBorderView.cornerAll(value: 0, fulcrum: "width")
        
        redButton.cornerAll(value: 0, fulcrum: "width")
        redSpaceView.cornerAll(value: 0, fulcrum: "width")
        redBorderView.cornerAll(value: 0, fulcrum: "width")
        
        orangeButton.cornerAll(value: 0, fulcrum: "width")
        orangeSpaceView.cornerAll(value: 0, fulcrum: "width")
        orangeBorderView.cornerAll(value: 0, fulcrum: "width")
        
        yellowButton.cornerAll(value: 0, fulcrum: "width")
        yellowSpaceView.cornerAll(value: 0, fulcrum: "width")
        yellowBorderView.cornerAll(value: 0, fulcrum: "width")
        
        greenButton.cornerAll(value: 0, fulcrum: "width")
        greenSpaceView.cornerAll(value: 0, fulcrum: "width")
        greenBorderView.cornerAll(value: 0, fulcrum: "width")
        
        blueButton.cornerAll(value: 0, fulcrum: "width")
        blueSpaceView.cornerAll(value: 0, fulcrum: "width")
        blueBorderView.cornerAll(value: 0, fulcrum: "width")
        
        purpleButton.cornerAll(value: 0, fulcrum: "width")
        purpleSpaceView.cornerAll(value: 0, fulcrum: "width")
        purpleBorderView.cornerAll(value: 0, fulcrum: "width")
        
        okButton.setTitle("OK".localized(), for: .normal)

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
    
    @IBAction func defaultButton(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        backButton.tintColor = UIColor.label
        
        selectColorLabel.text = "orijinaru".localized()
        
        defaultBorderView.backgroundColor = UIColor(named: "Border")
        redBorderView.backgroundColor = UIColor.clear
        orangeBorderView.backgroundColor = UIColor.clear
        yellowBorderView.backgroundColor = UIColor.clear
        greenBorderView.backgroundColor = UIColor.clear
        blueBorderView.backgroundColor = UIColor.clear
        purpleBorderView.backgroundColor = UIColor.clear
        
        okButton.backgroundColor = UIColor(named: "Blue")
    }
    
    @IBAction func redButton(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        backButton.tintColor = UIColor(named: "Red")
        
        selectColorLabel.text = "red".localized()
        
        defaultBorderView.backgroundColor = UIColor.clear
        redBorderView.backgroundColor = UIColor(named: "Border")
        orangeBorderView.backgroundColor = UIColor.clear
        yellowBorderView.backgroundColor = UIColor.clear
        greenBorderView.backgroundColor = UIColor.clear
        blueBorderView.backgroundColor = UIColor.clear
        purpleBorderView.backgroundColor = UIColor.clear
        
        okButton.backgroundColor = UIColor(named: "Red")
    }
    
    @IBAction func orangeButton(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        backButton.tintColor = UIColor(named: "Orange")
        
        selectColorLabel.text = "orange".localized()
        
        defaultBorderView.backgroundColor = UIColor.clear
        redBorderView.backgroundColor = UIColor.clear
        orangeBorderView.backgroundColor = UIColor(named: "Border")
        yellowBorderView.backgroundColor = UIColor.clear
        greenBorderView.backgroundColor = UIColor.clear
        blueBorderView.backgroundColor = UIColor.clear
        purpleBorderView.backgroundColor = UIColor.clear
        
        okButton.backgroundColor = UIColor(named: "Orange")
    }
    
    @IBAction func yellowButton(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        backButton.tintColor = UIColor(named: "Yellow")
        
        selectColorLabel.text = "yellow".localized()
        
        defaultBorderView.backgroundColor = UIColor.clear
        redBorderView.backgroundColor = UIColor.clear
        orangeBorderView.backgroundColor = UIColor.clear
        yellowBorderView.backgroundColor = UIColor(named: "Border")
        greenBorderView.backgroundColor = UIColor.clear
        blueBorderView.backgroundColor = UIColor.clear
        purpleBorderView.backgroundColor = UIColor.clear
        
        okButton.backgroundColor = UIColor(named: "Yellow")
    }
    
    @IBAction func greenButton(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        backButton.tintColor = UIColor(named: "Green")
        
        selectColorLabel.text = "green".localized()
        
        defaultBorderView.backgroundColor = UIColor.clear
        redBorderView.backgroundColor = UIColor.clear
        orangeBorderView.backgroundColor = UIColor.clear
        yellowBorderView.backgroundColor = UIColor.clear
        greenBorderView.backgroundColor = UIColor(named: "Border")
        blueBorderView.backgroundColor = UIColor.clear
        purpleBorderView.backgroundColor = UIColor.clear
        
        okButton.backgroundColor = UIColor(named: "Green")
    }
    
    @IBAction func blueButton(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        backButton.tintColor = UIColor(named: "Blue")
        
        selectColorLabel.text = "blue".localized()
        
        defaultBorderView.backgroundColor = UIColor.clear
        redBorderView.backgroundColor = UIColor.clear
        orangeBorderView.backgroundColor = UIColor.clear
        yellowBorderView.backgroundColor = UIColor.clear
        greenBorderView.backgroundColor = UIColor.clear
        blueBorderView.backgroundColor = UIColor(named: "Border")
        purpleBorderView.backgroundColor = UIColor.clear
        
        okButton.backgroundColor = UIColor(named: "Blue")
    }
    
    @IBAction func purpleButton(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        backButton.tintColor = UIColor(named: "Purple")
        
        selectColorLabel.text = "purple".localized()
        
        defaultBorderView.backgroundColor = UIColor.clear
        redBorderView.backgroundColor = UIColor.clear
        orangeBorderView.backgroundColor = UIColor.clear
        yellowBorderView.backgroundColor = UIColor.clear
        greenBorderView.backgroundColor = UIColor.clear
        blueBorderView.backgroundColor = UIColor.clear
        purpleBorderView.backgroundColor = UIColor(named: "Border")
        
        okButton.backgroundColor = UIColor(named: "Purple")
    }
    
    @IBAction func okButtonTouchDown(_ sender: Any) {
        UIButton().uiButtonTapOn(item: okButton, itemRight: okButtonRight, itemLeft: okButtonLeft)
    }
    
    @IBAction func okButtonTouchDragOutside(_ sender: Any) {
        UIButton().uiButtonTapOff(item: okButton, itemRight: okButtonRight, itemLeft: okButtonLeft)
    }
    
    @IBAction func okButtonTouchUpInside(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        UIButton().uiButtonTapOff(item: okButton, itemRight: okButtonRight, itemLeft: okButtonLeft)

        okButton.isEnabled = false
        defaultButton.isEnabled = false
        redButton.isEnabled = false
        orangeButton.isEnabled = false
        yellowButton.isEnabled = false
        greenButton.isEnabled = false
        blueButton.isEnabled = false
        purpleButton.isEnabled = false
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        backButton.isEnabled = false

        if let userDefaults = userDefaults {
            let userId = userDefaults.integer(forKey: "userid")
            let myColor = userDefaults.string(forKey: "mycolor")
        
            if selectColorLabel.text == "orijinaru".localized() {
                if myColor == "Original" {
                    navigationController?.popViewController(animated: true)
                } else {
                    activityView.isHidden = false
                    activityIndicator.startAnimating()
                    
                    apiMyColor(userId: userId, value: "Original")
                }
            } else if selectColorLabel.text == "red".localized() {
                if myColor == "Red" {
                    navigationController?.popViewController(animated: true)
                } else {
                    activityView.isHidden = false
                    activityIndicator.startAnimating()

                    apiMyColor(userId: userId, value: "Red")
                }
            } else if selectColorLabel.text == "orange".localized() {
                if myColor == "Orange" {
                    navigationController?.popViewController(animated: true)
                } else {
                    activityView.isHidden = false
                    activityIndicator.startAnimating()

                    apiMyColor(userId: userId, value: "Orange")
                }
            } else if selectColorLabel.text == "yellow".localized() {
                if myColor == "Yellow" {
                    navigationController?.popViewController(animated: true)
                } else {
                    activityView.isHidden = false
                    activityIndicator.startAnimating()

                    apiMyColor(userId: userId, value: "Yellow")
                }
            } else if selectColorLabel.text == "green".localized() {
                if myColor == "Green" {
                    navigationController?.popViewController(animated: true)
                } else {
                    activityView.isHidden = false
                    activityIndicator.startAnimating()

                    apiMyColor(userId: userId, value: "Green")
                }
            } else if selectColorLabel.text == "blue".localized() {
                if myColor == "Blue" {
                    navigationController?.popViewController(animated: true)
                } else {
                    activityView.isHidden = false
                    activityIndicator.startAnimating()

                    apiMyColor(userId: userId, value: "Blue")
                }
            } else {
                if myColor == "Purple" {
                    navigationController?.popViewController(animated: true)
                } else {
                    activityView.isHidden = false
                    activityIndicator.startAnimating()

                    apiMyColor(userId: userId, value: "Purple")
                }
            }
        }
    }
    
    @IBAction func backBottonAction(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        navigationController?.popViewController(animated: true)
    }
    
    func apiMyColor(userId: Int, value: String) {
        let url = URL(string: api! + "userchange")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST" // Postリクエストを送る(このコードがないとGetリクエストになる)
        request.addValue("application/json", forHTTPHeaderField: "content-type")
        // request.addValue("", forHTTPHeaderField: "authorization") //APIKey
        
        // 構造体を作成
        struct UserChange: Codable {
            let changeKey: String
            let userId: Int
            let myColor: String
        }
        
        let encoder = JSONEncoder()
        
        let body = UserChange(changeKey: "mycolor", userId: userId, myColor: value)
        
        print(value)
        
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
                        userDefaults.setValue(value, forKeyPath: "mycolor")

                        self.apiSuccess()
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
    
    func apiSuccess() {
        activityIndicator.stopAnimating()
        checkmarkImage.image = UIImage(named: "success")
        activityLabel.text = "hennkounaiyouhozonn".localized()
        
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.checkmarkImage.image = UIImage(named: "")
            self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
            
            let storyBoard = UIStoryboard(name: "RebootToMain", bundle: nil)
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
            
            self.navigationController?.popViewController(animated: true)
        }
    }
}
