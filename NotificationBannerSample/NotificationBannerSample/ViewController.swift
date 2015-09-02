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
    var i = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addNotification(sender: AnyObject) {
        i = i + 1
        
        let chatNotificationView = ChatNotificationView.loadFromNib()
        chatNotificationView.nameLabel.text = "John Doe"
        chatNotificationView.messageLabel.text =  "\(i) Hey, My name is John Doe!"
        chatNotificationView.thumbImageView.image = UIImage(named: "johndoe.jpg")
        chatNotificationView.context = "\(i)"
        
        notificationCenter.enQueueNotification(chatNotificationView)
    }
    
    @IBAction func cancelEvenNotification(sender: AnyObject) {
        
    }
    
    @IBAction func cancelOddNotification(sender: AnyObject) {
        
    }
}

