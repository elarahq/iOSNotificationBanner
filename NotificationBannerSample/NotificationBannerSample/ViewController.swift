//
//  ViewController.swift
//  NotificationBannerSample
//
//  Created by Ankit Aggarwal on 01/09/15.
//  Copyright (c) 2015 Locon Solutions. All rights reserved.
//

import UIKit
import NotificationBanner

class ViewController: UIViewController {
    
    let notificationCenter = NotificationBannerCenter.defaultCenter
    var num = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addNotification(sender: AnyObject) {
        num = num + 1
        
        let chatNotificationView = ChatNotificationView.loadFromNib()
        chatNotificationView.nameLabel.text = "John Doe"
        chatNotificationView.messageLabel.text =  "\(num) Hey, My name is John Doe!"
        chatNotificationView.thumbImageView.image = UIImage(named: "johndoe.jpg")
        chatNotificationView.context = "\(num)"
        chatNotificationView.tapClosure = { (nbView: NBView) in
            println((nbView as! ChatNotificationView).messageLabel.text)
        }
        
        notificationCenter.enQueueNotification(chatNotificationView)
    }
    
    @IBAction func cancelEvenNotification(sender: AnyObject) {
        var contexts: [String] = []
        for i in 0...num {
            if i % 2 == 0 {
                contexts.append("\(i)")
            }
        }
        notificationCenter.cancelNotificationsWithContexts(contexts)
    }
    
    @IBAction func cancelOddNotification(sender: AnyObject) {
        var contexts: [String] = []
        for i in 0...num {
            if i % 2 != 0 {
                contexts.append("\(i)")
            }
        }
        notificationCenter.cancelNotificationsWithContexts(contexts)
    }
}

