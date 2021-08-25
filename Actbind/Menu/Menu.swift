//
//  Menu.swift
//  Actbind
//
//  Created by 柿本　海斗 on 2020/12/06.
//

import UIKit

final class Menu {
    // プロパティー
    var image1: String
    var text1: String
    var image2: String
    var text2: String
    var image3: String
    var text3: String
    var image4: String
    var text4: String
    var image5: String
    var text5: String
    var image6: String
    var text6: String
    var image7: String
    var text7: String
    
    init(text1: String, image1: String, text2: String, image2: String, text3: String, image3: String, text4: String, image4: String, text5: String, image5: String, text6: String, image6: String, text7: String, image7: String)
    {
        self.text1 = text1
        self.image1 = image1
        self.text2 = text2
        self.image2 = image2
        self.text3 = text3
        self.image3 = image3
        self.text4 = text4
        self.image4 = image4
        self.text5 = text5
        self.image5 = image5
        self.text6 = text6
        self.image6 = image6
        self.text7 = text7
        self.image7 = image7
    }
    
    // Sampleデータ
    static let allMenu = [
        Menu(text1: "dekore-syonn".localized(), image1: "decoration", text2: "inotiwomamoru".localized(), image2: "life-shield", text3: "akuthibithi".localized(), image3: "activity", text4: "monndaiwohoukoku".localized(), image4: "houkoku", text5: "sapo-to".localized(), image5: "support", text6: "settei".localized(), image6: "setting", text7: "roguauto".localized(), image7: "logout"),
    ]
}
