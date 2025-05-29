//
//  NotificationViewController.swift
//  MDMNotificationContent
//
//  Created by Juan Franceschi on 29/05/25.
//

// import UIKit
// import UserNotifications
// import UserNotificationsUI
import MDMNotification

class NotificationViewController: MDMNotificationViewController {

    @IBOutlet var label: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any required interface initialization here.
    }
    
    override func didReceive(_ notification: UNNotification) {
        self.isHandsPush = MDMNotification.isMDMNotification(notification.request.content.userInfo)
        
        MDMCore.setDebugMode(true)

        if self.isHandsPush {
            super.didReceive(notification)
        } else {
            // Your code here
        }
    }
    
    override func didReceive(_ response: UNNotificationResponse, completionHandler completion: @escaping (UNNotificationContentExtensionResponseOption) -> Void) {
        MDMCore.setDebugMode(true)
        
        if self.isHandsPush {
            super.didReceive(response, completionHandler: completion)
        } else {
            // Your code here
        }
        
    }

}
