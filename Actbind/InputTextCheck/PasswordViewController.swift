//
//  PasswordViewController.swift
//  Actbind
//
//  Created by 柿本　海斗 on 2020/11/28.
//

import UIKit

final class PasswordViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // パスワードかどうかのクラス
    final class func isValidPassword(_ string: String) -> Bool {
        let passwordRegex = "^(?=.*[A-Za-z])(?=.*[0-9$@$!%*#?&])[A-Za-z0-9$@$!%*#?&]{8,}$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        let result = passwordTest.evaluate(with: string)
        return result
    }
}
