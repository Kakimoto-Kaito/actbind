//
//  OtherProfileNoPostTableViewCell.swift
//  Actbind
//
//  Created by 柿本海斗 on 2021/07/17.
//

import UIKit

final class OtherProfileNoPostTableViewCell: UITableViewCell {
    @IBOutlet weak var defaultImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    // ダミーのAPI
    var noPost: OtherProfileNoPost! {
        // didSet:表示された時にpostから情報を取ってきてUIを勝手にを更新する
        didSet {
            // 画面が表示された時に発動する
            updateUI()
        }
    }
    
    private func updateUI() {
        defaultImage.image = noPost.image
        titleLabel.text = noPost.text
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
