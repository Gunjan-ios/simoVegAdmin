//
//  AppDelegate.swift
//  Simo Vegetables
//
//  Created by Apple on 29/12/20.
//  Copyright © 2020 Gunjan. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var open_count : Int!
    var window : UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = true

        self.window = UIWindow(frame: UIScreen.main.bounds)
        if #available(iOS 13.0, *) {
            window?.overrideUserInterfaceStyle = .light
        }

        let str = ParentClass.sharedInstance.getJSON(CS.Saved.userData)

        if IS_IPHONE_X_XR_XMAX_12{
            ParentClass.sharedInstance.iPhone_X_Bottom_Padding = 20
        }
        STATUS_BAR_HEIGHT = IS_IPHONE_X_XR_XMAX_12 ? 44 : 20

        print(STATUS_BAR_HEIGHT)
        
        if str != nil{
            let data = User (fromJson:str)
            if data.userId != nil{
                let navigation : UINavigationController!
                navigation = UINavigationController (rootViewController: ParentClass.sharedInstance.customBouncesStyle())
                navigation.isNavigationBarHidden = true
//                self.window!.rootViewController = navigation
                self.window!.makeKeyAndVisible()
                self.window?.canResizeToFitContent = true
                self.window?.rootViewController?.addChild(navigation)
            }
        }
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

