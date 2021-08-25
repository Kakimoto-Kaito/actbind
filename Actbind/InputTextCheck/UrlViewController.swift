//
//  UrlViewController.swift
//  Actbind
//
//  Created by 柿本海斗 on 2021/08/25.
//

import UIKit

final class UrlViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // URLかどうかのクラス
    final class func isValidUrl(_ string: String) -> Bool {
        let urlRegEx = "^(http://|https://)[A-Za-z0-9.-]+(?!.*\\|\\w*$)"
        let urlTest = NSPredicate(format: "SELF MATCHES %@", urlRegEx)
        let result = urlTest.evaluate(with: string)
        return result
    }
}
