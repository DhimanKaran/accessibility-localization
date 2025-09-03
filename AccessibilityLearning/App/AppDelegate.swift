//
//  AppDelegate.swift
//  AccessibilityLearning
//
//  Created by karan dhiman on 22/08/2025.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        setAppLanguageFromDefaults()
        return true
    }

    func setAppLanguageFromDefaults() {
        let defaultLang = "en" // fallback language
        let selectedLang = UserDefaults.standard.string(forKey: Keys.UserDefaults.selectedLanguage) ?? defaultLang
        
        // Set AppleLanguages (used by system localization)
        UserDefaults.standard.set([selectedLang], forKey: Keys.UserDefaults.appleLanguages)
        UserDefaults.standard.synchronize()
        
        // Optional: Set semantic layout direction
        if selectedLang == "ar" {
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
        } else {
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
        }
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

