//
//  ColorTagSearchCollectionViewCell.swift
//  Actbind
//
//  Created by 柿本海斗 on 2021/08/19.
//

import Nuke
import UIKit

final class ColorTagSearchCollectionViewCell: UICollectionViewCell {
    let userDefaults = UserDefaults(suiteName: "group.com.actbind")
    
    var delegate: ColorTagSearchViewController?
    
    @IBOutlet weak var postImage: UIImageView!
    
    func userData() -> ColorTagSearchViewController.Users {
        let userData = ColorTagSearchViewController.allUsers[ColorTagSearchViewController.allUsers.count - post!.userId]
        
        return userData
    }
    
    var post: ColorTagSearchViewController.Posts? {
        // didSet:表示された時にpostから情報を取ってきてUIを勝手にを更新する
        didSet {
            // 画面が表示された時に発動する
            updateUI()
        }
    }
    
    // private:このファイル内でしか使えないfuncの時
    private func updateUI() {
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
    }
    
    @IBAction func goPostSpotlightButtonTouchUpInside(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        delegate?.goPostSpotlight(userId: post!.userId, postId: post!.postId, color: post!.color)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
