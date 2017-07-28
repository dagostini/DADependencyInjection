//
//  MoviesDataSource.swift
//  DADependencyInjection
//
//  Created by Dejan on 21/02/2017.
//  Copyright © 2017 Dejan. All rights reserved.
//

import Foundation

struct DataSourceConstants {
    static let TMDBBaseURL = "https://api.themoviedb.org"
    static let MoviesURL = "/3/movie/popular"
    static let APIParameterKey = "api_key"
    static let APIParameterValue = "_YOUR_API_KEY_"
    
    static func URLString() -> String? {
        
        let urlComponents = NSURLComponents(string: DataSourceConstants.TMDBBaseURL)
        urlComponents?.path = DataSourceConstants.MoviesURL
        
        let querry = URLQueryItem(name: DataSourceConstants.APIParameterKey, value: DataSourceConstants.APIParameterValue)
        urlComponents?.queryItems = [querry]
        
        return urlComponents?.string
    }
}

class MoviesDataSource: MoviesDataProvider {
    
    public var networkingProvider: NetworkingProvider
    public var moviesFactory: MoviesFactoryProvider
    
    public init(withNetworkingProvider networking: NetworkingProvider = AFNetworkConnector(), andFactory factory: MoviesFactoryProvider = MoviesFactory()) {
        self.networkingProvider = networking
        self.moviesFactory = factory
    }
    
    
    func getMovies(onCompleted: (([MovieItem]) -> ())?) {
        
        guard
            let urlString = DataSourceConstants.URLString()
            else {
                onCompleted?([])
                return
        }
        
        self.networkingProvider.restCall(urlString: urlString) {
            
            (responseObject) in
            
            guard
                let responseData = responseObject,
                let jsonObject = try? JSONSerialization.jsonObject(with: responseData, options: [JSONSerialization.ReadingOptions.allowFragments])
                else {
                    onCompleted?([])
                    return
            }
            
            let movies = self.moviesFactory.movieItems(withJSON: jsonObject)
            onCompleted?(movies)
        }
    }
}
