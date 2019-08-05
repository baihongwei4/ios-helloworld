//
//  ViewController.swift
//  iosAppTestSingle
//
//  Created by Hongwei on 10/7/19.
//  Copyright © 2019 hongwei. All rights reserved.
//

import UIKit

import UserNotifications

class ViewController: UIViewController {
    
    var myClass = MyTestClass()
    
    let notificationCenter = UNUserNotificationCenter.current()
    let options: UNAuthorizationOptions = [.alert, .sound, .badge]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        myLabel.text = "Hongwei Hello!"
        
//        notificationCenter.requestAuthorization(options: options) {
//            (didAllow, error) in
//            if !didAllow {
//                print("User has declined notifications")
//            }
//        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBOutlet weak var androidIcon: UIImageView!
    
    @IBOutlet weak var myLabel: UILabel!
    
    private var counter = 0
    
    @IBAction func myFunctionName(sender: UIButton) {
        print(sender.tag)
    
//        let name = HongweiUtil
        let hongweiObj = HongweiClass()
        let stringFromClass = hongweiObj.getName() + "My Lucky Number is " + String(hongweiObj.getMyLuckyNumber())
        
        if(sender.tag == 4) {
            counter = counter + 1
            if(counter % 2==0) {
                myLabel.text = "Qantas clicked!" + String(sender.tag)
            } else {
                myLabel.text = stringFromClass
            }
        } else {
            myLabel.text = "Unknown Tag: " + String(sender.tag)
        }
    }


    @IBOutlet weak var switchLabel: UILabel!
    
    @IBOutlet weak var muyprogressbar: UIProgressView!

    @IBAction func myswitch(_ sender: UISwitch) {
        if(sender.isOn==true) {
            muyprogressbar.progress = 0.8
            
            let sum = myClass.add(num1: 1, num2: 4)
            switchLabel.text = String(sum)
        } else {
            switchLabel.text = "OFF"
            muyprogressbar.progress = 0.1
        }
        
//        checkNotifyPermissions()
        notifyLocal()
    }
    
    func notifyLocal() {
        //设置推送内容
        let content = UNMutableNotificationContent()
        content.title = "hangge.com"
        content.body = "做最好的开发者知识平台"
        
        //设置通知触发器
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        
        //设置请求标识符
        let requestIdentifier = "hongwei.iosAppTestSingle"
        
        //设置一个通知请求
        let request = UNNotificationRequest(identifier: requestIdentifier,
                                            content: content, trigger: trigger)
        
        //将通知请求添加到发送中心
        UNUserNotificationCenter.current().add(request) { error in
            if error == nil {
                print("Time Interval Notification scheduled: \(requestIdentifier)")
            }
        }
    }
    
    func checkNotifyPermissions() {
        UNUserNotificationCenter.current().getNotificationSettings {
            settings in
            var message = "是否允许通知："
            switch settings.authorizationStatus {
            case .authorized:
                message.append("允许")
            case .notDetermined:
                message.append("未确定")
            case .denied:
                message.append("不允许")
            case .provisional:
                message.append("provisional")
            @unknown default:
                message.append("default")
            }
            
            message.append("\n声音：")
            switch settings.soundSetting{
            case .enabled:
                message.append("开启")
            case .disabled:
                message.append("关闭")
            case .notSupported:
                message.append("不支持")
            }
            
            message.append("\n应用图标标记：")
            switch settings.badgeSetting{
            case .enabled:
                message.append("开启")
            case .disabled:
                message.append("关闭")
            case .notSupported:
                message.append("不支持")
            }
            
            message.append("\n在锁定屏幕上显示：")
            switch settings.lockScreenSetting{
            case .enabled:
                message.append("开启")
            case .disabled:
                message.append("关闭")
            case .notSupported:
                message.append("不支持")
            }
            
            message.append("\n在历史记录中显示：")
            switch settings.notificationCenterSetting{
            case .enabled:
                message.append("开启")
            case .disabled:
                message.append("关闭")
            case .notSupported:
                message.append("不支持")
            }
            
            message.append("\n横幅显示：")
            switch settings.alertSetting{
            case .enabled:
                message.append("开启")
            case .disabled:
                message.append("关闭")
            case .notSupported:
                message.append("不支持")
            }
            
            message.append("\n显示预览：")
            if #available(iOS 11.0, *) {
                switch settings.showPreviewsSetting{
                case .always:
                    message.append("始终（默认）")
                case .whenAuthenticated:
                    message.append("解锁时")
                case .never:
                    message.append("从不")
                }
            } else {
                // Fallback on earlier versions
            }
            
            
            print(message)
        }
    }
}

