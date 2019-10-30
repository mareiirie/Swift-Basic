//
//  NotificationService.swift
//  NotificationDemo
//
//  Created by 入江真礼 on 2019/10/23.
//  Copyright © 2019 入江真礼. All rights reserved.
//
import UserNotifications

@available(iOSApplicationExtension 10.0, *)
class NotificationService: UNNotificationServiceExtension {
    
    let imageKey = "image-url"
    
    var contentHandler: ((UNNotificationContent) -> Void)?
    var bestAttemptContent: UNMutableNotificationContent?
    
    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        
        self.contentHandler = contentHandler
        bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)
        
        if let imageUrl = request.content.userInfo[imageKey] as? String {
            
            let session = URLSession(configuration: URLSessionConfiguration.default)
            let task = session.dataTask(with: URL(string: imageUrl)!, completionHandler: {[weak self](data, response, error) in
                do {
                    if let writePath = NSURL(fileURLWithPath:NSTemporaryDirectory())
                        .appendingPathComponent("tmp.jpg") {
                        try data?.write(to: writePath)
                        
                        let identifier = "sdt"
                        
                        if let bestAttemptContent = self?.bestAttemptContent {
                            let attachment = try UNNotificationAttachment(identifier: identifier, url: writePath, options: nil)
                            bestAttemptContent.attachments = [attachment]
                            contentHandler(bestAttemptContent)
                        }
                    } else {
                        // URLが不正な場合
                        if let bestAttemptContent = self?.bestAttemptContent {
                            contentHandler(bestAttemptContent)
                        }
                    }
                } catch let error as NSError {
                    print(error.localizedDescription)
                    
                    if let bestAttemptContent = self?.bestAttemptContent {
                        contentHandler(bestAttemptContent)
                    }
                }
            })
            task.resume()
        } else {
            if let bestAttemptContent = self.bestAttemptContent {
                contentHandler(bestAttemptContent)
            }
        }
    }
}
