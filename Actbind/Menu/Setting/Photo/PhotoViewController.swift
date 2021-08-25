//
//  PhotoViewController.swift
//  Actbind
//
//  Created by 柿本海斗 on 2021/02/23.
//

import UIKit

final class PhotoViewController: UIViewController, UIGestureRecognizerDelegate {
    let userDefaults = UserDefaults(suiteName: "group.com.actbind")

    @IBOutlet weak var navigationBarTitle: UINavigationItem!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var savePhotoView: UIView!
    @IBOutlet weak var savePhotoLabel: UILabel!
    @IBOutlet weak var savePhotoSwitch: UISwitch!
    @IBOutlet weak var savePhotoExplanationLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true

        navigationBarTitle.title = "syasinn".localized()

        if let userDefaults = userDefaults {
            let myColor = userDefaults.string(forKey: "mycolor")
            let savePhoto = userDefaults.string(forKey: "savephoto")
            
            if myColor == "Original" {
                backButton.tintColor = UIColor(named: "BlackWhite")
                savePhotoSwitch.onTintColor = UIColor(named: "Green")
            } else {
                backButton.tintColor = UIColor(named: myColor!)
                savePhotoSwitch.onTintColor = UIColor(named: myColor!)
            }
            
            if savePhoto == "On" {
                savePhotoSwitch.isOn = true
            } else {
                savePhotoSwitch.isOn = false
            }
        }

        backButton.image = UIImage(named: "back")
        
        savePhotoView.cornerAll(value: 16, fulcrum: "")
        savePhotoLabel.text = "syasinnwohozonn".localized()
        
        savePhotoExplanationLabel.text = "syasinnwohozonnsetumei".localized()
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

    @IBAction func savePhotoSwitchValueChanged(_ sender: Any) {
        if savePhotoSwitch.isOn == true {
            // データ登録・更新
            if let userDefaults = self.userDefaults {
                userDefaults.setValue("On", forKeyPath: "savephoto")
            }
        } else {
            // データ登録・更新
            if let userDefaults = self.userDefaults {
                userDefaults.setValue("Off", forKeyPath: "savephoto")
            }
        }
    }
    
    @IBAction func backBottonAction(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        navigationController?.popViewController(animated: true)
    }
}
