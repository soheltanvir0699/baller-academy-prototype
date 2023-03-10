//
//  AppDelegate.swift
//  FigmaPrototypeTest
//
//  Created by Sohel Rana on 10/1/23.
//

import UIKit
import UXCam
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
//        UIApplication.shared.isStatusBarHidden = true
        UIApplication.shared.isStatusBarHidden = true
        let configuration = UXCamConfiguration(appKey: "qae4p7q49gpet2w")
        IQKeyboardManager.shared.enable = true
        //Example
        configuration.enableAutomaticScreenNameTagging = false // default is set to true
        configuration.enableAdvancedGestureRecognition = false // default is set to true
        UXCam.optIntoSchematicRecordings()
        UXCam.start(with: configuration)
        return true
    }

    // MARK: UISceneSession Lifecycle

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

