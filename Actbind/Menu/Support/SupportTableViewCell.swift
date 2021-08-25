//
//  SupportTableViewCell.swift
//  Actbind
//
//  Created by 柿本海斗 on 2021/08/22.
//

import UIKit

final class SupportTableViewCell: UITableViewCell {
    let userDefaults = UserDefaults(suiteName: "group.com.actbind")
    
    var delegate: SupportViewController?
    
    @IBOutlet weak var supportMethodImage: UIImageView!
    @IBOutlet weak var supportMethodTitleLabel: UILabel!
    @IBOutlet weak var supportMethodContentLabel: UILabel!
    @IBOutlet weak var supportMethodContactButton: UIButton!
    @IBOutlet weak var supportMethodContactButtonRight: NSLayoutConstraint!
    @IBOutlet weak var supportMethodContactButtonLeft: NSLayoutConstraint!
    
    // ダミーのAPI
    var supportMethod: SupportMethod! {
        // didSet:表示された時にpostから情報を取ってきてUIを勝手にを更新する
        didSet {
            // 画面が表示された時に発動する
            updateUI()
        }
    }
    
    // private:このファイル内でしか使えないfuncの時
    private func updateUI() {
        supportMethodImage.image = UIImage(named: supportMethod.image)
        
        supportMethodTitleLabel.text = supportMethod.title
        
        supportMethodContentLabel.text = supportMethod.content
        
        if let userDefaults = userDefaults {
            let myColor = userDefaults.string(forKey: "mycolor")

            if myColor == "Original" {
                supportMethodContactButton.backgroundColor = UIColor(named: "Blue")
            } else {
                supportMethodContactButton.backgroundColor = UIColor(named: myColor!)
            }
        }
        
        supportMethodContactButton.setTitle("kotirakara".localized(), for: .normal)
    }
    
    @IBAction func supportMethodContactButtonTouchDown(_ sender: Any) {
        UIButton().uiButtonTapOn(item: supportMethodContactButton, itemRight: supportMethodContactButtonRight, itemLeft: supportMethodContactButtonLeft)
    }
    
    @IBAction func supportMethodContactButtonTouchDragOutside(_ sender: Any) {
        UIButton().uiButtonTapOff(item: supportMethodContactButton, itemRight: supportMethodContactButtonRight, itemLeft: supportMethodContactButtonLeft)
    }
    
    @IBAction func supportMethodContactButtonTouchUpInside(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        UIButton().uiButtonTapOff(item: supportMethodContactButton, itemRight: supportMethodContactButtonRight, itemLeft: supportMethodContactButtonLeft)
        
        delegate?.startMailer()
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
