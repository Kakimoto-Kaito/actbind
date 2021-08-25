//
//  SearchViewController.swift
//  Actbind
//
//  Created by 柿本海斗 on 2021/07/20.
//

import UIKit

final class SearchViewController: UIViewController, UISearchBarDelegate, UIGestureRecognizerDelegate {
    let userDefaults = UserDefaults(suiteName: "group.com.actbind")
    
    @IBOutlet weak var navigationBarTitle: UINavigationItem!
    @IBOutlet weak var colorTagLabel: UILabel!
    @IBOutlet weak var redButton: UIButton!
    @IBOutlet weak var orangeButton: UIButton!
    @IBOutlet weak var yellowButton: UIButton!
    @IBOutlet weak var greenButton: UIButton!
    @IBOutlet weak var blueButton: UIButton!
    @IBOutlet weak var purpleButton: UIButton!
    @IBOutlet weak var accountSearchButton: UIBarButtonItem!
    @IBOutlet weak var backButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
        navigationBarTitle.title = "kensaku".localized()
        
        if let userDefaults = userDefaults {
            let myColor = userDefaults.string(forKey: "mycolor")

            if myColor == "Original" {
                accountSearchButton.tintColor = UIColor(named: "BlackWhite")
                backButton.tintColor = UIColor(named: "BlackWhite")
            } else {
                accountSearchButton.tintColor = UIColor(named: myColor!)
                backButton.tintColor = UIColor(named: myColor!)
            }
        }
        
        colorTagLabel.text = "kara-tagukensaku".localized()
        
        redButton.cornerAll(value: 0, fulcrum: "")
        orangeButton.cornerAll(value: 0, fulcrum: "")
        yellowButton.cornerAll(value: 0, fulcrum: "")
        greenButton.cornerAll(value: 0, fulcrum: "")
        blueButton.cornerAll(value: 0, fulcrum: "")
        purpleButton.cornerAll(value: 0, fulcrum: "")
    }
    
    // 画面に表示される直前に呼ばれます。
    // viewDidLoadとは異なり毎回呼び出されます。
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if toHomeView == "on" {
            navigationController?.popToRootViewController(animated: true)
            
            let UINavigationController = tabBarController?.viewControllers?[0]
            tabBarController?.selectedViewController = UINavigationController
        }
    }
    
    @IBAction func accountSearchButtonAction(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        let storyBoard = UIStoryboard(name: "AccountSearch", bundle: nil)
        let nextVC = storyBoard.instantiateInitialViewController()
        
        navigationController?.pushViewController(nextVC!, animated: true)
    }

    @IBAction func rebButtonTouchUpInside(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        let storyBoard = UIStoryboard(name: "ColorTagSearch", bundle: nil)
        let nextVC = storyBoard.instantiateInitialViewController()
        let vc = (nextVC as? ColorTagSearchViewController)
        
        vc!.color = "Red"
        
        navigationController?.pushViewController(nextVC!, animated: true)
    }
    
    @IBAction func orangeButtonTouchUpInside(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        let storyBoard = UIStoryboard(name: "ColorTagSearch", bundle: nil)
        let nextVC = storyBoard.instantiateInitialViewController()
        let vc = (nextVC as? ColorTagSearchViewController)
        
        vc!.color = "Orange"
        
        navigationController?.pushViewController(nextVC!, animated: true)
    }
    
    @IBAction func yellowButtonTouchUpInside(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        let storyBoard = UIStoryboard(name: "ColorTagSearch", bundle: nil)
        let nextVC = storyBoard.instantiateInitialViewController()
        let vc = (nextVC as? ColorTagSearchViewController)
        
        vc!.color = "Yellow"
        
        navigationController?.pushViewController(nextVC!, animated: true)
    }
    
    @IBAction func greenButtonTouchUpInside(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        let storyBoard = UIStoryboard(name: "ColorTagSearch", bundle: nil)
        let nextVC = storyBoard.instantiateInitialViewController()
        let vc = (nextVC as? ColorTagSearchViewController)
        
        vc!.color = "Green"
        
        navigationController?.pushViewController(nextVC!, animated: true)
    }
    
    @IBAction func blueButtonTouchUpInside(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        let storyBoard = UIStoryboard(name: "ColorTagSearch", bundle: nil)
        let nextVC = storyBoard.instantiateInitialViewController()
        let vc = (nextVC as? ColorTagSearchViewController)
        
        vc!.color = "Blue"
        
        navigationController?.pushViewController(nextVC!, animated: true)
    }
    
    @IBAction func purpleButtonTouchUpInside(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        let storyBoard = UIStoryboard(name: "ColorTagSearch", bundle: nil)
        let nextVC = storyBoard.instantiateInitialViewController()
        let vc = (nextVC as? ColorTagSearchViewController)
        
        vc!.color = "Purple"
        
        navigationController?.pushViewController(nextVC!, animated: true)
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        navigationController?.popViewController(animated: true)
    }
}
