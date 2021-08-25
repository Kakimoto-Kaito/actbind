//
//  PersonalInformationViewController.swift
//  Actbind
//
//  Created by 柿本　海斗 on 2020/12/02.
//

import UIKit

final class PersonalInformationViewController: UIViewController, UIGestureRecognizerDelegate {
    let userDefaults = UserDefaults(suiteName: "group.com.actbind")

    @IBOutlet weak var navigationBarTitle: UINavigationItem!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var contactInfoLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var birthdayView: UIView!
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var deleteYourAccountView: UIView!
    @IBOutlet weak var deleteYourAccountLabel: UILabel!
    @IBOutlet weak var nextImage1: UIImageView!
    @IBOutlet weak var nextImage2: UIImageView!
    @IBOutlet weak var nextImage3: UIImageView!
    @IBOutlet weak var nextImage4: UIImageView!
    @IBOutlet weak var nextImage5: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
        navigationBarTitle.title = "kojinnnojyouhou".localized()

        if let userDefaults = userDefaults {
            let myColor = userDefaults.string(forKey: "mycolor")
            if myColor == "Original" {
                backButton.tintColor = UIColor(named: "BlackWhite")
            } else {
                backButton.tintColor = UIColor(named: myColor!)
            }

            if myColor == "Original" {
                nextImage1.image = UIImage(named: "defaultNext")
                nextImage2.image = UIImage(named: "defaultNext")
                nextImage3.image = UIImage(named: "defaultNext")
                nextImage4.image = UIImage(named: "defaultNext")
                nextImage5.image = UIImage(named: "defaultNext")
            } else if myColor == "Red" {
                nextImage1.image = UIImage(named: "redNext")
                nextImage2.image = UIImage(named: "redNext")
                nextImage3.image = UIImage(named: "redNext")
                nextImage4.image = UIImage(named: "redNext")
                nextImage5.image = UIImage(named: "redNext")
            } else if myColor == "Orange" {
                nextImage1.image = UIImage(named: "orangeNext")
                nextImage2.image = UIImage(named: "orangeNext")
                nextImage3.image = UIImage(named: "orangeNext")
                nextImage4.image = UIImage(named: "orangeNext")
                nextImage5.image = UIImage(named: "orangeNext")
            } else if myColor == "Yellow" {
                nextImage1.image = UIImage(named: "yellowNext")
                nextImage2.image = UIImage(named: "yellowNext")
                nextImage3.image = UIImage(named: "yellowNext")
                nextImage4.image = UIImage(named: "yellowNext")
                nextImage5.image = UIImage(named: "yellowNext")
            } else if myColor == "Green" {
                nextImage1.image = UIImage(named: "greenNext")
                nextImage2.image = UIImage(named: "greenNext")
                nextImage3.image = UIImage(named: "greenNext")
                nextImage4.image = UIImage(named: "greenNext")
                nextImage5.image = UIImage(named: "greenNext")
            } else if myColor == "Blue" {
                nextImage1.image = UIImage(named: "blueNext")
                nextImage2.image = UIImage(named: "blueNext")
                nextImage3.image = UIImage(named: "blueNext")
                nextImage4.image = UIImage(named: "blueNext")
                nextImage5.image = UIImage(named: "blueNext")
            } else {
                nextImage1.image = UIImage(named: "purpleNext")
                nextImage2.image = UIImage(named: "purpleNext")
                nextImage3.image = UIImage(named: "purpleNext")
                nextImage4.image = UIImage(named: "purpleNext")
                nextImage5.image = UIImage(named: "purpleNext")
            }
        }
        
        backButton.image = UIImage(named: "back")
        
        nameView.cornerPart(value: 16, fulcrum: "", Location: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
        birthdayView.cornerPart(value: 16, fulcrum: "", Location: [.layerMinXMaxYCorner, .layerMaxXMaxYCorner])
        deleteYourAccountView.cornerAll(value: 16, fulcrum: "")

        nameLabel.text = "namae".localized()

        contactInfoLabel.text = "rennrakusakijyouhou".localized()

        genderLabel.text = "seibetu".localized()

        birthdayLabel.text = "tannjyoubi".localized()

        deleteYourAccountLabel.text = "akaunntokannri".localized()
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

    @IBAction func nameButtonTouchUpInside(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        let storyBoard = UIStoryboard(name: "ChangeName", bundle: nil)
        let nextVC = storyBoard.instantiateInitialViewController()
        
        navigationController?.pushViewController(nextVC!, animated: true)
    }
    
    @IBAction func contactInfoButtonTouchUpInside(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        let storyBoard = UIStoryboard(name: "ChangeMailAddress", bundle: nil)
        let nextVC = storyBoard.instantiateInitialViewController()
        
        navigationController?.pushViewController(nextVC!, animated: true)
    }
    
    @IBAction func genderButtonTouchUpInside(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        let storyBoard = UIStoryboard(name: "ChangeGender", bundle: nil)
        let nextVC = storyBoard.instantiateInitialViewController()
        
        navigationController?.pushViewController(nextVC!, animated: true)
    }
    
    @IBAction func birthdayButtonTouchUpInside(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        let storyBoard = UIStoryboard(name: "ChangeBirthday", bundle: nil)
        let nextVC = storyBoard.instantiateInitialViewController()
        
        navigationController?.pushViewController(nextVC!, animated: true)
    }
    
    @IBAction func deleteYourAccountButtonTouchUpInside(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        let storyBoard = UIStoryboard(name: "DeleteAccountCheck", bundle: nil)
        let nextVC = storyBoard.instantiateInitialViewController()
        
        navigationController?.pushViewController(nextVC!, animated: true)
    }
    
    @IBAction func backBottonAction(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        navigationController?.popViewController(animated: true)
    }
}
