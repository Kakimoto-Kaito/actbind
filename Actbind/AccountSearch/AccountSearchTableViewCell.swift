//
//  AccountSearchTableViewCell.swift
//  Actbind
//
//  Created by 柿本海斗 on 2021/07/22.
//

import Nuke
import UIKit

final class AccountSearchTableViewCell: UITableViewCell {
    let userDefaults = UserDefaults(suiteName: "group.com.actbind")
    
    var delegate: AccountSearchViewController?
    
    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    // ダミーのAPI
    var user: AccountSearchViewController.Users? {
        // didSet:表示された時にpostから情報を取ってきてUIを勝手にを更新する
        didSet {
            // 画面が表示された時に発動する
            updateUI()
        }
    }
    
    // private:このファイル内でしか使えないfuncの時
    private func updateUI() {
        userNameLabel.text = "@" + user!.userName
        
        if user!.profileimageUrl == "Default" {
            userProfileImage.image = UIImage(named: "defaultProfileImage")
        } else {
            let profileImageUrlString = "https://www.actbind.com/" + user!.userName + "/profile-image/" + user!.profileimageUrl
            let userProfileImageURL = URL(string: profileImageUrlString)!
            Nuke.loadImage(with: userProfileImageURL, into: userProfileImage)
        }
        
        userProfileImage.cornerAll(value: 0, fulcrum: "width")
        
        let name1 = user!.name1
        let name2 = user!.name2
        let name = name1 + " " + name2
        nameLabel.text = name
    }
    
    @IBAction func goProfileButtonTouchUpInside(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        if let userDefaults = userDefaults {
            let userId = userDefaults.integer(forKey: "userid")
            
            if userId == user!.userId {
                delegate?.goMyProfile(user!.userId)
            } else {
                delegate?.goOtherProfile(user!.userId, userName: user!.userName)
            }
        }
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
