//
//  ParseDataOperation.swift
//  DADependencyInjection
//
//  Created by Dejan on 28/07/2017.
//  Copyright © 2017 Dejan. All rights reserved.
//

import Foundation

class ParseDataOperation: DAOperation {
    
    private let factory: MoviesFactoryProvider
    
    var moviesData: Data?
    var movies: [MovieItem]?
    
    init(withFactory factory: MoviesFactoryProvider = JSONMoviesFactory()) {
        self.factory = factory
    }
    
    override func main() {
        guard isCancelled == false else {
            finish(true)
            return
        }
        
        executing(true)
        guard
            let data = moviesData,
            let jsonObject = try? JSONSerialization.jsonObject(with: data, options: [JSONSerialization.ReadingOptions.allowFragments])
            else {
                executing(false)
                finish(true)
                return
        }
        
        movies = factory.movieItems(withJSON: jsonObject)
        
        executing(false)
        finish(true)
    }
}
