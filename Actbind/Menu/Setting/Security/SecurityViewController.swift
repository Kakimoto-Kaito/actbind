//
//  SecurityViewController.swift
//  Actbind
//
//  Created by 柿本　海斗 on 2020/12/14.
//

import UIKit

final class SecurityViewController: UIViewController, UIGestureRecognizerDelegate {
    let userDefaults = UserDefaults(suiteName: "group.com.actbind")

    @IBOutlet weak var navigationBarTitle: UINavigationItem!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var nextImage: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true

        navigationBarTitle.title = "sekyuritexi".localized()

        if let userDefaults = userDefaults {
            let myColor = userDefaults.string(forKey: "mycolor")

            if myColor == "Original" {
                backButton.tintColor = UIColor(named: "BlackWhite")
            } else {
                backButton.tintColor = UIColor(named: myColor!)
            }

            if myColor == "Original" {
                nextImage.image = UIImage(named: "defaultNext")
            } else if myColor == "Red" {
                nextImage.image = UIImage(named: "redNext")
            } else if myColor == "Orange" {
                nextImage.image = UIImage(named: "orangeNext")
            } else if myColor == "Yellow" {
                nextImage.image = UIImage(named: "yellowNext")
            } else if myColor == "Green" {
                nextImage.image = UIImage(named: "greenNext")
            } else if myColor == "Blue" {
                nextImage.image = UIImage(named: "blueNext")
            } else {
                nextImage.image = UIImage(named: "purpleNext")
            }
        }

        backButton.image = UIImage(named: "back")

        passwordView.cornerAll(value: 16, fulcrum: "")
        passwordLabel.text = "pasuwa-do".localized()
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

    @IBAction func passwordButtonTouchUpInside(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        let storyBoard = UIStoryboard(name: "ChangePassword", bundle: nil)
        let nextVC = storyBoard.instantiateInitialViewController()
        
        navigationController?.pushViewController(nextVC!, animated: true)
    }
    
    @IBAction func backBottonAction(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        navigationController?.popViewController(animated: true)
    }
}
