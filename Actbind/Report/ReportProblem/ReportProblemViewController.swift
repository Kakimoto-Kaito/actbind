//
//  ReportProblemViewController.swift
//  Actbind
//
//  Created by 柿本海斗 on 2021/06/13.
//

import UIKit
import UITextView_Placeholder

final class ReportProblemViewController: UIViewController, UITextViewDelegate {
    let userDefaults = UserDefaults(suiteName: "group.com.actbind")
    let api = KeyManager().getValue(key: "API") as? String

    @IBOutlet weak var navigationBarTitle: UINavigationItem!
    
    @IBOutlet weak var reportTextView: UITextView!
    
    @IBOutlet weak var sendButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        reportTextView.delegate = self
        
        navigationBarTitle.title = "monndaiwohoukoku".localized()

        if let userDefaults = userDefaults {
            let myColor = userDefaults.string(forKey: "mycolor")

            if myColor == "Original" {
                sendButton.tintColor = UIColor(named: "Blue")
                cancelButton.tintColor = UIColor(named: "BlackWhite")
                reportTextView.tintColor = UIColor(named: "Blue")
            } else {
                sendButton.tintColor = UIColor(named: myColor!)
                cancelButton.tintColor = UIColor(named: myColor!)
                reportTextView.tintColor = UIColor(named: myColor!)
            }
        }
        
        reportTextView.becomeFirstResponder()
        reportTextView.text = ""
        reportTextView.placeholder = "houkokusetumei2".localized()
        reportTextView.placeholderColor = UIColor(named: "TextFieldText")
        reportTextView.textContainerInset = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
        reportTextView.sizeToFit()
        reportTextView.layer.borderColor = UIColor.lightGray.cgColor
        reportTextView.layer.borderWidth = 1.0
        
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
    
    func textViewDidChange(_ textView: UITextView) {
        if reportTextView.text == "" {
            sendButton.isEnabled = false
        } else {
            sendButton.isEnabled = true
        }
    }

    @IBAction func sendButtonAction(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        apiPostTheReportProblem()
        dialog()
    }
    
    func apiPostTheReportProblem() {
        let url = URL(string: api! + "reportproblem")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST" // Postリクエストを送る(このコードがないとGetリクエストになる)
        request.addValue("application/json", forHTTPHeaderField: "content-type")
        // request.addValue("", forHTTPHeaderField: "authorization") //APIKey
        
        // 構造体を作成
        struct Post: Codable {
            let text: String
            let appVersion: String
            let deviceName: String
            let osVersion: String
        }
        
        let encoder = JSONEncoder()
        
        let appVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
        let deviceName = UIDevice.current.modelName
        let osVersion = UIDevice.current.systemName + " " + UIDevice.current.systemVersion
        
        let body = Post(text: reportTextView.text, appVersion: appVersion, deviceName: deviceName, osVersion: osVersion)
        
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

let DeviceList = [
    /* -------------- iPod Touch -------------- */
    /* iPod Touch 7 */ "iPod9,1": "iPod Touch 7th Generation",
    
    /* -------------- iPhone -------------- */
    /* iPhone 6S */ "iPhone8,1": "iPhone 6S",
    /* iPhone 6S Plus */ "iPhone8,2": "iPhone 6S Plus",
    /* iPhone SE */ "iPhone8,4": "iPhone SE",
    /* iPhone 7 */ "iPhone9,1": "iPhone 7", "iPhone9,3": "iPhone 7",
    /* iPhone 7 Plus */ "iPhone9,2": "iPhone 7 Plus", "iPhone9,4": "iPhone 7 Plus",
    /* iPhone 8 */ "iPhone10,1": "iPhone 8", "iPhone10,4": "iPhone 8",
    /* iPhone 8 Plus */ "iPhone10,2": "iPhone 8 Plus", "iPhone10,5": "iPhone 8 Plus",
    /* iPhone X */ "iPhone10,3 ": "iPhone X", "iPhone10,6": "iPhone X",
    /* iPhone XR */ "iPhone11,8": "iPhone XR",
    /* iPhone XS */ "iPhone11,2": "iPhone XS",
    /* iPhone XS Max */ "iPhone11,4": "iPhone XS Max", "iPhone11,6": "iPhone XS Max",
    /* iPhone 11 */ "iPhone12,1": "iPhone 11",
    /* iPhone 11 Pro */ "iPhone12,3": "iPhone 11 Pro",
    /* iPhone 11 Pro Max */ "iPhone12,5": "iPhone 11 Pro Max",
    /* iPhone SE 2nd Generation */ "iPhone12,8": "iPhone SE 2nd Generation",
    /* iPhone 12 mini */ "iPhone13,1": "iPhone 12 mini",
    /* iPhone 12 */ "iPhone13,2": "iPhone 12",
    /* iPhone 12 Pro */ "iPhone13,3": "iPhone 12 Pro",
    /* iPhone 12 Pro Max */ "iPhone13,4": "iPhone 12 Pro Max",
    
    /* -------------- iPad -------------- */
    /* iPad Mini 4 */ "iPad5,1": "iPad mini 4 WiFi", "iPad5,2": "iPad mini 4 Cellular",
    /* iPad Air 2 */ "iPad5,3": "iPad Air 2 WiFi", "iPad5,4": "iPad Air 2 Cellular",
    /* iPad Pro (9.7) */ "iPad6,3": "iPad Pro (9.7)", "iPad6,4": "iPad Pro (9.7)",
    /* iPad Pro(12.9) */ "iPad6,7": "iPad Pro 12.9inch WiFi", "iPad6,8": "iPad Pro 12.9inch Cellular",
    /* iPad (5th) */ "iPad6,11": "iPad 5th Generation WiFi", "iPad6,12": "iPad 5th Generation Cellular",
    /* iPad Pro (12.9) 2nd Generation*/ "iPad7,1": "iPad Pro 12.9inch 2nd Generation WiFi", "iPad7,2": "iPad Pro 12.9inch 2nd Generation Cellular)",
    /* iPad Pro (10.5) */ "iPad7,3": "iPad Pro 10.5inch WiFi", "iPad7,4": "iPad Pro 10.5inch Cellular",
    /* iPad (6th) */ "iPad7,5": "iPad 6th Generation WiFi", "iPad7,6": "iPad 6th Generation Cellular",
    /* iPad (7th) */ "iPad7,11": "iPad 7th Generation WiFi", "iPad7,12": "iPad 7th Generation Cellular",
    /* iPad Pro (11) */ "iPad8,1": "iPad Pro 11inch WiFi", "iPad8,2": "iPad Pro 11inch WiFi", "iPad8,3": "iPad Pro 11inch Cellular", "iPad8,4": "iPad Pro 11inch Cellular",
    /* iPad Pro (12.9) 3rd Generation */ "iPad8,5": "iPad Pro 12.9inch 3rd Generation WiFi", "iPad8,6": "iPad Pro 12.9inch 3rd Generation WiFi", "iPad8,7": "iPad Pro 12.9inch 3rd Generation Cellular", "iPad8,8": "iPad Pro 12.9inch 3rd Generation Cellular",
    /* iPad Pro (11) 2nd Generation */ "iPad8,9": "iPad Pro 11inch 2nd Generation WiFi", "iPad8,10": "iPad Pro 11inch 2nd Generation Cellular",
    /* iPad Pro (12.9) 4th Generation */ "iPad8,11": "iPad Pro 12.9inch 4th Generation WiFi", "iPad8,12": "iPad Pro 12.9inch 4th Generation Cellular",
    /* iPad Mini 5th */ "iPad11,1": "iPad mini 5th Generation WiFi", "iPad11,2": "iPad mini 5th Generation Cellular",
    /* iPad Air 3 */ "iPad11,3": "iPad Air 3rd Generation WiFi", "iPad11,4": "iPad Air 3rd Generation Cellular",
    /* iPad (8th) */ "iPad11,6": "iPad 8th Generation WiFi", "iPad11,7": "iPad 8th Generation Cellular",
    /* iPad Air 4 */ "iPad13,1": "iPad Air 4th Generation WiFi", "iPad13,2": "iPad Air 4th Generation Cellular",
    /* iPad Pro (11) 3rd Generation */ "iPad13,4": "iPad Pro 11inch 3rd Generation WiFi", "iPad13,5": "iPad Pro 11inch 3rd Generation WiFi", "iPad13,6": "iPad Pro 11inch 3rd Generation Cellular", "iPad13,7": "iPad Pro 11inch 3rd Generation Cellular",
    /* iPad Pro (12.9) 5th Generation */ "iPad13,8": "iPad Pro 12.9inch 5th Generation WiFi", "iPad13,9": "iPad Pro 12.9inch 5th Generation WiFi", "iPad13,10": "iPad Pro 12.9inch 5th Generation Cellular", "iPad13,11": "iPad Pro 12.9inch 5th Generation Cellular",
    
    /* -------------- Simulator -------------- */
    /* Simulator */ "x86_64": "Simulator", "i386": "Simulator",
]

extension UIDevice {
    var platform: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let mirror = Mirror(reflecting: systemInfo.machine)
        let identifier = mirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        return identifier
    }
    
    var modelName: String {
        let identifier = platform
        return DeviceList[identifier] ?? identifier
    }
}
