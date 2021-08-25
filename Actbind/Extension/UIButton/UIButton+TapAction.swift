//
//  UIButton+TapAction.swift
//  Actbind
//
//  Created by 柿本海斗 on 2021/06/09.
//

import UIKit

extension UIButton {
    func uiButtonTapOn(item: UIButton, itemRight: NSLayoutConstraint, itemLeft: NSLayoutConstraint) {
        item.alpha = 0.5
        itemRight.constant = 25
        itemLeft.constant = 25
    }
    
    func uiButtonTapOff(item: UIButton, itemRight: NSLayoutConstraint, itemLeft: NSLayoutConstraint) {
        item.alpha = 1.0
        itemRight.constant = 20
        itemLeft.constant = 20
    }
}
