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
    var notificationQueue: Array<NBModel> = []
    var isShowing: Bool = false
    var currentDequeuingNotification: NBModel?
    
    override init() {
        self.notificationWindow = UIWindow(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, 68))
        //self.notificationWindow = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.notificationWindow.windowLevel = UIWindowLevelStatusBar
        self.notificationWindow.backgroundColor = UIColor.clearColor()
    }
    
    public func enQueueNotification(nbModel: NBModel) {
        self.notificationQueue.append(nbModel)
        self.dequeueNotifications()
    }
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
    func dequeueNotifications() {
        
        if(!(notificationQueue.count > 0) || self.isShowing) {
            return;
        }
        
        self.isShowing = true
        
        let nbModel = notificationQueue.removeAtIndex(0)
        self.currentDequeuingNotification = nbModel
        self.notificationWindow.frame = nbModel.viewToShow.bounds
        self.notificationWindow.addSubview(nbModel.viewToShow)
        self.notificationWindow.hidden = false
        
        self.notificationWindow.transform = CGAffineTransformMakeTranslation(0, -self.notificationWindow.frame.size.height)
        
        UIView.animateWithDuration(0.4, animations: { () -> Void in
            self.notificationWindow.transform = CGAffineTransformIdentity
            }, completion: { (Bool) -> Void in
                
                self.delay(2) {
                    self.closeNotification(nbModel)
                }
        })
    }
    
    func closeCurrentNotification() {
        if let currentNotif = self.currentDequeuingNotification {
            self.currentDequeuingNotification = nil
            
            let notificationView = currentNotif.viewToShow //self.notificationWindow.subviews.first as! NBView
            
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                self.notificationWindow.transform = CGAffineTransformMakeTranslation(0, -self.notificationWindow.frame.size.height)
                
                }, completion: { (Bool) -> Void in
                    self.notificationWindow.transform = CGAffineTransformIdentity
                    notificationView.removeFromSuperview()
                    self.notificationWindow.hidden = true
                    self.isShowing = false
            })

        }
    }
    
    func closeNotification(nbModel: NBModel) {
        
        self.currentDequeuingNotification = nil
        
        let notificationView = nbModel.viewToShow //self.notificationWindow.subviews.first as! NBView
        
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.notificationWindow.transform = CGAffineTransformMakeTranslation(0, -self.notificationWindow.frame.size.height)
            
            }, completion: { (Bool) -> Void in
                self.notificationWindow.transform = CGAffineTransformIdentity
                notificationView.removeFromSuperview()
                self.notificationWindow.hidden = true
                self.isShowing = false
                self.dequeueNotifications()
        })
        
    }
   
}
