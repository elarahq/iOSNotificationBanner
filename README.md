# iOSNotificationBanner

This library allows you to show in-app notification.

Features:
- Enqueue unlimited notifications
- Show any type of view as notification via custom Nib or view
- Cancel enqueued notifications if needed

# Example 

![Screenshot](http://i.imgur.com/gMe0xbo.png?2)

####The singleton!

```swift
let notificationCenter = NotificationBannerCenter.defaultCenter
```

####Enqueue Notification

```swift
  num = 0
  let chatNotificationView = ChatNotificationView.loadFromNib()
  chatNotificationView.nameLabel.text = "John Doe"
  chatNotificationView.messageLabel.text =  "\(num) Hey, My name is John Doe!"
  chatNotificationView.thumbImageView.image = UIImage(named: "johndoe.jpg")
  chatNotificationView.context = "\(num)"
  chatNotificationView.tapClosure = { (nbView: NBView) in
    println((nbView as! ChatNotificationView).messageLabel.text)
  }
  notificationCenter.enQueueNotification(chatNotificationView)
```

####Cancel Notification

```swift
  let exampleContext = 0
  notificationCenter.cancelNotificationsWithContexts(["\(exampleContext)"])
```

#Licenses

MIT
