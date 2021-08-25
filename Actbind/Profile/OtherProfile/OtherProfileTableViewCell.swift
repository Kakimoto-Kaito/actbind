//
//  OtherProfileTableViewCell.swift
//  Actbind
//
//  Created by 柿本海斗 on 2021/07/03.
//

import Nuke
import UIKit

final class OtherProfileTableViewCell: UITableViewCell {
    let userDefaults = UserDefaults(suiteName: "group.com.actbind")
    
    var delegate: OtherProfileViewController?
    
    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var bioLabelTop: NSLayoutConstraint!
    @IBOutlet weak var followButton: UIButton!
    @IBOutlet weak var followButtonRight: NSLayoutConstraint!
    @IBOutlet weak var followButtonLeft: NSLayoutConstraint!
    
    // ダミーのAPI
    var user: OtherProfileViewController.OtherUsers? {
        // didSet:表示された時にpostから情報を取ってきてUIを勝手にを更新する
        didSet {
            // 画面が表示された時に発動する
            updateUI()
        }
    }
    
    // private:このファイル内でしか使えないfuncの時
    private func updateUI() {
        if let userDefaults = userDefaults {
            let myColor = userDefaults.string(forKey: "mycolor")
            if myColor == "Original" {
                // followButton.backgroundColor = UIColor(named: "Blue")
            } else {
                // followButton.backgroundColor = UIColor(named: myColor!)
            }
    
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
            bioLabel.text = user!.bio
        }
        
        // followButton.setTitle("foro-".localized(), for: .normal)
        
        if bioLabel.text == "" {
            bioLabelTop.constant = 0
        } else {
            bioLabelTop.constant = 8
        }
    }
    
    @IBAction func followButtonTouchDown(_ sender: Any) {
        UIButton().uiButtonTapOn(item: followButton, itemRight: followButtonRight, itemLeft: followButtonLeft)
    }
    
    @IBAction func followButtonTouchDragOutside(_ sender: Any) {
        UIButton().uiButtonTapOff(item: followButton, itemRight: followButtonRight, itemLeft: followButtonLeft)
    }
    
    @IBAction func followButtonTouchUpInside(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        UIButton().uiButtonTapOff(item: followButton, itemRight: followButtonRight, itemLeft: followButtonLeft)
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
