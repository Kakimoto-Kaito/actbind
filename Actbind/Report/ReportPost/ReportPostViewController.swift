//
//  ReportPostViewController.swift
//  Actbind
//
//  Created by 柿本海斗 on 2021/06/13.
//

import UIKit

final class ReportPostViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    let userDefaults = UserDefaults(suiteName: "group.com.actbind")
    let api = KeyManager().getValue(key: "API") as? String
    
    var postId = 0

    @IBOutlet weak var navigationBarTitle: UINavigationItem!
    
    @IBOutlet weak var reportPostTitleLabel: UILabel!
    @IBOutlet weak var reportPostExplanationLabel: UILabel!
    @IBOutlet weak var reportTypeLabel: UILabel!
    @IBOutlet weak var reportTypePickerView: UIPickerView!
    @IBOutlet weak var sendButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    let reportType = ["toukouhoukokutaipu1".localized(), "toukouhoukokutaipu2".localized(), "toukouhoukokutaipu3".localized(), "toukouhoukokutaipu4".localized(), "toukouhoukokutaipu5".localized(), "toukouhoukokutaipu6".localized(), "toukouhoukokutaipu7".localized(), "toukouhoukokutaipu8".localized(), "toukouhoukokutaipu9".localized(), "toukouhoukokutaipu10".localized(), "toukouhoukokutaipu11".localized()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBarTitle.title = "houkoku".localized()

        if let userDefaults = userDefaults {
            let myColor = userDefaults.string(forKey: "mycolor")

            if myColor == "Original" {
                sendButton.tintColor = UIColor(named: "Blue")
                cancelButton.tintColor = UIColor(named: "BlackWhite")
            } else {
                sendButton.tintColor = UIColor(named: myColor!)
                cancelButton.tintColor = UIColor(named: myColor!)
            }
        }
        
        let attributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18.0)]
        sendButton.setTitleTextAttributes(attributes, for: .normal)
        sendButton.title = "sousinn".localized()
        sendButton.isEnabled = false
        
        cancelButton.image = UIImage(named: "cancel")
        
        reportPostTitleLabel.text = "toukouhoukokutaitoru".localized()
        reportPostExplanationLabel.text = "houkokusetumei1".localized()
        reportTypeLabel.text = ""
        
        reportTypePickerView.delegate = self
        reportTypePickerView.dataSource = self
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
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        reportType.count
    }
    
    // UIPickerViewの表示
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        reportType[row]
    }

    // UIPickerViewのRowが選択された時の挙動
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        sendButton.isEnabled = true
        reportTypeLabel.text = reportType[row]
    }
    
    @IBAction func sendButtonAction(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        apiPostTheReportPost()
        dialog()
    }
    
    func apiPostTheReportPost() {
        let url = URL(string: api! + "reportpost")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST" // Postリクエストを送る(このコードがないとGetリクエストになる)
        request.addValue("application/json", forHTTPHeaderField: "content-type")
        // request.addValue("", forHTTPHeaderField: "authorization") //APIKey
        
        // 構造体を作成
        struct Post: Codable {
            let postId: Int
            let reportType: Int
        }
        
        let encoder = JSONEncoder()
        
        let body = Post(postId: 0, reportType: reportTypePickerView.selectedRow(inComponent: 0) + 1)
        
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
        let messageTitle = "houkokuara-tomesse-ji1".localized()
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
