//
//  SettingViewController.swift
//  Actbind
//
//  Created by 柿本　海斗 on 2020/12/02.
//

import UIKit

final class SettingViewController: UIViewController, UIGestureRecognizerDelegate {
    let userDefaults = UserDefaults(suiteName: "group.com.actbind")

    @IBOutlet weak var navigationBarTitle: UINavigationItem!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var accountLabel: UILabel!
    @IBOutlet weak var privacyLabel: UILabel!
    @IBOutlet weak var securityLabel: UILabel!
    @IBOutlet weak var photoLabel: UILabel!
    @IBOutlet weak var appLanguageLabel: UILabel!
    @IBOutlet weak var aboutLabel: UILabel!
    @IBOutlet weak var accountImage: UIImageView!
    @IBOutlet weak var privacyImage: UIImageView!
    @IBOutlet weak var securityImage: UIImageView!
    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var appLanguageImage: UIImageView!
    @IBOutlet weak var aboutImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
        navigationBarTitle.title = "settei".localized()

        if let userDefaults = userDefaults {
            let myColor = userDefaults.string(forKey: "mycolor")

            if myColor == "Original" {
                backButton.tintColor = UIColor(named: "BlackWhite")
            } else {
                backButton.tintColor = UIColor(named: myColor!)
            }
        }
        
        backButton.image = UIImage(named: "back")
        
        accountImage.image = UIImage(named: "アセット 456")
        accountLabel.text = "akaunnto".localized()

        privacyImage.image = UIImage(named: "privacy")
        privacyLabel.text = "puraibasi-".localized()

        securityImage.image = UIImage(named: "security")
        securityLabel.text = "sekyuritexi".localized()

        photoImage.image = UIImage(named: "アセット 462")
        photoLabel.text = "syasinn".localized()
        
        appLanguageImage.image = UIImage(named: "global")
        appLanguageLabel.text = "apurinogenngo".localized()

        aboutImage.image = UIImage(named: "about")
        aboutLabel.text = "actbindnituite".localized()
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
    
    @IBAction func accountButtonTouchUpInside(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        let storyBoard = UIStoryboard(name: "PersonalInformation", bundle: nil)
        let nextVC = storyBoard.instantiateInitialViewController()
        
        navigationController?.pushViewController(nextVC!, animated: true)
    }
    
    @IBAction func privacyButtonTouchUpInside(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        let storyBoard = UIStoryboard(name: "Privacy", bundle: nil)
        let nextVC = storyBoard.instantiateInitialViewController()
        
        navigationController?.pushViewController(nextVC!, animated: true)
    }
    
    @IBAction func securityButtonTouchUpInside(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        let storyBoard = UIStoryboard(name: "Security", bundle: nil)
        let nextVC = storyBoard.instantiateInitialViewController()
        
        navigationController?.pushViewController(nextVC!, animated: true)
    }
    
    @IBAction func photoButtonTouchUpInside(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        let storyBoard = UIStoryboard(name: "Photo", bundle: nil)
        let nextVC = storyBoard.instantiateInitialViewController()
        
        navigationController?.pushViewController(nextVC!, animated: true)
    }
    
    @IBAction func appLanguageButtonTouchUpInside(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
    }
    
    @IBAction func aboutButtonTouchUpInside(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        let storyBoard = UIStoryboard(name: "About", bundle: nil)
        let nextVC = storyBoard.instantiateInitialViewController()
        
        navigationController?.pushViewController(nextVC!, animated: true)
    }

    @IBAction func backBottonAction(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        navigationController?.popViewController(animated: true)
    }
}
