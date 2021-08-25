//
//  OnlyNumberViewController.swift
//  Actbind
//
//  Created by 柿本海斗 on 2021/02/23.
//

import UIKit

final class OnlyNumberViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // 数字のみかどうかのクラス
    final class func isValidOnlyNumber(_ string: String) -> Bool {
        let accountNameRegex = "^[0-9]{1,}"
        let accountNameTest = NSPredicate(format: "SELF MATCHES %@", accountNameRegex)
        let result = accountNameTest.evaluate(with: string)
        return result
    }
}
