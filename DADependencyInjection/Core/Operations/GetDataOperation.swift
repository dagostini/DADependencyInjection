//
//  GetDataOperation.swift
//  DADependencyInjection
//
//  Created by Dejan on 28/07/2017.
//  Copyright © 2017 Dejan. All rights reserved.
//

import Foundation

class GetDataOperation: DAOperation {
    
    private let urlString: String
    private let provider: NetworkingProvider
    
    var responseData: Data?
    
    init(withURLString urlString: String, andNetworkingProvider provider: NetworkingProvider = NSURLNetworkConnector()) {
        self.urlString = urlString
        self.provider = provider
    }
    
    override func main() {
        guard isCancelled == false else {
            finish(true)
            return
        }
        
        executing(true)
        provider.restCall(urlString: urlString) { (data) in
            self.responseData = data
            self.executing(false)
            self.finish(true)
        }
    }
}
