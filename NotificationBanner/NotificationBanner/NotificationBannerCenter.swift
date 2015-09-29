
//
//  NotificationBannerCenter.swift
//  NotificationBanner
//
//  Created by Ankit Aggarwal on 01/09/15.
//  Copyright (c) 2015 Locon Solutions. All rights reserved.
//

import UIKit

public class NotificationBannerCenter: NSObject {

    /// Notification Window on which notifications are added and presented
    let notificationWindow: UIWindow
    
    /// Returns default shared instance of the notification banner center
    static public let defaultCenter = NotificationBannerCenter()
    
    /// Notification queue which holds the notifications to be displayed
    var notificationQueue: Array<NBView> = []
    
    /// is `true` if notification is being presented
    var isShowing: Bool = false
    
    override init() {
        self.notificationWindow = UIWindow(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, 68))
        //self.notificationWindow = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.notificationWindow.windowLevel = UIWindowLevelStatusBar
        self.notificationWindow.backgroundColor = UIColor.clearColor()
    }

    /**
    Will enqueue notifications to display on the top of the screen
    
    - parameter nbView: object of the notification view which has to be shown
    */
    public func enQueueNotification(nbView: NBView) {
        self.notificationQueue.append(nbView)
        if(self.notificationQueue.count == 1) {
            self.dequeueNotifications()
        }
    }
    
    /**
    Starts dequeuing the notifications one by one
    */
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
    
    /**
    Cancels the future notification
    
    - parameter notifications: Array of notification objects which are to be cancelled
    */
    func cancelNotifications(notifications: [NBView]) {
        for view in notifications {
            let indexOfNotification = self.notificationQueue.indexOf(view)
            if let foundIndex = indexOfNotification {
                self.notificationQueue.removeAtIndex(foundIndex)
            }
        }
    }
    
    /**
    Notifications can be cancelled by providing an array of context that might be set before enQueueing a notification
    
    - parameter contexts: Array of context
    */
    public func cancelNotificationsWithContexts(contexts: [String]) {
        var notifications: [NBView] = []
        for context in contexts {
            for notification in self.notificationQueue {
                if context == notification.context {
                    notifications.append(notification)
                }
            }
        }
        self.cancelNotifications(notifications)
    }
    
    /**
    Closes a shown notification
    
    - parameter nbView:                     notification view object to be closed
    - parameter shouldDequeueNotifications: should dequeue other notifications after dequeuing the current notification
    */
    func closeNotification(nbView: NBView, shouldDequeueNotifications: Bool) {
        
        let indexOfNotification = self.notificationQueue.indexOf(nbView)
        if let foundIndex = indexOfNotification {
            self.notificationQueue.removeAtIndex(foundIndex)
        } else {
            if self.notificationWindow.subviews.first == nil {
                if(shouldDequeueNotifications) {
                    self.isShowing = false
                    self.dequeueNotifications()
                }
                return;
            }
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
