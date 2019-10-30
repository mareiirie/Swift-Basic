//
//  AppDelegate.swift
//  2-5-9
//
//  Created by 入江真礼 on 2019/10/23.
//  Copyright © 2019 入江真礼. All rights reserved.
//
import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        print(#function)
        
        if #available(iOS 10.0, *) {
            
            let center = UNUserNotificationCenter.current()
            center.delegate = self
            center.requestAuthorization(options: [.badge, .sound, .alert], completionHandler: { (granted, error) in
                if error != nil {
                    print(error?.localizedDescription)
                    return
                }
                
                if granted {
                    //利用許可
                    application.registerForRemoteNotifications()
                }
            })
        } else {
            print("iOS9以下の処理")
        }
        
        return true
    }
    
    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print(#function)
        
        var token = String(format: "%@", deviceToken as CVarArg) as String
        let characterSet: CharacterSet = CharacterSet.init(charactersIn: "<>")
        token = token.trimmingCharacters(in: characterSet)
        token = token.replacingOccurrences(of: " ", with: "")
        
        //本来は、APIでサーバーへ通知する
        print("deviceToken: \(token)")
    }
    
    func application(_ application: UIApplication,
                     didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print(#function)
        print(error)
    }
}
extension AppDelegate: UNUserNotificationCenterDelegate {
    
    // フォアグランドでもアラートを表示する
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        print(#function)
        completionHandler([.badge, .sound, .alert])
    }
    
    // Pushをタップした時
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        print(#function)
        completionHandler()
    }
}
