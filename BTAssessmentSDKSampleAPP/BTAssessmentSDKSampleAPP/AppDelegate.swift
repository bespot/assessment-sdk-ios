//
//  AppDelegate.swift
//  BTAssessmentSDKSampleAPP
//
//  Created by Vangelis Spirou Bespot on 4/10/21.
//

import UIKit
import BTAssessmentSDK

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    private let kApplicationId = "assessment-ios"
    private let kApplicationSecret = "hg34kl@t87#klm"
    public var isAuthenticated: Bool = false
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Set the BTAssessmentSDK InOut delegate
        BTAssessmentSDK.shared.configurationDelegate = self
        
        // [BTAssessmentSDK] Init and configure
        BTAssessmentSDK.shared.configure(applicationId: kApplicationId, applicationSecret: kApplicationSecret)
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

extension AppDelegate: BTConfigurationDelegate {
    
    func didConfigure(success: Bool) {
        
        if success {
            isAuthenticated = true
            print("Authentication was successful!")
        } else {
            isAuthenticated = false
            print("Authentication failed.")
        }
    }
    
    func didFailConfigure(error: BTConfigurationError) {
        print(error.rawValue)
    }
    
}

