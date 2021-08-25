//
//  UITextField+Setting.swift
//  Actbind
//
//  Created by 柿本海斗 on 2021/03/24.
//

import UIKit

extension UITextField {
    func uiTextFieldSetting(placeholder: String) {
        attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "TextFieldText")!])
        // UITextFieldの左側に余白（10px）を入れる
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        leftViewMode = UITextField.ViewMode.always
        cornerAll(value: 8, fulcrum: "")
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 1
        layer.masksToBounds = true
    }
}
