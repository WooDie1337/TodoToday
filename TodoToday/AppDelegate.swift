//
//  AppDelegate.swift
//  TodoToday
//
//  Created by Daniel Krupenin on 14.02.2018.
//  Copyright © 2018 Daniel Krupenin. All rights reserved.
//

import UIKit

import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
//        print(Realm.Configuration.defaultConfiguration.fileURL)
        
        do{
            _ = try Realm()
        } catch {
            print("Error instaling new realm \(error)")
        }
        return true
    }

}

