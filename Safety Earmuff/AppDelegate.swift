//
//  AppDelegate.swift
//  Safety Earmuff
//
//  Created by Mahmud Ahmad on 2/5/18.
//  Copyright © 2018 Mahmud Ahmad. All rights reserved.
//
// For remote push notifications, I follow this tutorial https://solarianprogrammer.com/2017/02/14/ios-remote-push-notifications-nodejs-backend/


import UIKit
import UserNotifications
//import MessageUI // trying to open the messages app
import AudioToolbox // making the phone vibrate

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        /*
            asking user to enable notifications
         */
        UNUserNotificationCenter.current().requestAuthorization(options: [.badge, .alert, .sound], completionHandler: {(grated, error) in});
        application.registerForRemoteNotifications();
        /*
            end of asking user to enable notifications
         */
        
        /*
            trying to do something while app is terminated, but it recieves a notification
         */
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
        //gotten from Apple documentaiton
//        bgTask = [application beginBackgroundTaskWithName:@"MyTask" expirationHandler:^{
//            // Clean up any unfinished task business by marking where you
//            // stopped or ending the task outright.
//            [application endBackgroundTask:bgTask];
//            bgTask = UIBackgroundTaskInvalid;
//            }];
//
//
//
//        // Start the long-running task and return immediately.
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//
//            // Do the work associated with the task, preferably in chunks.
//
//            [application endBackgroundTask:bgTask];
//            bgTask = UIBackgroundTaskInvalid;
//            });
        
        
        
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    //added callback functions to manage remote notifications
    
    func application(_ _application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // Code taken from http://stackoverflow.com/questions/37956482/registering-for-push-notifications-in-xcode-8-swift-3-0
        // prints the user token on user accepting notifications to the console
        // this token is unique per device and can change on reinstall, ideally
        // we store this on a database in the server
        // it is what allows the server to communicate with the device
        let deviceTokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)});
        //print("success in registering for remote notifications with token \(deviceTokenString)");
    }
    
    func application(_ _application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        
    }
    
    func application(_ _application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        // here we are printing the actual notification that is recieved,
        
        // i think this is where i will put the bluetooth logic to push
        // a message to the headphones
        print("Received push notification: \(userInfo)")
        let aps = userInfo["aps"] as! [String: Any]
        print("\(aps)");
        //UIApplication.shared.open(URL(string: "youtube://")!, options: [:], completionHandler: nil); // opening the youtube app
        let when = DispatchTime.now() + 1 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
            // Your code with delay
        }
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
//        let _viewController : ViewController = window!.rootViewController as! ViewController;
//        _viewController.doSomething();
        UIApplication.shared.keyWindow?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "mainPageController") ;
        let _main : MainPageController =  window!.rootViewController as! MainPageController;
        _main.updateAlertLabel();
        
        

    }
    
}

