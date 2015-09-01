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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: "showNotification")
        self.view.addGestureRecognizer(tapGesture)
    }
    
    func showNotification () {
        
        let chatNotificationView = ChatNotificationView.loadFromNib()
        chatNotificationView.nameLabel.text = "Ankit Aggarwal"
        chatNotificationView.messageLabel.text = "Hey how are you how do you do I am fine ok whatever man dont kill me plzzzzz"
        chatNotificationView.thumbImageView.image = UIImage(named: "thumb")
        
        let nbModel = NBModel(context: "hey", viewToShow: chatNotificationView)
        
        defaultCenter.showNewNotification(nbModel)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
    
}

