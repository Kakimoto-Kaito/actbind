//
//  SignUpGenderViewController.swift
//  Actbind
//
//  Created by 柿本　海斗 on 2020/12/17.
//

import UIKit

final class SignUpGenderViewController: UIViewController, UIGestureRecognizerDelegate {
    var name1 = ""
    var name2 = ""
    var displayName = ""
    var mailaddress = ""
    var password = ""

    @IBOutlet weak var signUpGenderTitleLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var genderSegmentedControl: UISegmentedControl!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var nextButtonRight: NSLayoutConstraint!
    @IBOutlet weak var nextButtonLeft: NSLayoutConstraint!
    @IBOutlet weak var haveAccountButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true

        signUpGenderTitleLabel.text = "seibetuwosenntaku".localized()

        genderLabel.text = ""

        genderSegmentedControl.setTitle("dannsei".localized(), forSegmentAt: 0)
        genderSegmentedControl.setTitle("jyosei".localized(), forSegmentAt: 1)
        genderSegmentedControl.setTitle("sonota".localized(), forSegmentAt: 2)

        nextButton.setTitle("tugihe".localized(), for: .normal)

        let attributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 12.0)]
        haveAccountButton.setTitleTextAttributes(attributes, for: UIControl.State.normal)
        haveAccountButton.title = "akaunntowoomotinokata".localized()
    }

    @IBAction func genderSegmentedControlValueChanged(_ sender: Any) {
        // セグメントが変更されたときの処理
        // 選択されているセグメントのインデックス
        let selectedIndex = genderSegmentedControl.selectedSegmentIndex
        // 選択されたインデックスの文字列を取得してラベルに設定
        genderLabel.text = genderSegmentedControl.titleForSegment(at: selectedIndex)

        // 選択されていない時
        if genderSegmentedControl.selectedSegmentIndex == UISegmentedControl.noSegment {
            nextButton.isEnabled = false
            nextButton.setTitleColor(UIColor(named: "EnabledButtonText"), for: .normal)
            nextButton.backgroundColor = UIColor(named: "EnabledButton")
            // 選択されている時
        } else {
            nextButton.isEnabled = true
            nextButton.setTitleColor(UIColor(named: "White"), for: .normal)
            nextButton.backgroundColor = UIColor(named: "Blue")
        }
    }

    @IBAction func nextButtonTouchDown(_ sender: Any) {
        UIButton().uiButtonTapOn(item: nextButton, itemRight: nextButtonRight, itemLeft: nextButtonLeft)
    }

    @IBAction func nextButtonTouchDragOutside(_ sender: Any) {
        UIButton().uiButtonTapOff(item: nextButton, itemRight: nextButtonRight, itemLeft: nextButtonLeft)
    }

    @IBAction func nextButtonTouchUpInside(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        UIButton().uiButtonTapOff(item: nextButton, itemRight: nextButtonRight, itemLeft: nextButtonLeft)

        let storyBoard = UIStoryboard(name: "SignUpBirthday", bundle: nil)
        let nextVC = storyBoard.instantiateInitialViewController()
        let vc = (nextVC as? SignUpBirthdayViewController)
        
        // 値の設定
        vc!.name1 = name1
        vc!.name2 = name2
        vc!.displayName = displayName
        vc!.mailaddress = mailaddress
        vc!.password = password
        // セグメントコントロールが何番目に止まっているかでスイッチ
        switch genderSegmentedControl.selectedSegmentIndex {
        case 0:
            vc!.gender = 1
        case 1:
            vc!.gender = 2
        case 2:
            vc!.gender = 9
        default:
            vc!.gender = 0
        }
        
        navigationController?.pushViewController(nextVC!, animated: true)
    }

    @IBAction func haveAccountButton(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        dismiss(animated: true, completion: nil)
    }
}
