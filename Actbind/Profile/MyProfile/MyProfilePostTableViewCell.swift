//
//  MyProfilePostTableViewCell.swift
//  Actbind
//
//  Created by 柿本海斗 on 2021/07/03.
//

import Nuke
import UIKit

final class MyProfilePostTableViewCell: UITableViewCell {
    let userDefaults = UserDefaults(suiteName: "group.com.actbind")
    
    var delegate: MyProfileViewController?
    var indexNumber = 0
    
    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var postColor: UIButton!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var postImageTop: NSLayoutConstraint!
    @IBOutlet weak var heartButton: UIButton!
    @IBOutlet weak var postDateLabel: UILabel!
    
    var heart = "Off"
    
    // ダミーのAPI
    var myPost: MyProfileViewController.MyPosts? {
        // didSet:表示された時にpostから情報を取ってきてUIを勝手にを更新する
        didSet {
            // 画面が表示された時に発動する
            updateUI()
        }
    }
    
    // private:このファイル内でしか使えないfuncの時
    private func updateUI() {
        let postcolor = myPost!.color
        
        // この中に書いていくことがページが表示された時に画面上に映るもの
        if let userDefaults = userDefaults {
            let userName = userDefaults.string(forKey: "username")!
            let profileimage = userDefaults.string(forKey: "profileimage")
            let displayName = userDefaults.string(forKey: "displayname")
            
            if profileimage == "Default" {
                userProfileImage.image = UIImage(named: "defaultProfileImage")
            } else {
                let profileImageUrlString = "https://www.actbind.com/" + userName + "/profile-image/" + profileimage!
                let userProfileImageURL = URL(string: profileImageUrlString)!
                Nuke.loadImage(with: userProfileImageURL, into: userProfileImage)
            }
            
            nameLabel.text = displayName
        }
        userProfileImage.cornerAll(value: 0, fulcrum: "width")
        
        postColor.backgroundColor = UIColor(named: postcolor)
        postColor.cornerAll(value: 0, fulcrum: "height")
        
        captionLabel.text = myPost?.caption
        
        if myPost!.caption == "" {
            postImageTop.constant = 0
        } else {
            postImageTop.constant = 15
        }
        
        if let userDefaults = userDefaults {
            let userName = userDefaults.string(forKey: "username")!
            
            let postImageUrlString = "https://www.actbind.com/" + userName + "/post-image/" + myPost!.color.lowercased() + "/" + myPost!.postimageUrl
            let postImageURL = URL(string: postImageUrlString)!
            Nuke.loadImage(with: postImageURL, into: postImage)
            postImage.cornerAll(value: 16, fulcrum: "")
        }
        
        if let userDefaults = userDefaults {
            // userDefaultsに保存された値の取得
            let likepostidArray: [Int] = userDefaults.array(forKey: "likepostid") as! [Int]
            
            if likepostidArray.contains(myPost!.postId) {
                heartButton.setImage(UIImage(named: "heart"), for: .normal)
                heart = "On"
            } else {
                heartButton.setImage(UIImage(named: "heart mono"), for: .normal)
                heart = "Off"
            }
        }
        
        let postdate = myPost!.createDate.stringToDate(format: "yyyy-MM-dd HH:mm:ss")
        postDateLabel.text = postdate.postDateNotationChange()
    }
    
    @IBAction func heartButtonTouchUpInside(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        if let userDefaults = userDefaults {
            let userId = userDefaults.integer(forKey: "userid")
            
            if heart == "Off" {
                delegate?.apiLikePost(userId: userId, postId: myPost!.postId)
                
                heartButton.setImage(UIImage(named: "heart"), for: .normal)
                heart = "On"
            } else {
                delegate?.apiLikeIdGet(userId: userId, postId: myPost!.postId)
                
                heartButton.setImage(UIImage(named: "heart mono"), for: .normal)
                heart = "Off"
            }
        }
    }
    
    @IBAction func goColorTagSearchButtonTouchUpInside(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        delegate?.goColorTagSearch(color: myPost!.color)
    }
    
    @IBAction func postMenuButtonTouchUpInside(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        if let userDefaults = userDefaults {
            let userId = userDefaults.integer(forKey: "userid")
            
            if userId == myPost!.userId {
                delegate?.deletePost(postId: myPost!.postId, deleteIndex: indexNumber)
            } else {
                delegate?.reportPost(postId: myPost!.postId)
            }
        }
    }
    
    @IBAction func goProfileButtonTouchUpInside(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        delegate?.goMyProfile(myPost!.userId)
    }
    
    @IBAction func goImageSpotlightTouchUpInside(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        if let userDefaults = userDefaults {
            let userName = userDefaults.string(forKey: "username")!
            
            let postImageUrlString = "https://www.actbind.com/" + userName + "/post-image/" + myPost!.color.lowercased() + "/" + myPost!.postimageUrl
            
            delegate?.goImageSpotlight(postImageUrlString)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
