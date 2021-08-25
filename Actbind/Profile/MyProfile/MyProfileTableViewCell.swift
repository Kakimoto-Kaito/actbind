//
//  ProfileTableViewCell.swift
//  Actbind
//
//  Created by 柿本海斗 on 2021/03/02.
//

import Nuke
import UIKit

final class MyProfileTableViewCell: UITableViewCell {
    let userDefaults = UserDefaults(suiteName: "group.com.actbind")
    
    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var bioLabelTop: NSLayoutConstraint!
    @IBOutlet weak var profileEditButton: UIButton!
    @IBOutlet weak var profileEditButtonRight: NSLayoutConstraint!
    @IBOutlet weak var profileEditButtonLeft: NSLayoutConstraint!
    
    // ダミーのAPI
    var profile: Profile! {
        // didSet:表示された時にpostから情報を取ってきてUIを勝手にを更新する
        didSet {
            // 画面が表示された時に発動する
            updateUI()
        }
    }
    
    // private:このファイル内でしか使えないfuncの時
    private func updateUI() {
        if let userDefaults = userDefaults {
            let userName = userDefaults.string(forKey: "username")!
            let myColor = userDefaults.string(forKey: "mycolor")
            if myColor == "Original" {
                profileEditButton.backgroundColor = UIColor(named: "Blue")
            } else {
                profileEditButton.backgroundColor = UIColor(named: myColor!)
            }
            
            let name1 = userDefaults.string(forKey: "name1")
            let name2 = userDefaults.string(forKey: "name2")
            let bio = userDefaults.string(forKey: "bio")
            
            let profileimage = userDefaults.string(forKey: "profileimage")
            if profileimage == "Default" {
                userProfileImage.image = UIImage(named: "defaultProfileImage")
            } else {
                let profileImageUrlString = "https://www.actbind.com/" + userName + "/profile-image/" + profileimage!
                let userProfileImageURL = URL(string: profileImageUrlString)!
                Nuke.loadImage(with: userProfileImageURL, into: userProfileImage)
            }
            
            userProfileImage.cornerAll(value: 0, fulcrum: "width")
            nameLabel.text = name1! + " " + name2!
            bioLabel.text = bio
        }
        
        profileEditButton.setTitle("purofi-ruwohennsyuu".localized(), for: .normal)
        
        if bioLabel.text == "" {
            bioLabelTop.constant = 0
        } else {
            bioLabelTop.constant = 8
        }
    }
    
    @IBAction func profileEditButtonTouchDown(_ sender: Any) {
        UIButton().uiButtonTapOn(item: profileEditButton, itemRight: profileEditButtonRight, itemLeft: profileEditButtonLeft)
    }
    
    @IBAction func profileEditButtonTouchDragOutside(_ sender: Any) {
        UIButton().uiButtonTapOff(item: profileEditButton, itemRight: profileEditButtonRight, itemLeft: profileEditButtonLeft)
    }
    
    @IBAction func profileEditButtonTouchUpInside(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        UIButton().uiButtonTapOff(item: profileEditButton, itemRight: profileEditButtonRight, itemLeft: profileEditButtonLeft)
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
