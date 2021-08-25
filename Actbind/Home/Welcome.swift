//
//  Welcome.swift
//  Actbind
//
//  Created by 柿本海斗 on 2021/07/08.
//

import UIKit

final class Welcome {
    var text: String
    
    init(text: String) {
        self.text = text
    }
    
    // Sampleデータ
    static let allWelcome = [
        Welcome(text: "youkoso".localized()),
    ]
}
