//
//  supportMethod.swift
//  Actbind
//
//  Created by 柿本海斗 on 2021/08/22.
//

import UIKit

final class SupportMethod {
    // プロパティー
    var image: String
    var title: String
    var content: String
    
    init(title: String, image: String, content: String) {
        self.title = title
        self.image = image
        self.content = content
    }
    
    // Sampleデータ
    static let allSupportMethod = [
        SupportMethod(title: "me-ru".localized(), image: "mail", content: "me-ruactbindsapo-to".localized()),
    ]
}
