//
//  NotificationBannerCenter.swift
//  NotificationBanner
//
//  Created by Ankit Aggarwal on 01/09/15.
//  Copyright (c) 2015 Locon Solutions. All rights reserved.
//

import UIKit

public class NotificationBannerCenter: NSObject {
    
    let notificationWindow: UIWindow
    static public let defaultCenter = NotificationBannerCenter()
    
    override init() {
        self.notificationWindow = UIWindow(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, 68))
        //self.notificationWindow = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.notificationWindow.windowLevel = UIWindowLevelStatusBar
        self.notificationWindow.backgroundColor = UIColor.clearColor()
    }
    
    public func showNewNotification(nbModel: NBModel) {
        self.notificationWindow.subviews.map({$0.removeFromSuperview()})
        self.notificationWindow.frame = nbModel.viewToShow.bounds
        self.notificationWindow.addSubview(nbModel.viewToShow)
        self.notificationWindow.hidden = false
        
        self.notificationWindow.transform = CGAffineTransformMakeTranslation(0, -self.notificationWindow.frame.size.height)
        
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            self.notificationWindow.transform = CGAffineTransformIdentity
        })
        
        
    }
    
    func closeCurrentNotification() {
        
        let notificationView = self.notificationWindow.subviews.first as! NBView
        
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            self.notificationWindow.transform = CGAffineTransformIdentity
        })
        
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            self.notificationWindow.transform = CGAffineTransformMakeTranslation(0, -self.notificationWindow.frame.size.height)
            
            }, completion: { (Bool) -> Void in
                self.notificationWindow.transform = CGAffineTransformIdentity
                notificationView.removeFromSuperview()
                self.notificationWindow.hidden = true
        })
        
    }
   
}
