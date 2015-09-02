
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
    var notificationQueue: Array<NBView> = []
    var isShowing: Bool = false {
        didSet {
            println("Changing isShowing to \(isShowing)")
        }
    }
    
    override init() {
        self.notificationWindow = UIWindow(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, 68))
        //self.notificationWindow = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.notificationWindow.windowLevel = UIWindowLevelStatusBar
        self.notificationWindow.backgroundColor = UIColor.clearColor()
    }
    
    public func enQueueNotification(nbView: NBView) {
        self.notificationQueue.append(nbView)
        if(self.notificationQueue.count == 1) {
            self.dequeueNotifications()
        }
    }
    
    func dequeueNotifications() {
        
        if(!(notificationQueue.count > 0) || self.isShowing) {
            return;
        }
        
        self.isShowing = true
        
        let nbView = notificationQueue.first!
        //self.notificationWindow.frame = nbView.bounds
        nbView.frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, 68)
        self.notificationWindow.addSubview(nbView)
        self.notificationWindow.hidden = false
        
        self.notificationWindow.transform = CGAffineTransformMakeTranslation(0, -self.notificationWindow.frame.size.height)
        
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.notificationWindow.transform = CGAffineTransformIdentity
            }, completion: { (Bool) -> Void in
                self.delay(2) {
                    self.closeNotification(nbView, shouldDequeueNotifications: true)
                }
        })
    }
    
    func closeNotification(nbView: NBView, shouldDequeueNotifications: Bool) {
        
        let indexOfNotification = find(self.notificationQueue, nbView)
        if let foundIndex = indexOfNotification {
            self.notificationQueue.removeAtIndex(foundIndex)
        } else {
            if(shouldDequeueNotifications) {
                self.isShowing = false
                self.dequeueNotifications()
            }
            return;
        }
        
        let notificationView = nbView
        
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.notificationWindow.transform = CGAffineTransformMakeTranslation(0, -self.notificationWindow.frame.size.height)
            
            }, completion: { (Bool) -> Void in
                self.notificationWindow.transform = CGAffineTransformIdentity
                notificationView.removeFromSuperview()
                self.notificationWindow.hidden = true
                self.isShowing = false
                if(shouldDequeueNotifications) {
                    self.dequeueNotifications()
                }
        })
        
    }
    
    //MARK:- Utility
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
}
