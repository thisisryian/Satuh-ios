//
//  NotificationManager.swift
//  cobra-iOS
//
//  Created by DickyChengg on 6/7/17.
//  Copyright © 2017 DickyChengg. All rights reserved.
//

import UIKit
import UserNotifications
import AudioToolbox

extension DSource {
    
    public class Notification {
        
        public static var shared: XNotificationView!
        
        public class func register(application: UIApplication) {
            if #available(iOS 10.0, *) {
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (status, error) in
                    debug(key: "UNUserNotification status", status)
                    debug(key: "UNUserNotification error", error)
                    if status {
                        DispatchQueue.main.async {
                            application.registerForRemoteNotifications()
                        }
                    }
                }
            } else {
                let pushNotifSetting = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
                application.registerUserNotificationSettings(pushNotifSetting)
                DispatchQueue.main.async {
                    application.registerForRemoteNotifications()
                }
            }
        }
        
        public class func playSound(_ sound: SystemSoundEn = .receiveMail1) {
            AudioServicesPlaySystemSound(SystemSoundID(sound.rawValue))
        }
        
        public class func present(title: String, subTitle: String? = nil, detail: String, image: String? = nil, duration: TimeInterval = 3, onClick: @escaping (()->Void)) {
            guard Notification.shared == nil else { return }
            Notification.shared = XNotificationView()
            Notification.shared.initialize(title, subTitle, detail, image)
            Notification.shared.action = onClick
            Notification.shared.present(duration: duration)
        }
        
    }
    
}
