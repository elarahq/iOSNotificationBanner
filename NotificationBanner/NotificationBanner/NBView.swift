//
//  NBView.swift
//  NotificationBanner
//
//  Created by Ankit Aggarwal on 01/09/15.
//  Copyright (c) 2015 Locon Solutions. All rights reserved.
//

import UIKit

public class NBView: UIView {

    public func closeNotification() {
        
        NotificationBannerCenter.defaultCenter.closeNotification(self, shouldDequeueNotifications: false)
        
        
        
    }
    

}
