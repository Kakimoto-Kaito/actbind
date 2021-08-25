//
//  MailAddressViewController.swift
//  Actbind
//
//  Created by 柿本　海斗 on 2020/11/28.
//

import UIKit

final class MailAddressViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // メールアドレスかどうかのクラス
    final class func isValidMailAddress(_ string: String) -> Bool {
        let mailAddressRegEx = "[A-Z0-9a-z._+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let mailAddressTest = NSPredicate(format: "SELF MATCHES %@", mailAddressRegEx)
        let result = mailAddressTest.evaluate(with: string)
        return result
    }
}
