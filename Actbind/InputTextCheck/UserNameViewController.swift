//
//  AccountNameViewController.swift
//  Actbind
//
//  Created by 柿本　海斗 on 2020/11/28.
//

import UIKit

final class UserNameViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // ユーザーネームかどうかのクラス
    final class func isValidAccountName(_ string: String) -> Bool {
        let accountNameRegex = "^[A-Za-z0-9_]{5,30}"
        let accountNameTest = NSPredicate(format: "SELF MATCHES %@", accountNameRegex)
        let result = accountNameTest.evaluate(with: string)
        return result
    }
}
