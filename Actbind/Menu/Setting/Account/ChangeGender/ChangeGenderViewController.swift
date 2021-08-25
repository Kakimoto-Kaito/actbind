//
//  ChangeGenderViewController.swift
//  Actbind
//
//  Created by 柿本　海斗 on 2020/12/02.
//

import UIKit

final class ChangeGenderViewController: UIViewController, UIGestureRecognizerDelegate {
    let userDefaults = UserDefaults(suiteName: "group.com.actbind")

    @IBOutlet weak var navigationBarTitle: UINavigationItem!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var genderSegmentedControl: UISegmentedControl!
    @IBOutlet weak var confirmationButton: UIButton!
    @IBOutlet weak var confirmationButtonRight: NSLayoutConstraint!
    @IBOutlet weak var confirmationButtonLeft: NSLayoutConstraint!
    @IBOutlet weak var backButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true

        navigationBarTitle.title = "seibetu".localized()

        if let userDefaults = userDefaults {
            let myColor = userDefaults.string(forKey: "mycolor")
            let gender = userDefaults.integer(forKey: "gender")

            if myColor == "Original" {
                backButton.tintColor = UIColor(named: "BlackWhite")
                confirmationButton.backgroundColor = UIColor(named: "Blue")
            } else {
                backButton.tintColor = UIColor(named: myColor!)
                confirmationButton.backgroundColor = UIColor(named: myColor!)
            }

            if gender == 1 {
                genderLabel.text = "dannsei".localized()
                genderSegmentedControl.selectedSegmentIndex = 0
            } else if gender == 2 {
                genderLabel.text = "jyosei".localized()
                genderSegmentedControl.selectedSegmentIndex = 1
            } else {
                genderLabel.text = "sonota".localized()
                genderSegmentedControl.selectedSegmentIndex = 2
            }
        }
        
        backButton.image = UIImage(named: "back")
        
        genderSegmentedControl.setTitle("dannsei".localized(), forSegmentAt: 0)
        genderSegmentedControl.setTitle("jyosei".localized(), forSegmentAt: 1)
        genderSegmentedControl.setTitle("sonota".localized(), forSegmentAt: 2)

        confirmationButton.setTitle("kakuninn".localized(), for: .normal)
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
    
    @IBAction func genderSegmentedControlValueChanged(_ sender: Any) {
        // セグメントが変更されたときの処理
        // 選択されているセグメントのインデックス
        let selectedIndex = genderSegmentedControl.selectedSegmentIndex
        // 選択されたインデックスの文字列を取得してラベルに設定
        genderLabel.text = genderSegmentedControl.titleForSegment(at: selectedIndex)

        if let userDefaults = userDefaults {
            let myColor = userDefaults.string(forKey: "mycolor")

            if myColor == "Original" {
                confirmationButton.setTitleColor(UIColor(named: "White"), for: .normal)
                confirmationButton.backgroundColor = UIColor(named: "Blue")
            } else {
                confirmationButton.setTitleColor(UIColor(named: "White"), for: .normal)
                confirmationButton.backgroundColor = UIColor(named: myColor!)
            }
        }
    }
    
    @IBAction func confirmationButtonTouchDown(_ sender: Any) {
        UIButton().uiButtonTapOn(item: confirmationButton, itemRight: confirmationButtonRight, itemLeft: confirmationButtonLeft)
    }
    
    @IBAction func confirmationButtonTouchDragOutside(_ sender: Any) {
        UIButton().uiButtonTapOff(item: confirmationButton, itemRight: confirmationButtonRight, itemLeft: confirmationButtonLeft)
    }
    
    @IBAction func confirmationButtonTouchUpInside(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        UIButton().uiButtonTapOff(item: confirmationButton, itemRight: confirmationButtonRight, itemLeft: confirmationButtonLeft)

        if let userDefaults = userDefaults {
            let gender = userDefaults.integer(forKey: "gender")

            // セグメントコントロールが何番目に止まっているかでスイッチ
            switch genderSegmentedControl.selectedSegmentIndex {
            case 0:
                if gender == 1 {
                    navigationController?.popViewController(animated: true)
                } else {
                    let storyBoard = UIStoryboard(name: "SaveNewInformation", bundle: nil)
                    let nextVC = storyBoard.instantiateInitialViewController()
                    let vc = (nextVC as? SaveNewInformationViewController)
                    
                    // 値の設定
                    // セグメントコントロールが何番目に止まっているかでスイッチ
                    switch genderSegmentedControl.selectedSegmentIndex {
                    case 0:
                        vc!.gender = 1
                        vc!.genderString = genderLabel.text!
                    case 1:
                        vc!.gender = 2
                        vc!.genderString = genderLabel.text!
                    case 2:
                        vc!.gender = 9
                        vc!.genderString = genderLabel.text!
                    default:
                        print("error")
                    }
                    
                    navigationController?.pushViewController(nextVC!, animated: true)
                }
            case 1:
                if gender == 2 {
                    navigationController?.popViewController(animated: true)
                } else {
                    let storyBoard = UIStoryboard(name: "SaveNewInformation", bundle: nil)
                    let nextVC = storyBoard.instantiateInitialViewController()
                    let vc = (nextVC as? SaveNewInformationViewController)
                    
                    // 値の設定
                    // セグメントコントロールが何番目に止まっているかでスイッチ
                    switch genderSegmentedControl.selectedSegmentIndex {
                    case 0:
                        vc!.gender = 1
                        vc!.genderString = genderLabel.text!
                    case 1:
                        vc!.gender = 2
                        vc!.genderString = genderLabel.text!
                    case 2:
                        vc!.gender = 9
                        vc!.genderString = genderLabel.text!
                    default:
                        print("error")
                    }
                    
                    navigationController?.pushViewController(nextVC!, animated: true)
                }
            case 2:
                if gender == 9 {
                    navigationController?.popViewController(animated: true)
                } else {
                    let storyBoard = UIStoryboard(name: "SaveNewInformation", bundle: nil)
                    let nextVC = storyBoard.instantiateInitialViewController()
                    let vc = (nextVC as? SaveNewInformationViewController)
                    
                    // 値の設定
                    // セグメントコントロールが何番目に止まっているかでスイッチ
                    switch genderSegmentedControl.selectedSegmentIndex {
                    case 0:
                        vc!.gender = 1
                        vc!.genderString = genderLabel.text!
                    case 1:
                        vc!.gender = 2
                        vc!.genderString = genderLabel.text!
                    case 2:
                        vc!.gender = 9
                        vc!.genderString = genderLabel.text!
                    default:
                        print("error")
                    }
                    
                    navigationController?.pushViewController(nextVC!, animated: true)
                }
            default:
                print("error")
            }
        }
    }

    @IBAction func backBottonAction(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        navigationController?.popViewController(animated: true)
    }
}
