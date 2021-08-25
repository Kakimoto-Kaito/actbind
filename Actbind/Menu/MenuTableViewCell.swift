//
//  MenuTableViewCell.swift
//  Actbind
//
//  Created by 柿本　海斗 on 2020/12/06.
//

import UIKit

final class MenuTableViewCell: UITableViewCell {
    let userDefaults = UserDefaults(suiteName: "group.com.actbind")
    
    @IBOutlet weak var decorationTextLabel: UILabel!
    @IBOutlet weak var decorationImage: UIImageView!
    @IBOutlet weak var inotiwomamoruText: UILabel!
    @IBOutlet weak var inotiwomamoruImage: UIImageView!
    @IBOutlet weak var activityText: UILabel!
    @IBOutlet weak var activityImage: UIImageView!
    @IBOutlet weak var houkokuText: UILabel!
    @IBOutlet weak var houkokuImage: UIImageView!
    @IBOutlet weak var supportText: UILabel!
    @IBOutlet weak var supportImage: UIImageView!
    @IBOutlet weak var setteiText: UILabel!
    @IBOutlet weak var setteiImage: UIImageView!
    @IBOutlet weak var roguautoText: UILabel!
    @IBOutlet weak var roguautoImage: UIImageView!
    
    // ダミーのAPI
    var menu: Menu! {
        // didSet:表示された時にpostから情報を取ってきてUIを勝手にを更新する
        didSet {
            // 画面が表示された時に発動する
            updateUI()
        }
    }
    
    // private:このファイル内でしか使えないfuncの時
    private func updateUI() {
        decorationTextLabel.text = menu.text1
        decorationImage.image = UIImage(named: menu.image1)
        inotiwomamoruText.text = menu.text2
        inotiwomamoruImage.image = UIImage(named: menu.image2)
        activityText.text = menu.text3
        if let userDefaults = userDefaults {
            let myColor = userDefaults.string(forKey: "mycolor")
            
            if myColor == "Original" {
                activityImage.image = UIImage(named: menu.image3 + "Blue")
            } else {
                activityImage.image = UIImage(named: menu.image3 + myColor!)
            }
        }
        houkokuText.text = menu.text4
        houkokuImage.image = UIImage(named: menu.image4)
        supportText.text = menu.text5
        supportImage.image = UIImage(named: menu.image5)
        setteiText.text = menu.text6
        setteiImage.image = UIImage(named: menu.image6)
        setteiImage.tintColor = UIColor.lightGray
        roguautoText.text = menu.text7
        roguautoImage.image = UIImage(named: menu.image7)
        roguautoImage.tintColor = UIColor.darkGray
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
