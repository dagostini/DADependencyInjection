//
//  MoviesDataSource.swift
//  DADependencyInjection
//
//  Created by Dejan on 21/02/2017.
//  Copyright © 2017 Dejan. All rights reserved.
//

import UIKit

struct DataSourceConstants {
    static let TMDBBaseURL = "https://api.themoviedb.org"
    static let MoviesURL = "/3/movie/popular"
    static let APIParameterKey = "api_key"
    static let APIParameterValue = "_YOUR_API_KEY_HERE_"
    static let PageParameterKey = "page"
    
    static func URLString(forPage page: String = "1") -> String? {
        
        let urlComponents = NSURLComponents(string: DataSourceConstants.TMDBBaseURL)
        urlComponents?.path = DataSourceConstants.MoviesURL
        
        let apiKey = URLQueryItem(name: DataSourceConstants.APIParameterKey, value: DataSourceConstants.APIParameterValue)
        let page = URLQueryItem(name: DataSourceConstants.PageParameterKey, value: page)
        
        urlComponents?.queryItems = [apiKey, page]
        
        return urlComponents?.string
    }
}

class MoviesDataSource: MoviesDataProvider {
    
    public var networkingProvider: NetworkingProvider
    public var moviesFactory: MoviesFactoryProvider
    
    public init(withNetworkingProvider networking: NetworkingProvider = AFNetworkConnector(), andFactory factory: MoviesFactoryProvider = JSONMoviesFactory()) {
        self.networkingProvider = networking
        self.moviesFactory = factory
    }
    
    
    func getMovies(onCompleted: (([MovieItem]) -> ())?) {
        
        var result: [MovieItem] = []
        
        let dispatchGroup = DispatchGroup()
        
        for i in 1...5 {
            guard
                let urlString = DataSourceConstants.URLString(forPage: "\(i)")
                else {
                    continue
            }
            
            dispatchGroup.enter()
            self.networkingProvider.restCall(urlString: urlString) {
                
                (responseObject) in
                
                guard
                    let responseData = responseObject,
                    let jsonObject = try? JSONSerialization.jsonObject(with: responseData, options: [JSONSerialization.ReadingOptions.allowFragments])
                    else {
                        dispatchGroup.leave()
                        return
                }
                
                let movies = self.moviesFactory.movieItems(withJSON: jsonObject)
                result = result + movies
                
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: DispatchQueue.global()) {
            onCompleted?(result)
        }
    }
}
