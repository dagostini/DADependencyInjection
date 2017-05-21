//
//  IntentHandler.swift
//  SiriTest
//
//  Created by Dejan on 18/05/2017.
//  Copyright © 2017 Dejan. All rights reserved.
//

import Intents

// As an example, this class is set up to handle Message intents.
// You will want to replace this or add other intents as appropriate.
// The intents you wish to handle must be declared in the extension's Info.plist.

// You can test your example integration by saying things to Siri like:
// "Send a message using <myApp>"
// "<myApp> John saying hello"
// "Search for messages in <myApp>"

class IntentHandler: INExtension, INSearchForPhotosIntentHandling {
    
    var dataProvider: ListDisplayableDataProvider = MoviesManager()
    
    override func handler(for intent: INIntent) -> Any {
        return self
    }
    
    func handle(searchForPhotos intent: INSearchForPhotosIntent, completion: @escaping (INSearchForPhotosIntentResponse) -> Void) {
        guard let searchTerm = intent.searchTerms?.first else {
            let response = INSearchForPhotosIntentResponse(code: .failure, userActivity: nil)
            completion(response)
            return
        }
        
        dataProvider.searchListItems(searchTerm: searchTerm) { (items) in
            let userActivity = NSUserActivity(activityType: NSStringFromClass(INSearchForPhotosIntent.self))
            if let movie = items.first {
                userActivity.userInfo = [SiriConstants.ItemTitle.rawValue: movie.listItemTitle, SiriConstants.ItemDescription.rawValue: movie.listItemSubtitle ?? ""]
                userActivity.title = "Search Results"
                userActivity.isEligibleForHandoff = true
                userActivity.becomeCurrent()
            }
            
            let response = INSearchForPhotosIntentResponse(code: .continueInApp, userActivity: userActivity)
            
            completion(response)
        }
    }
}

