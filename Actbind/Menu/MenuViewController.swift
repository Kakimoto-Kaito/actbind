//
//  MenuViewController.swift
//  Actbind
//
//  Created by 柿本　海斗 on 2020/11/28.
//

import Nuke
import UIKit

final class MenuViewController: UIViewController {
    let userDefaults = UserDefaults(suiteName: "group.com.actbind")

    var menu = Menu.allMenu

    @IBOutlet weak var navigationBarTitle: UINavigationItem!
    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var menuTableView: UITableView!

    var dayHour = ""
    private var isLoaded: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
            let name1 = userDefaults.string(forKey: "name1")
            let name2 = userDefaults.string(forKey: "name2")
            
            if profileimage == "Default" {
                userProfileImage.image = UIImage(named: "defaultProfileImage")
            } else {
                let profileImageUrlString = "https://www.actbind.com/" + userName + "/profile-image/" + profileimage!
                let userProfileImageURL = URL(string: profileImageUrlString)!
                Nuke.loadImage(with: userProfileImageURL, into: userProfileImage)
            }
            
            userNameLabel.text = "@" + username!
            nameLabel.text = name1! + " " + name2!
        }
    }

    @IBAction func profileButtonTouchUpInside(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        let storyBoard = UIStoryboard(name: "MyProfile", bundle: nil)
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

    @IBAction func decorationButtonTouchUpInside(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        let storyBoard = UIStoryboard(name: "Decoration", bundle: nil)
        let nextVC = storyBoard.instantiateInitialViewController()
        
        navigationController?.pushViewController(nextVC!, animated: true)
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

// extensionは何かを追加していく ViewControllerというクラスの中にUITableViewDataSource機能を追加していく
extension MenuViewController: UITableViewDataSource {
    // tableviewの中に何個のセクションを追加するか
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    // 一つのtableviewの中に何個のセルが必要か
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        menu.count
    }
    
    // tavleviewの中で使われているセルの特定
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath) as! MenuTableViewCell
        
        // ここからの内容がセルに反映される
        // 順番にcellの方のpostに送っていく
        cell.menu = menu[indexPath.row]
        // ここまで
        return cell
    }
}
