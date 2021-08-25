//
//  CameraAndCamerarollAuthorizationViewController.swift
//  Actbind
//
//  Created by 柿本海斗 on 2021/03/21.
//

import AVFoundation
import Photos
import UIKit

final class CameraAndCamerarollAuthorizationViewController: UIViewController {
    var nextvcname = ""
    
    let userDefaults = UserDefaults(suiteName: "group.com.actbind")
    
    @IBOutlet weak var navigationBarTitle: UINavigationItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var authorizationTitleLabel: UILabel!
    @IBOutlet weak var authorizationExplanationLabel: UILabel!
    @IBOutlet weak var cameraAuthorizationButton: UIButton!
    @IBOutlet weak var camerarollAuthorizationButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBarTitle.title = "syasinn".localized()

        if let userDefaults = userDefaults {
            let myColor = userDefaults.string(forKey: "mycolor")

            if myColor == "Original" {
                cancelButton.tintColor = UIColor(named: "BlackWhite")
                cameraAuthorizationButton.setTitleColor(UIColor(named: "Blue"), for: .normal)
                camerarollAuthorizationButton.setTitleColor(UIColor(named: "Blue"), for: .normal)
            } else {
                cancelButton.tintColor = UIColor(named: myColor!)
                cameraAuthorizationButton.setTitleColor(UIColor(named: myColor!), for: .normal)
                camerarollAuthorizationButton.setTitleColor(UIColor(named: myColor!), for: .normal)
            }
        }
        
        cancelButton.image = UIImage(named: "cancel")
        
        if AVCaptureDevice.authorizationStatus(for: AVMediaType.video) == .authorized {
            cameraAuthorizationButton.setTitleColor(UIColor(named: "EnabledButtonText"), for: .normal)
            cameraAuthorizationButton.isEnabled = false
        }
        
        if PHPhotoLibrary.authorizationStatus() != .notDetermined, PHPhotoLibrary.authorizationStatus() != .restricted, PHPhotoLibrary.authorizationStatus() != .denied {
            camerarollAuthorizationButton.setTitleColor(UIColor(named: "EnabledButtonText"), for: .normal)
            camerarollAuthorizationButton.isEnabled = false
        }
        
        authorizationTitleLabel.text = "actbinddesyea".localized()
        authorizationExplanationLabel.text = "actbinddesyeasetumei".localized()
        cameraAuthorizationButton.setTitle("cameraakusesu".localized(), for: .normal)
        camerarollAuthorizationButton.setTitle("cameraro-ruakusesu".localized(), for: .normal)
    }
    
    // 画面に表示される直前に呼ばれます。
    // viewDidLoadとは異なり毎回呼び出されます。
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    @IBAction func cameraAuthorizationButtonTouchDown(_ sender: Any) {
        cameraAuthorizationButton.setTitleColor(UIColor(named: "EnabledButtonText"), for: .normal)
    }
    
    @IBAction func cameraAuthorizationButtonTouchDragOutside(_ sender: Any) {
        if let userDefaults = userDefaults {
            let myColor = userDefaults.string(forKey: "mycolor")

            if myColor == "Original" {
                cameraAuthorizationButton.setTitleColor(UIColor(named: "Blue"), for: .normal)
            } else {
                cameraAuthorizationButton.setTitleColor(UIColor(named: myColor!), for: .normal)
            }
        }
    }
    
    @IBAction func cameraAuthorizationButtonTouchUpInside(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        if let userDefaults = userDefaults {
            let myColor = userDefaults.string(forKey: "mycolor")

            if myColor == "Original" {
                cameraAuthorizationButton.setTitleColor(UIColor(named: "Blue"), for: .normal)
            } else {
                cameraAuthorizationButton.setTitleColor(UIColor(named: myColor!), for: .normal)
            }
        }
        
        switch AVCaptureDevice.authorizationStatus(for: AVMediaType.video) {
        // まだアクセス許可を聞いていない
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: AVMediaType.video) { status in
                if status {
                    DispatchQueue.main.async {
                        self.cameraAuthorizationButton.setTitleColor(UIColor(named: "EnabledButtonText"), for: .normal)
                        self.cameraAuthorizationButton.isEnabled = false
                        
                        switch PHPhotoLibrary.authorizationStatus() {
                        // まだアクセス許可を聞いていない
                        case .notDetermined: break
                        // ユーザー自身にカメラへのアクセスが許可されていない
                        case .restricted: break
                        // アクセス許可されていない
                        case .denied: break
                        // アクセス許可あり
                        case .authorized:
                            let storyBoard = UIStoryboard(name: self.nextvcname, bundle: nil)
                            let nextVC = storyBoard.instantiateInitialViewController()
                            let nav = (nextVC as? UINavigationController)
                            if self.nextvcname == "PostCamera" {
                                let vc = (nav?.topViewController as! PostCameraViewController)
             
                                // 値の設定
                                vc.section = 1
                            } else if self.nextvcname == "ProfileImageCamera" {
                                let vc = (nav?.topViewController as! ProfileImageCameraViewController)
             
                                // 値の設定
                                vc.section = 1
                            }
             
                            self.present(nextVC!, animated: false) {}
                        // 一部アクセス許可あり
                        case .limited:
                            let storyBoard = UIStoryboard(name: self.nextvcname, bundle: nil)
                            let nextVC = storyBoard.instantiateInitialViewController()
                            let nav = (nextVC as? UINavigationController)
                            if self.nextvcname == "PostCamera" {
                                let vc = (nav?.topViewController as! PostCameraViewController)
             
                                // 値の設定
                                vc.section = 1
                            } else if self.nextvcname == "ProfileImageCamera" {
                                let vc = (nav?.topViewController as! ProfileImageCameraViewController)
             
                                // 値の設定
                                vc.section = 1
                            }
             
                            self.present(nextVC!, animated: false) {}
                        @unknown default:
                            break
                        }
                    }
                }
            }
        // ユーザー自身にカメラへのアクセスが許可されていない
        case .restricted:
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
        // アクセス許可されていない
        case .denied:
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
        // アクセス許可あり
        case .authorized: break
        @unknown default:
            break
        }
    }
    
    @IBAction func camerarollAuthorizationButtonTouchDown(_ sender: Any) {
        camerarollAuthorizationButton.setTitleColor(UIColor(named: "EnabledButtonText"), for: .normal)
    }
    
    @IBAction func camerarollAuthorizationButtonTouchDragOutside(_ sender: Any) {
        if let userDefaults = userDefaults {
            let myColor = userDefaults.string(forKey: "mycolor")

            if myColor == "Original" {
                camerarollAuthorizationButton.setTitleColor(UIColor(named: "Blue"), for: .normal)
            } else {
                camerarollAuthorizationButton.setTitleColor(UIColor(named: myColor!), for: .normal)
            }
        }
    }
    
    @IBAction func camerarollAuthorizationButtonTouchUpInside(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        if let userDefaults = userDefaults {
            let myColor = userDefaults.string(forKey: "mycolor")

            if myColor == "Original" {
                camerarollAuthorizationButton.setTitleColor(UIColor(named: "Blue"), for: .normal)
            } else {
                camerarollAuthorizationButton.setTitleColor(UIColor(named: myColor!), for: .normal)
            }
        }
        
        switch PHPhotoLibrary.authorizationStatus() {
        // まだアクセス許可を聞いていない
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { status in
                if status == .authorized {
                    DispatchQueue.main.async {
                        self.camerarollAuthorizationButton.setTitleColor(UIColor(named: "EnabledButtonText"), for: .normal)
                        self.camerarollAuthorizationButton.isEnabled = false
                        
                        switch AVCaptureDevice.authorizationStatus(for: AVMediaType.video) {
                        // まだアクセス許可を聞いていない
                        case .notDetermined: break
                        // ユーザー自身にカメラへのアクセスが許可されていない
                        case .restricted: break
                        // アクセス許可されていない
                        case .denied: break
                        // アクセス許可あり
                        case .authorized:
                            let storyBoard = UIStoryboard(name: self.nextvcname, bundle: nil)
                            let nextVC = storyBoard.instantiateInitialViewController()
                            let nav = (nextVC as? UINavigationController)
                            if self.nextvcname == "PostCamera" {
                                let vc = (nav?.topViewController as! PostCameraViewController)
             
                                // 値の設定
                                vc.section = 1
                            } else if self.nextvcname == "ProfileImageCamera" {
                                let vc = (nav?.topViewController as! ProfileImageCameraViewController)
             
                                // 値の設定
                                vc.section = 1
                            }
             
                            self.present(nextVC!, animated: false) {}
                        @unknown default:
                            break
                        }
                    }
                }
            }
            
        // ユーザー自身にカメラへのアクセスが許可されていない
        case .restricted:
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
        // アクセス許可されていない
        case .denied:
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
        // アクセス許可あり
        case .authorized: break
        // 一部アクセス許可あり
        case .limited: break
        
        @unknown default:
            break
        }
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        UISelectionFeedbackGenerator().selectionChanged()
        
        dismiss(animated: true, completion: nil)
    }
}
