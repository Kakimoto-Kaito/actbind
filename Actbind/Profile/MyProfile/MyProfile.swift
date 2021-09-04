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
    
    init(text1: String, text2: String, text3: String) {
        self.text1 = text1
        self.text2 = text2
        self.text3 = text3
    }
    
    // Sampleデータ
    static let allProfile = [
        Profile(text1: "profileimage", text2: "displayname", text3: "bio"),
    ]
}
