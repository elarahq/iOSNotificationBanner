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
    let defaultCenter = NotificationBannerCenter.defaultCenter
    var i = 0;
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: "showNotification")
        self.view.addGestureRecognizer(tapGesture)
    }
    
    func showNotification () {
        
        let chatNotificationView = ChatNotificationView.loadFromNib()
        chatNotificationView.nameLabel.text = "Ankit Aggarwal"
        
        i = i + 1
        
        chatNotificationView.messageLabel.text =  "\(i) Hey how are you how do you do I am fine ok whatever man dont kill me plzzzzz"
        chatNotificationView.thumbImageView.image = UIImage(named: "thumb")
        
        defaultCenter.enQueueNotification(chatNotificationView)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
    
}

