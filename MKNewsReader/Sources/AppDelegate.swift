//
//  AppDelegate.swift
//  MKNewsReader
//
//  Created by MK on 6/17/24.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        configureKingfisher()
        
        return true
    }
}
