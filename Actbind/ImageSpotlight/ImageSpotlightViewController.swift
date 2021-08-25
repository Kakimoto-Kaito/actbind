//
//  ImageSpotlightViewController.swift
//  Actbind
//
//  Created by 柿本海斗 on 2021/02/24.
//

import Nuke
import UIKit

class ImageSpotlightViewController: UIViewController {
    let userDefaults = UserDefaults(suiteName: "group.com.actbind")
    
    var spotlightimage: UIImage?
    var postImageUrlString = ""
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var spotLightImageView: UIImageView!
    @IBOutlet weak var cancelButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let userDefaults = userDefaults {
            let myColor = userDefaults.string(forKey: "mycolor")
            
            if myColor == "Original" {
                cancelButton.tintColor = UIColor(named: "BlackWhite")
            } else {
                cancelButton.tintColor = UIColor(named: myColor!)
            }
        }
        
        cancelButton.setImage(UIImage(named: "cancel"), for: .normal)
        
        if postImageUrlString == "" {
            backgroundImageView.image = spotlightimage
            spotLightImageView.image = spotlightimage
        } else {
            let postImageURL = URL(string: postImageUrlString)!
            Nuke.loadImage(with: postImageURL, into: backgroundImageView)
            Nuke.loadImage(with: postImageURL, into: spotLightImageView)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if toHomeView == "on" {
            let UINavigationController = tabBarController?.viewControllers?[0]
            tabBarController?.selectedViewController = UINavigationController
        }
    }
    
    @IBAction func cancelBurronTouchUpInside(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        dismiss(animated: true, completion: nil)
    }
}
