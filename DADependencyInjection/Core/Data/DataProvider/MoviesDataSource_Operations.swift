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
    
    private let operationQueue: OperationQueue = OperationQueue()
    
    public init(withNetworkingProvider networking: NetworkingProvider = AFNetworkConnector(), andFactory factory: MoviesFactoryProvider = MoviesFactory()) {
        self.networkingProvider = networking
        self.moviesFactory = factory
        self.operationQueue.maxConcurrentOperationCount = 5
    }
    
    func getMovies(onCompleted: (([MovieItem]) -> ())?) {
        
        operationQueue.cancelAllOperations()
        
        var result: [MovieItem] = []
        
        let queueCompletionOperation = BlockOperation {
            onCompleted?(result)
        }
        
        var operations: [Operation] = []
        
        operationQueue.isSuspended = true
        
        for i in 1...5 {
            guard
                let urlString = DataSourceConstants.URLString(forPage: "\(i)")
                else {
                    continue
            }
            
            let networkingOperation = GetDataOperation(withURLString: urlString, andNetworkingProvider: networkingProvider)
            let parsingOperation = ParseDataOperation(withFactory: moviesFactory)
            
            networkingOperation.completionBlock = {
                parsingOperation.moviesData = networkingOperation.responseData
            }
            
            parsingOperation.completionBlock = {
                if let moviesArray = parsingOperation.movies {
                    DispatchQueue.global().sync(flags: .barrier) {
                        result = result + moviesArray
                    }
                }
            }
            
            parsingOperation.addDependency(networkingOperation)
            
            queueCompletionOperation.addDependency(parsingOperation)
            
            operations.append(contentsOf: [parsingOperation, networkingOperation])
        }
        
        operations.append(queueCompletionOperation)
        
        operationQueue.addOperations(operations, waitUntilFinished: false)
        operationQueue.isSuspended = false
    }
}
