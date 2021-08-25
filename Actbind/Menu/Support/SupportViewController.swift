//
//  SupportViewController.swift
//  Actbind
//
//  Created by 柿本海斗 on 2021/08/22.
//

import MessageUI
import UIKit

final class SupportViewController: UIViewController, UIGestureRecognizerDelegate, MFMailComposeViewControllerDelegate {
    let userDefaults = UserDefaults(suiteName: "group.com.actbind")
    
    var supportMethod = SupportMethod.allSupportMethod
    
    @IBOutlet weak var navigationBarTitle: UINavigationItem!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var supportCenterContentLabel: UILabel!
    @IBOutlet weak var supportCenterButton: UIButton!
    @IBOutlet weak var supportCenterButtonRight: NSLayoutConstraint!
    @IBOutlet weak var supportCenterButtonLeft: NSLayoutConstraint!
    @IBOutlet weak var supportMethodLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
        navigationBarTitle.title = "sapo-to".localized()

        if let userDefaults = userDefaults {
            let myColor = userDefaults.string(forKey: "mycolor")

            if myColor == "Original" {
                backButton.tintColor = UIColor(named: "BlackWhite")
                supportCenterButton.backgroundColor = UIColor(named: "Blue")
            } else {
                backButton.tintColor = UIColor(named: myColor!)
                supportCenterButton.backgroundColor = UIColor(named: myColor!)
            }
        }
        
        backButton.image = UIImage(named: "back")
        
        supportCenterContentLabel.text = "supportcentercontent".localized()
        
        supportCenterButton.setTitle("supportcenter".localized(), for: .normal)
        
        supportMethodLabel.text = "supportmethod".localized()
    }
    
    @IBAction func supportCenterButtonTouchDown(_ sender: Any) {
        UIButton().uiButtonTapOn(item: supportCenterButton, itemRight: supportCenterButtonRight, itemLeft: supportCenterButtonLeft)
    }
    
    @IBAction func supportCenterButtonTouchDragOutside(_ sender: Any) {
        UIButton().uiButtonTapOff(item: supportCenterButton, itemRight: supportCenterButtonRight, itemLeft: supportCenterButtonLeft)
    }
    
    @IBAction func supportCenterButtonTouchUpInside(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        UIButton().uiButtonTapOff(item: supportCenterButton, itemRight: supportCenterButtonRight, itemLeft: supportCenterButtonLeft)
        
        let storyBoard = UIStoryboard(name: "AboutActbindWeb", bundle: nil)
        let nextVC = storyBoard.instantiateInitialViewController()
        let nav = (nextVC as? UINavigationController)
        let vc = (nav?.topViewController as! AboutActbindWebViewController)
        
        // 値の設定
        if "language".localized() == "Japanese" {
            vc.weburl = "https://support.actbind.com/ja"
        } else {
            vc.weburl = "https://support.actbind.com"
        }
        
        present(nextVC!, animated: true) {}
    }
    
    @IBAction func backBottonAction(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        navigationController?.popViewController(animated: true)
    }
}

// extensionは何かを追加していく ViewControllerというクラスの中にUITableViewDataSource機能を追加していく
extension SupportViewController: UITableViewDataSource {
    // tableviewの中に何個のセクションを追加するか
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    // 一つのtableviewの中に何個のセルが必要か
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        supportMethod.count
    }
    
    // tavleviewの中で使われているセルの特定
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "supportMethodCell", for: indexPath) as! SupportTableViewCell
        
        // ここからの内容がセルに反映される
        // 順番にcellの方のpostに送っていく
        cell.supportMethod = supportMethod[indexPath.row]
        cell.delegate = self
        // ここまで
        return cell
    }
    
    func startMailer() {
        // メールを送信できるかチェック
        if MFMailComposeViewController.canSendMail() == false {
            print("Email Send Failed")
            return
        }
        
        let mailViewController = MFMailComposeViewController()
        let toRecipients = ["support@mail.actbind.com"]
        
        mailViewController.mailComposeDelegate = self
        if "language".localized() == "Japanese" {
            mailViewController.setSubject("タイトル：")
        } else {
            mailViewController.setSubject("Title:")
        }
        mailViewController.setToRecipients(toRecipients)
        if "language".localized() == "Japanese" {
            mailViewController.setMessageBody("内容：", isHTML: false)
        } else {
            mailViewController.setMessageBody("Content:", isHTML: false)
        }
        
        present(mailViewController, animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        switch result {
        case .cancelled:
            print("Email Send Cancelled")
        case .saved:
            print("Email Saved as a Draft")
        case .sent:
            print("Email Sent Successfully")
        case .failed:
            print("Email Send Failed")
        default:
            break
        }
        controller.dismiss(animated: true, completion: nil)
    }
}
