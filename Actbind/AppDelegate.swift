//
//  AppDelegate.swift
//  Actbind
//
//  Created by 柿本海斗 on 2021/03/09.
//

import FBAudienceNetwork
import GoogleMobileAds
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    // アプリを起動したとき
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FBAdSettings.setAdvertiserTrackingEnabled(true)
        // Mobile Ads SDK を初期化
        // GADMobileAds.sharedInstance().start(completionHandler: nil)
        
        let ads = GADMobileAds.sharedInstance()
        ads.start { status in
            // Optional: Log each adapter's initialization latency.
            let adapterStatuses = status.adapterStatusesByClassName
            for adapter in adapterStatuses {
                let adapterStatus = adapter.value
                NSLog("Adapter Name: %@, Description: %@, Latency: %f", adapter.key,
                      adapterStatus.description, adapterStatus.latency)
            }

            // Start loading ads here...
        }

        // LaunchScreenを一秒間表示
        sleep(1)
        
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    // Sceneを呼び出し中
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    // アプリを閉じたとき
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}
