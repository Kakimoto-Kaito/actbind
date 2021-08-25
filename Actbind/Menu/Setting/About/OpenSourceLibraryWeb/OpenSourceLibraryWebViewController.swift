//
//  AboutActbindLicenseWebViewController.swift
//  Actbind
//
//  Created by 柿本海斗 on 2021/08/22.
//

import UIKit
import WebKit

final class OpenSourceLibraryWebViewController: UIViewController, UIScrollViewDelegate, UIGestureRecognizerDelegate {
    let userDefaults = UserDefaults(suiteName: "group.com.actbind")
    
    @IBOutlet weak var navigationBarTitle: UINavigationItem!
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
        navigationBarTitle.title = "o-punnso-suraiburari".localized()
        
        webView.scrollView.delegate = self
        
        if let userDefaults = userDefaults {
            var myColor = userDefaults.string(forKey: "mycolor")
            
            if myColor == nil {
                myColor = "Original"
            }

            if myColor == "Original" {
                cancelButton.tintColor = UIColor(named: "BlackWhite")
            } else {
                cancelButton.tintColor = UIColor(named: myColor!)
            }
        }
        
        cancelButton.image = UIImage(named: "cancel")
        
        let myURL = URL(fileURLWithPath:
            Bundle.main.path(forResource: "OpenSourceLibrary", ofType: "html")!) as URL?
        webView.load(URLRequest(url: myURL!, cachePolicy: .reloadRevalidatingCacheData, timeoutInterval: 10.0))
    }
    
    // 画面に表示される直前に呼ばれます。
    // viewDidLoadとは異なり毎回呼び出されます。
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if toHomeView == "on" {
            let UINavigationController = tabBarController?.viewControllers?[0]
            tabBarController?.selectedViewController = UINavigationController
        }
    }
    
    func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
        scrollView.pinchGestureRecognizer?.isEnabled = false
    }

    @IBAction func cancelButtonAction(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        dismiss(animated: true, completion: nil)
    }
}
