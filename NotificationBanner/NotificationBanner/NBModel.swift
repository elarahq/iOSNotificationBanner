//
//  NBModel.swift
//  NotificationBanner
//
//  Created by Ankit Aggarwal on 01/09/15.
//  Copyright (c) 2015 Locon Solutions. All rights reserved.
//

import UIKit

public class NBModel: NSObject {
    let context: AnyObject
    let viewToShow: NBView
    
    public init(context: AnyObject, viewToShow: NBView) {
        self.context = context
        self.viewToShow = viewToShow
    }
}
