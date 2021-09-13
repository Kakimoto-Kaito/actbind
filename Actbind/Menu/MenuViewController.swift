//
//  MenuViewController.swift
//  Actbind
//
//  Created by 柿本　海斗 on 2020/11/28.
//

import GoogleMobileAds
import Nuke
import StoreKit
import UIKit

final class MenuViewController: UIViewController {
    let userDefaults = UserDefaults(suiteName: "group.com.actbind")

    @IBOutlet weak var navigationBarTitle: UINavigationItem!
    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var menuTableView: UITableView!
    
    @IBOutlet weak var decorationTextLabel: UILabel!
    @IBOutlet weak var decorationImage: UIImageView!
    @IBOutlet weak var inotiwomamoruText: UILabel!
    @IBOutlet weak var inotiwomamoruImage: UIImageView!
    @IBOutlet weak var activityText: UILabel!
    @IBOutlet weak var activityImage: UIImageView!
    @IBOutlet weak var houkokuText: UILabel!
    @IBOutlet weak var houkokuImage: UIImageView!
    @IBOutlet weak var reviewText: UILabel!
    @IBOutlet weak var reviewImage: UIImageView!
    @IBOutlet weak var supportText: UILabel!
    @IBOutlet weak var supportImage: UIImageView!
    @IBOutlet weak var setteiText: UILabel!
    @IBOutlet weak var setteiImage: UIImageView!
    @IBOutlet weak var roguautoText: UILabel!
    @IBOutlet weak var roguautoImage: UIImageView!
    @IBOutlet weak var adsLabel1: UILabel!
    @IBOutlet weak var adsLabel2: UILabel!
    
    @IBOutlet weak var bannerView1: GADBannerView!
    @IBOutlet weak var bannerView2: GADBannerView!
    
    var dayHour = ""
    private var isLoaded: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bannerView1.adUnitID = "ca-app-pub-1654242573513407/5125736656"
        bannerView1.rootViewController = self
        // 広告読み込み
        bannerView1.load(GADRequest())
        
        bannerView2.adUnitID = "ca-app-pub-1654242573513407/5079109979"
        bannerView2.rootViewController = self
        // 広告読み込み
        bannerView2.load(GADRequest())
        
        // 今の時間
        dayHour = Date().dateToString(format: "HH")
        let hourInt = Int(dayHour)!

        if "language".localized() == "Japanese" {
            if 5 ... 10 ~= hourInt {
                navigationBarTitle.title = "ohayou".localized()
            } else if 11 ... 18 ~= hourInt {
                navigationBarTitle.title = "konnnitiha".localized()
            } else {
                navigationBarTitle.title = "konnbannha".localized()
            }
        } else {
            if 5 ... 11 ~= hourInt {
                navigationBarTitle.title = "ohayou".localized()
            } else if 12 ... 18 ~= hourInt {
                navigationBarTitle.title = "konnnitiha".localized()
            } else {
                navigationBarTitle.title = "konnbannha".localized()
            }
        }
        
        userProfileImage.cornerAll(value: 0, fulcrum: "width")
        
        decorationTextLabel.text = "dekore-syonn".localized()
        decorationImage.image = UIImage(named: "decoration")
        inotiwomamoruText.text = "inotiwomamoru".localized()
        inotiwomamoruImage.image = UIImage(named: "life-shield")
        activityText.text = "akuthibithi".localized()
        if let userDefaults = userDefaults {
            let myColor = userDefaults.string(forKey: "mycolor")
            
            if myColor == "Original" {
                activityImage.image = UIImage(named: "activity" + "Blue")
            } else {
                activityImage.image = UIImage(named: "activity" + myColor!)
            }
        }
        houkokuText.text = "monndaiwohoukoku".localized()
        houkokuImage.image = UIImage(named: "houkoku")
        reviewText.text = "hyouka".localized()
        reviewImage.image = UIImage(named: "wakaba")
        supportText.text = "sapo-to".localized()
        supportImage.image = UIImage(named: "support")
        setteiText.text = "settei".localized()
        setteiImage.image = UIImage(named: "setting")
        setteiImage.tintColor = UIColor.lightGray
        roguautoText.text = "roguauto".localized()
        roguautoImage.image = UIImage(named: "logout")
        roguautoImage.tintColor = UIColor.darkGray
        
        adsLabel1.text = "koukoku".localized()
        adsLabel2.text = "koukoku".localized()
    }
    
    // 画面に表示される直前に呼ばれます。
    // viewDidLoadとは異なり毎回呼び出されます。
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if toHomeView == "on" {
            let UINavigationController = tabBarController?.viewControllers?[0]
            tabBarController?.selectedViewController = UINavigationController
        }

        isLoaded = true
        
        if let userDefaults = userDefaults {
            let userName = userDefaults.string(forKey: "username")!
            let profileimage = userDefaults.string(forKey: "profileimage")
            let username = userDefaults.string(forKey: "username")
            let displayName = userDefaults.string(forKey: "displayname")
            
            if profileimage == "Default" {
                userProfileImage.image = UIImage(named: "defaultProfileImage")
            } else {
                let profileImageUrlString = "https://www.actbind.com/" + userName + "/profile-image/" + profileimage!
                let userProfileImageURL = URL(string: profileImageUrlString)!
                Nuke.loadImage(with: userProfileImageURL, into: userProfileImage)
            }
            
            userNameLabel.text = "@" + username!
            nameLabel.text = displayName
        }
    }

    @IBAction func profileButtonTouchUpInside(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        let storyBoard = UIStoryboard(name: "MyProfile", bundle: nil)
        let nextVC = storyBoard.instantiateInitialViewController()
        
        navigationController?.pushViewController(nextVC!, animated: true)
    }
    
    @IBAction func decorationButtonTouchUpInside(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        let storyBoard = UIStoryboard(name: "Decoration", bundle: nil)
        let nextVC = storyBoard.instantiateInitialViewController()
        
        navigationController?.pushViewController(nextVC!, animated: true)
    }

    @IBAction func inotiwomamoruButtonTouchUpInside(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        let storyBoard = UIStoryboard(name: "Web", bundle: nil)
        let nextVC = storyBoard.instantiateInitialViewController()
        let nav = (nextVC as? UINavigationController)
        let vc = (nav?.topViewController as! WebViewController)
        
        // 値の設定
        vc.weburl = "https://no-heart-no-sns.smaj.or.jp/"
        
        present(nextVC!, animated: true) {}
    }

    @IBAction func activityButtonTouchUpInside(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        let storyBoard = UIStoryboard(name: "Activity", bundle: nil)
        let nextVC = storyBoard.instantiateInitialViewController()
        
        navigationController?.pushViewController(nextVC!, animated: true)
    }

    @IBAction func reportButtonTouchUpInside(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        let reportProblemTitle = "monndaiwohoukoku".localized()
        let fidobakkuTitle = "fi-dobakku".localized()
        let cancelTitle = "kyannseru".localized()

        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        let reportProblemButton = UIAlertAction(title: reportProblemTitle, style: .default, handler: { _ in
            let storyBoard = UIStoryboard(name: "ReportProblem", bundle: nil)
            let nextVC = storyBoard.instantiateInitialViewController()
            
            self.present(nextVC!, animated: true) {}
        })
        let fidobakkuButton = UIAlertAction(title: fidobakkuTitle, style: .default, handler: { _ in
            let storyBoard = UIStoryboard(name: "Feedback", bundle: nil)
            let nextVC = storyBoard.instantiateInitialViewController()
            
            self.present(nextVC!, animated: true) {}
        })
        let cancelButton = UIAlertAction(title: cancelTitle, style: .cancel, handler: nil)

        alertController.view.tintColor = UIColor(named: "BlackWhite")
        alertController.addAction(reportProblemButton)
        alertController.addAction(fidobakkuButton)
        alertController.addAction(cancelButton)

        alertController.popoverPresentationController?.sourceView = view
        let screenSize = UIScreen.main.bounds
        // ここで表示位置を調整
        // xは画面中央、yは画面下部になる様に指定
        alertController.popoverPresentationController?.sourceRect = CGRect(x: screenSize.size.width / 2, y: screenSize.size.height, width: 0, height: 0)

        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func reviewButtonTouchUpInside(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        if #available(iOS 14.0, *) {
            if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                SKStoreReviewController.requestReview(in: scene)
            }
        } else {
            SKStoreReviewController.requestReview()
        }
    }
    
    @IBAction func supportButtonTouchUpInside(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        let storyBoard = UIStoryboard(name: "Support", bundle: nil)
        let nextVC = storyBoard.instantiateInitialViewController()
        
        navigationController?.pushViewController(nextVC!, animated: true)
    }
    
    @IBAction func settingButtonTouchUpInside(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        let storyBoard = UIStoryboard(name: "Setting", bundle: nil)
        let nextVC = storyBoard.instantiateInitialViewController()
        
        navigationController?.pushViewController(nextVC!, animated: true)
    }
    
    @IBAction func logoutBottonTouchUpInside(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        if let userDefaults = userDefaults {
            let username = userDefaults.string(forKey: "username")
            
            let alertTitle = String(format: "roguautosimasuka".localized(), username!)
            let logoutTitle = "roguauto".localized()
            let cancelTitle = "kyannseru".localized()

            let alertController = UIAlertController(title: alertTitle, message: nil, preferredStyle: .alert)

            let logoutButton = UIAlertAction(title: logoutTitle, style: .destructive, handler: { _ in
                userDefaults.userDefaultsRemoveAll()
                
                let storyBoard = UIStoryboard(name: "RebootToLogin", bundle: nil)
                let nextVC = storyBoard.instantiateInitialViewController()
                    
                self.present(nextVC!, animated: true) {}
            })
            let cancelButton = UIAlertAction(title: cancelTitle, style: .cancel, handler: nil)

            alertController.view.tintColor = UIColor(named: "BlackWhite")
            alertController.addAction(logoutButton)
            alertController.addAction(cancelButton)

            present(alertController, animated: true, completion: nil)
        }
    }
}

extension MenuViewController: MainViewControllerProtocol {
    func onTapScrollToTop() {
        // 一番上に移動
        if isLoaded {
            menuTableView.setContentOffset(CGPoint.zero, animated: true)
        }
    }
}
