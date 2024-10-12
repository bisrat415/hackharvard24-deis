//
//  AppDelegate.swift
//  UniRoute
//
//  Created by Sherren Jie on 10/12/24.
//

import UIKit
import GoogleMaps

class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        GMSServices.provideAPIKey("AIzaSyBnT1a8xoTnThiLzDZFd8tjKb6NK1R79c")
        return true
    }
}


