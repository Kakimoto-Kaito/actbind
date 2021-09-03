//
//  PostSpotlightTableViewCell.swift
//  Actbind
//
//  Created by 柿本海斗 on 2021/08/19.
//

import Nuke
import UIKit

final class PostSpotlightTableViewCell: UITableViewCell {
    let userDefaults = UserDefaults(suiteName: "group.com.actbind")
    
    var delegate: PostSpotlightViewController?
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
    
    func userData() -> PostSpotlightViewController.Users {
        let userData = PostSpotlightViewController.allUsers[PostSpotlightViewController.allUsers.count - post!.userId]
        
        return userData
    }
    
    // ダミーのAPI
    var post: PostSpotlightViewController.Posts? {
        // didSet:表示された時にpostから情報を取ってきてUIを勝手にを更新する
        didSet {
            // 画面が表示された時に発動する
            updateUI()
        }
    }
    
    // private:このファイル内でしか使えないfuncの時
    private func updateUI() {
        let postcolor = post!.color
        
        // この中に書いていくことがページが表示された時に画面上に映るもの
        if let userDefaults = userDefaults {
            let userId = userDefaults.integer(forKey: "userid")
            let userName = userDefaults.string(forKey: "username")!
            let profileimage = userDefaults.string(forKey: "profileimage")
            let displayName = userDefaults.string(forKey: "displayname")
            
            if userId == post!.userId {
                if profileimage == "Default" {
                    userProfileImage.image = UIImage(named: "defaultProfileImage")
                } else {
                    let profileImageUrlString = "https://www.actbind.com/" + userName + "/profile-image/" + profileimage!
                    let userProfileImageURL = URL(string: profileImageUrlString)!
                    Nuke.loadImage(with: userProfileImageURL, into: userProfileImage)
                }
                
                nameLabel.text = displayName
                
            } else {
                if userData().profileimageUrl == "Default" {
                    userProfileImage.image = UIImage(named: "defaultProfileImage")
                } else {
                    let profileImageUrlString = "https://www.actbind.com/" + userData().userName + "/profile-image/" + userData().profileimageUrl
                    let userProfileImageURL = URL(string: profileImageUrlString)!
                    Nuke.loadImage(with: userProfileImageURL, into: userProfileImage)
                }
                
                nameLabel.text = userData().displayName
            }
        }
        userProfileImage.cornerAll(value: 0, fulcrum: "width")
        
        postColor.backgroundColor = UIColor(named: postcolor)
        postColor.cornerAll(value: 0, fulcrum: "height")
        
        captionLabel.text = post!.caption
        
        if post!.caption == "" {
            postImageTop.constant = 0
        } else {
            postImageTop.constant = 15
        }
        
        if let userDefaults = userDefaults {
            let userId = userDefaults.integer(forKey: "userid")
            let userName = userDefaults.string(forKey: "username")!
            
            if userId == post!.userId {
                let postImageUrlString = "https://www.actbind.com/" + userName + "/post-image/" + post!.color.lowercased() + "/" + post!.postimageUrl
                let postImageURL = URL(string: postImageUrlString)!
                Nuke.loadImage(with: postImageURL, into: postImage)
                postImage.cornerAll(value: 16, fulcrum: "")
            } else {
                let postImageUrlString = "https://www.actbind.com/" + userData().userName + "/post-image/" + post!.color.lowercased() + "/" + post!.postimageUrl
                let postImageURL = URL(string: postImageUrlString)!
                Nuke.loadImage(with: postImageURL, into: postImage)
                postImage.cornerAll(value: 16, fulcrum: "")
            }
        }
        
        if let userDefaults = userDefaults {
            // userDefaultsに保存された値の取得
            let likepostidArray: [Int] = userDefaults.array(forKey: "likepostid") as! [Int]
            
            if likepostidArray.contains(post!.postId) {
                heartButton.setImage(UIImage(named: "heart"), for: .normal)
                heart = "On"
            } else {
                heartButton.setImage(UIImage(named: "heart mono"), for: .normal)
                heart = "Off"
            }
        }
        
        let postdate = post!.createDate.stringToDate(format: "yyyy-MM-dd HH:mm:ss")
        postDateLabel.text = postdate.postDateNotationChange()
    }
    
    @IBAction func heartButtonTouchUpInside(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        if let userDefaults = userDefaults {
            let userId = userDefaults.integer(forKey: "userid")
            
            if heart == "Off" {
                delegate?.apiLikePost(userId: userId, postId: post!.postId)
                
                heartButton.setImage(UIImage(named: "heart"), for: .normal)
                heart = "On"
            } else {
                delegate?.apiLikeIdGet(userId: userId, postId: post!.postId)
                
                heartButton.setImage(UIImage(named: "heart mono"), for: .normal)
                heart = "Off"
            }
        }
    }
    
    @IBAction func goColorTagSearchButtonTouchUpInside(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        delegate?.goColorTagSearch(color: post!.color)
    }
    
    @IBAction func postMenuButtonTouchUpInside(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        if let userDefaults = userDefaults {
            let userId = userDefaults.integer(forKey: "userid")
            
            if userId == post!.userId {
                delegate?.deletePost(postId: post!.postId, deleteIndex: indexNumber)
            } else {
                delegate?.reportPost(postId: post!.postId)
            }
        }
    }
    
    @IBAction func goProfileButtonTouchUpInside(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        if let userDefaults = userDefaults {
            let userId = userDefaults.integer(forKey: "userid")
            
            if userId == post!.userId {
                delegate?.goMyProfile(post!.userId)
            } else {
                delegate?.goOtherProfile(post!.userId, userName: userData().userName)
            }
        }
    }
    
    @IBAction func goImageSpotlightTouchUpInside(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        if let userDefaults = userDefaults {
            let userId = userDefaults.integer(forKey: "userid")
            let userName = userDefaults.string(forKey: "username")!
            
            if userId == post!.userId {
                let postImageUrlString = "https://www.actbind.com/" + userName + "/post-image/" + post!.color.lowercased() + "/" + post!.postimageUrl
                
                delegate?.goImageSpotlight(postImageUrlString)
            } else {
                let postImageUrlString = "https://www.actbind.com/" + userData().userName + "/post-image/" + post!.color.lowercased() + "/" + post!.postimageUrl
                
                delegate?.goImageSpotlight(postImageUrlString)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
