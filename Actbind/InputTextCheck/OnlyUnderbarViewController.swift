//
//  OnlyUnderbarViewController.swift
//  Actbind
//
//  Created by 柿本海斗 on 2021/02/23.
//

import UIKit

final class OnlyUnderbarViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // アンダーバーのみかどうかのクラス
    final class func isValidOnlyUnderbar(_ string: String) -> Bool {
        let accountNameRegex = "^[_]{1,}"
        let accountNameTest = NSPredicate(format: "SELF MATCHES %@", accountNameRegex)
        let result = accountNameTest.evaluate(with: string)
        return result
    }
}
