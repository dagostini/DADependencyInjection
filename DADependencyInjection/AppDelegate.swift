//
//  AppDelegate.swift
//  DADependencyInjection
//
//  Created by Dejan on 19/02/2017.
//  Copyright © 2017 Dejan. All rights reserved.
//

import UIKit
import Bugsee

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        Bugsee.launch(token: APIKey.Bugsee)
        
        Bugsee.setEmail("dejan@test.com")
        
        Bugsee.setAttribute("userID", value: "1234")
        Bugsee.setAttribute("userName", value: "Dejan")
        
        return true
    }
    
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([Any]?) -> Void) -> Bool {

        if let title = userActivity.userInfo?[SiriConstants.ItemTitle.rawValue] as? String,
            let desc = userActivity.userInfo?[SiriConstants.ItemDescription.rawValue] as? String {
            
            if let detailsVC = self.window?.rootViewController?.storyboard?.instantiateViewController(withIdentifier: "DetailsVC") as? DetailsViewController {
                detailsVC.itemTitle = title
                detailsVC.itemDescription = desc
                
                self.window?.rootViewController?.present(detailsVC, animated: true, completion: nil)
            }
        }
        
        return true
    }
}

