//
//  File.swift
//  14_TaskManager
//
//  Created by shota ito on 25/11/2018.
//  Copyright © 2018 shota ito. All rights reserved.
//

import Foundation
import UserNotifications

class LocalPushManager: NSObject {
    static var shared = LocalPushManager()
    let center = UNUserNotificationCenter.current()

    func requestAuthorization(){
        center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            if error == nil {
                print("permission granted")
            }
        }
    }
    
    func sendLocalPush(in time: TimeInterval){
        
        // local push content
        let content = UNMutableNotificationContent()
        content.title = NSString.localizedUserNotificationString(forKey: "Time to focus!", arguments: nil)
        content.body = NSString.localizedUserNotificationString(forKey: "You can change", arguments: nil)
        
        // trigger
        let date = DateComponents(hour:8, minute:0)
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
        
        let request = UNNotificationRequest(identifier: "Timer", content: content, trigger: trigger)
        
        center.add(request) { (error) in
            if error == nil {
                print("schedule push succeed")
            }
        }
        
    }
    
}

