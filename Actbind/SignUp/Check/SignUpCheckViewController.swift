//
//  SignUpCheckViewController.swift
//  Actbind
//
//  Created by 柿本　海斗 on 2020/12/17.
//

import UIKit

final class SignUpCheckViewController: UIViewController, UIGestureRecognizerDelegate {
    var name1 = ""
    var name2 = ""
    var mailaddress = ""
    var password = ""
    var gender = 0
    var birthday = ""
    var username = ""

    @IBOutlet weak var signUpOkTitleLabel: UILabel!
    @IBOutlet weak var signUpOkExplanationLabel: UILabel!
    @IBOutlet weak var termsOfServiceAndPrivacyPolicyButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var signUpButtonRight: NSLayoutConstraint!
    @IBOutlet weak var signUpButtonLeft: NSLayoutConstraint!
    @IBOutlet weak var haveAccountButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true

        signUpOkTitleLabel.text = "tourokukannryou".localized()

        signUpOkExplanationLabel.text = "doui".localized()

        termsOfServiceAndPrivacyPolicyButton.setTitle("riyoukiyakupuraibasi-porisi-".localized(), for: .normal)

        signUpButton.setTitle("touroku".localized(), for: .normal)

        let attributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 12.0)]
        haveAccountButton.setTitleTextAttributes(attributes, for: UIControl.State.normal)
        haveAccountButton.title = "akaunntowoomotinokata".localized()
    }

    @IBAction func termsOfServiceAndPrivacyPolicyButtonTouchDown(_ sender: Any) {
        termsOfServiceAndPrivacyPolicyButton.backgroundColor = UIColor(named: "BlueHalf")
    }

    @IBAction func termsOfServiceAndPrivacyPolicyButtonTouchDragOutside(_ sender: Any) {
        termsOfServiceAndPrivacyPolicyButton.backgroundColor = UIColor.clear
    }

    @IBAction func termsOfServiceAndPrivacyPolicyButtonTouchUpInside(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        termsOfServiceAndPrivacyPolicyButton.backgroundColor = UIColor.clear
        
        let storyBoard = UIStoryboard(name: "AboutActbindWeb", bundle: nil)
        let nextVC = storyBoard.instantiateInitialViewController()
        let nav = (nextVC as? UINavigationController)
        let vc = (nav?.topViewController as! AboutActbindWebViewController)
        
        // 値の設定
        vc.weburl = "https://policy.actbind.com"
        
        present(nextVC!, animated: true) {}
    }

    @IBAction func signUpButtonTouchDown(_ sender: Any) {
        UIButton().uiButtonTapOn(item: signUpButton, itemRight: signUpButtonRight, itemLeft: signUpButtonLeft)
    }

    @IBAction func signUpButtonTouchDragOutside(_ sender: Any) {
        UIButton().uiButtonTapOff(item: signUpButton, itemRight: signUpButtonRight, itemLeft: signUpButtonLeft)
    }

    @IBAction func signUpButtonTouchUpInside(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        UIButton().uiButtonTapOff(item: signUpButton, itemRight: signUpButtonRight, itemLeft: signUpButtonLeft)

        let storyBoard = UIStoryboard(name: "SignUpAccountCreating", bundle: nil)
        let nextVC = storyBoard.instantiateInitialViewController()
        let vc = (nextVC as? SignUpAccountCreatingViewController)
        
        // 値の設定
        vc!.name1 = name1
        vc!.name2 = name2
        vc!.mailaddress = mailaddress
        vc!.password = password
        vc!.gender = gender
        vc!.birthday = birthday
        vc!.username = username
        
        navigationController?.pushViewController(nextVC!, animated: false)
    }

    @IBAction func haveAccountButton(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        dismiss(animated: true, completion: nil)
    }
}
