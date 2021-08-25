//
//  SignUpNgViewController.swift
//  Actbind
//
//  Created by 柿本　海斗 on 2020/12/17.
//

import UIKit

final class SignUpNoViewController: UIViewController {
    @IBOutlet weak var signUpNgTitleLabel: UILabel!
    @IBOutlet weak var returnButton: UIButton!
    @IBOutlet weak var returnButtonRight: NSLayoutConstraint!
    @IBOutlet weak var returnButtonLeft: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()

        signUpNgTitleLabel.text = "akaunntowosakuseidekimasenndesita".localized()

        returnButton.setTitle("modoru".localized(), for: .normal)

        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.error)
    }

    @IBAction func returnButtonTouchDown(_ sender: Any) {
        UIButton().uiButtonTapOn(item: returnButton, itemRight: returnButtonRight, itemLeft: returnButtonLeft)
    }

    @IBAction func returnButtonTouchDragOutside(_ sender: Any) {
        UIButton().uiButtonTapOff(item: returnButton, itemRight: returnButtonRight, itemLeft: returnButtonLeft)
    }

    @IBAction func returnButtonTouchUpInside(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        UIButton().uiButtonTapOff(item: returnButton, itemRight: returnButtonRight, itemLeft: returnButtonLeft)

        dismiss(animated: true, completion: nil)
    }
}
