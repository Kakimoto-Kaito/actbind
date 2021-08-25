//
//  WelcomeTableViewCell.swift
//  Actbind
//
//  Created by 柿本海斗 on 2021/07/08.
//

import UIKit

final class WelcomeTableViewCell: UITableViewCell {
    @IBOutlet weak var cellViewTop: NSLayoutConstraint!
    @IBOutlet weak var welcomeLabel: UILabel!
    
    // ダミーのAPI
    var welcome: Welcome! {
        // didSet:表示された時にpostから情報を取ってきてUIを勝手にを更新する
        didSet {
            // 画面が表示された時に発動する
            updateUI()
        }
    }
    
    func cellNumber() {
        if HomeViewController.allPosts.count == 0 {
            cellViewTop.constant = 20
        } else {
            cellViewTop.constant = 0
        }
    }
    
    private func updateUI() {
        welcomeLabel.text = welcome.text
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
