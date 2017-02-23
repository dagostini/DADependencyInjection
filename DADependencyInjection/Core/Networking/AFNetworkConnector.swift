//
//  AFNetworkConnector.swift
//  DADependencyInjection
//
//  Created by Dejan on 20/02/2017.
//  Copyright © 2017 Dejan. All rights reserved.
//

import Foundation

class AFNetworkConnector: NetworkingProvider {
    
    func restCall(urlString: String, onCompleted: ((Data?) -> ())?) {
        
        guard
            let url = try? urlString.asURL()
            else {
                onCompleted?(nil)
                return
        }
        
        SessionManager.default.request(url).responseData {
            response in
            onCompleted?(response.result.value)
        }
    }
}
