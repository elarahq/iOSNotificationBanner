//
//  ChatNotificationView.swift
//  NotificationBannerSample
//
//  Created by Ankit Aggarwal on 01/09/15.
//  Copyright (c) 2015 Locon Solutions. All rights reserved.
//

import UIKit
import NotificationBanner

class ChatNotificationView: NBView {

    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    @IBAction func crossButtonPressed(sender: AnyObject) {
        self.closeNotification()
    }
    
    static func loadFromNib() -> ChatNotificationView {
        let view = NSBundle.mainBundle().loadNibNamed("ChatNotificationView", owner: self, options: nil).first as! ChatNotificationView
        view.frame.size.width = UIScreen.mainScreen().bounds.size.width
        
        view.backgroundColor = UIColor.clearColor()
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds

        view.insertSubview(blurEffectView, atIndex: 0)

        return view
    }
}
