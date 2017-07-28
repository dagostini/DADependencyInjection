//
//  MoviesDataSource_Operations.swift
//  DADependencyInjection
//
//  Created by Dejan on 28/07/2017.
//  Copyright © 2017 Dejan. All rights reserved.
//

import Foundation

class MoviesDataSource_Operations: MoviesDataProvider {
    
    public var networkingProvider: NetworkingProvider
    public var moviesFactory: MoviesFactoryProvider
    
    private let operationQueue: OperationQueue
    
    public init(withNetworkingProvider networking: NetworkingProvider = AFNetworkConnector(), andFactory factory: MoviesFactoryProvider = MoviesFactory()) {
        self.networkingProvider = networking
        self.moviesFactory = factory
        
        self.operationQueue = OperationQueue()
    }
    
    func getMovies(onCompleted: (([MovieItem]) -> ())?) {
        
        guard
            let urlString = DataSourceConstants.URLString()
            else {
                onCompleted?([])
                return
        }
        
        let networkingOperation = GetDataOperation(withURLString: urlString, andNetworkingProvider: networkingProvider)
        let parsingOperation = ParseDataOperation(withFactory: moviesFactory)
        
        networkingOperation.completionBlock = {
            parsingOperation.moviesData = networkingOperation.responseData
        }
        
        parsingOperation.completionBlock = {
            onCompleted?(parsingOperation.movies ?? [])
        }
        parsingOperation.addDependency(networkingOperation)
        
        operationQueue.addOperations([networkingOperation, parsingOperation], waitUntilFinished: false)
    }
}
