//
//  NSURLNetworkConnector.swift
//  DADependencyInjection
//
//  Created by Dejan on 23/02/2017.
//  Copyright © 2017 Dejan. All rights reserved.
//

import Foundation

class NSURLNetworkConnector: NetworkingProvider {
    
    func restCall(urlString: String, onCompleted: ((Data?) -> ())?) {
        
        guard
            let url = URL(string: urlString)
            else {
                onCompleted?(nil)
                return
        }
        
        let urlTask = URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            onCompleted?(data)
        }
        
        urlTask.resume()
    }
}
