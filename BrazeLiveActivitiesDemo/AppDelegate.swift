//
//  AppDelegate.swift
//  BrazeLiveActivitiesDemo
//
//  Created by Kevin Cheung on 3/13/24.
//

import UIKit
import BrazeKit

#if canImport(ActivityKit)
import ActivityKit
#endif


@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    static var braze: Braze? = nil
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let configuration = Braze.Configuration(
            apiKey: "REDACTED",
            endpoint: "REDACTED"
        )
        configuration.logger.level = .debug
        configuration.push.automation = true
        
        let braze = Braze(configuration: configuration)
        AppDelegate.braze = braze
        
        
        if #available(iOS 16.1, *) {
          Self.braze?.liveActivities.resumeActivities(
            ofType: Activity<LiveActivitesExampleAttributes>.self
          )
        }
        
        AppDelegate.braze?.changeUser(userId: "kevin2")
        
        return true
    }
    
}

