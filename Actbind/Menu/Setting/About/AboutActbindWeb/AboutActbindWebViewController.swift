//
//  AboutActbindWebViewController.swift
//  Actbind
//
//  Created by 柿本海斗 on 2021/02/16.
//

import UIKit
import WebKit

final class AboutActbindWebViewController: UIViewController, UIScrollViewDelegate, UIGestureRecognizerDelegate {
    let userDefaults = UserDefaults(suiteName: "group.com.actbind")
    
    var weburl = ""
    
    @IBOutlet weak var navigationBarTitle: UINavigationItem!
    @IBOutlet weak var webView: WKWebView!
    var progressView = UIProgressView()
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var safariButton: UIBarButtonItem!
    @IBOutlet weak var leftButton: UIBarButtonItem!
    @IBOutlet weak var reLoadButton: UIBarButtonItem!
    @IBOutlet weak var rightButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
        webView.scrollView.delegate = self
        
        if let userDefaults = userDefaults {
            var myColor = userDefaults.string(forKey: "mycolor")
            
            if myColor == nil {
                myColor = "Original"
            }

            if myColor == "Original" {
                cancelButton.tintColor = UIColor(named: "BlackWhite")
                safariButton.tintColor = UIColor(named: "BlackWhite")
                leftButton.tintColor = UIColor(named: "BlackWhite")
                reLoadButton.tintColor = UIColor(named: "BlackWhite")
                rightButton.tintColor = UIColor(named: "BlackWhite")
            } else {
                cancelButton.tintColor = UIColor(named: myColor!)
                safariButton.tintColor = UIColor(named: myColor!)
                leftButton.tintColor = UIColor(named: myColor!)
                reLoadButton.tintColor = UIColor(named: myColor!)
                rightButton.tintColor = UIColor(named: myColor!)
            }
        }
        
        let systemButtonConfig = UIImage.SymbolConfiguration(pointSize: 32, weight: .bold, scale: .default)
        
        cancelButton.image = UIImage(named: "cancel")
        
        safariButton.image = UIImage(systemName: "safari", withConfiguration: systemButtonConfig)
        leftButton.image = UIImage(systemName: "arrow.left", withConfiguration: systemButtonConfig)
        reLoadButton.image = UIImage(systemName: "arrow.clockwise", withConfiguration: systemButtonConfig)
        rightButton.image = UIImage(systemName: "arrow.right", withConfiguration: systemButtonConfig)
        
        progressView = UIProgressView(frame: CGRect(x: 0.0, y: (navigationController?.navigationBar.frame.size.height)! - 3.0, width: view.frame.size.width, height: 3.0))
        progressView.progressViewStyle = .bar
        if let userDefaults = userDefaults {
            let myColor = userDefaults.string(forKey: "mycolor")

            if myColor == "Original" {
                progressView.progressTintColor = UIColor(named: "Blue")
            } else {
                progressView.progressTintColor = UIColor(named: myColor!)
            }
        }
        navigationController?.navigationBar.addSubview(progressView)
        
        webView.allowsBackForwardNavigationGestures = true
        
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        webView.addObserver(self, forKeyPath: "loading", options: .new, context: nil)
        
        guard let url = URL(string: weburl) else { return }
        webView.load(URLRequest(url: url, cachePolicy: .reloadRevalidatingCacheData, timeoutInterval: 10.0))
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
    
    deinit {
        self.webView.removeObserver(self, forKeyPath: "estimatedProgress", context: nil)
        self.webView.removeObserver(self, forKeyPath: "loading", context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
        if webView.url != nil {
            let urlComponent = NSURLComponents(string: webView.url!.absoluteString)
            navigationBarTitle.title = urlComponent!.host
        }
        
        if keyPath == "estimatedProgress" {
            progressView.alpha = 1.0
            progressView.setProgress(Float(webView.estimatedProgress), animated: true)
            
            if webView.estimatedProgress >= 1.0 {
                UIView.animate(withDuration: 0.3,
                               delay: 0.3,
                               options: [.curveEaseOut],
                               animations: { [weak self] in
                                   self?.progressView.alpha = 0.0
                               },
                               completion: { (_: Bool) in
                                   self.progressView.setProgress(0.0, animated: false)
                                   self.navigationBarTitle.title = self.webView.title
                                   if self.navigationBarTitle.title == "" {
                                       self.navigationBarTitle.title = "era-".localized()
                                 
                                       let generator = UINotificationFeedbackGenerator()
                                       generator.notificationOccurred(.error)
                                   }
                               })
            }
        }
    }
    
    @IBAction func safariOpenButton(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        let myURL = URL(string: webView.url!.absoluteString)
        UIApplication.shared.open(myURL!)
    }
    
    @IBAction func leftButtonAction(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        webView.goBack()
    }
    
    @IBAction func reLoadButtonAction(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        webView.reload()
    }
    
    @IBAction func rightButtonAction(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        webView.goForward()
    }

    @IBAction func cancelButtonAction(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        dismiss(animated: true, completion: nil)
    }
}
