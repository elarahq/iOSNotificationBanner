//
//  NBView.swift
//  NotificationBanner
//
//  Created by Ankit Aggarwal on 01/09/15.
//  Copyright (c) 2015 Locon Solutions. All rights reserved.
//

import UIKit

public class NBView: UIView {
    
    /// Context can be used to indentify and cancel enQueued notifications
    public var context: String = ""
    public var tapClosure:((NBView)->Void)!
    
    var tapGesture: UITapGestureRecognizer!
    
    /**
    Call this method if you have a close button in your notification view subclass
    */
    public func closeNotification() {
        NotificationBannerCenter.defaultCenter.closeNotification(self, shouldDequeueNotifications: false)
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        self.tapGesture = UITapGestureRecognizer(target: self, action: "viewTapped")
        self.tapGesture.numberOfTapsRequired = 1;
        self.addGestureRecognizer(tapGesture)
    }
    
    public func viewTapped() {
        self.tapGesture.enabled = false
        if self.tapClosure != nil {
            self.tapClosure(self)
        }
    }
}
