//
//  MyProfile.swift
//  Actbind
//
//  Created by 柿本海斗 on 2021/07/03.
//

import UIKit

final class Profile {
    var text1: String
    var text2: String
    var text3: String
    var text4: String
    
    init(text1: String, text2: String, text3: String, text4: String) {
        self.text1 = text1
        self.text2 = text2
        self.text3 = text3
        self.text4 = text4
    }
    
    // Sampleデータ
    static let allProfile = [
        Profile(text1: "profileimage", text2: "name1", text3: "name2", text4: "bio"),
    ]
}
