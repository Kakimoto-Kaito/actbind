//
//  OtherProfileNoPost.swift
//  Actbind
//
//  Created by 柿本海斗 on 2021/07/17.
//

import UIKit

final class OtherProfileNoPost {
    var image: UIImage
    var text: String
    
    init(image: UIImage, text: String) {
        self.image = image
        self.text = text
    }
    
    // Sampleデータ
    static let allNoPost = [
        OtherProfileNoPost(image: UIImage(named: "アセット 462")!, text: "toukougaarimasenn".localized()),
    ]
}
