//
//  MoviesFactory.swift
//  DADependencyInjection
//
//  Created by Dejan on 22/02/2017.
//  Copyright © 2017 Dejan. All rights reserved.
//

import Foundation

private struct MovieItemKey {
    static let Results = "results"
    static let ID = "id"
    static let Title = "title"
    static let Description = "overview"
    static let AverageVote = "vote_average"
}

class MoviesFactory: MoviesFactoryProvider {
    
    func movieItem(withJSON json: Any) -> MovieItem? {
        
        guard
            let jsonDict = json as? [String: Any?],
            let id = jsonDict[MovieItemKey.ID] as? Int,
            let title = jsonDict[MovieItemKey.Title] as? String,
            let description = jsonDict[MovieItemKey.Description] as? String,
            let vote = jsonDict[MovieItemKey.AverageVote] as? Double
            else {
                return nil
        }
        
        return MovieFactoryItem(id: id, title: title, movieDescription: description, averageVote: vote)
    }
    
    func movieItems(withJSON json: Any) -> [MovieItem] {
        
        guard
            let jsonDict = json as? [String: Any?],
            let arrayDict = jsonDict[MovieItemKey.Results] as? [[String: Any?]]
            else {
                return []
        }
        
        return arrayDict.flatMap { movieItem(withJSON: $0) }
    }
}

private struct MovieFactoryItem: MovieItem {
    let id: Int
    let title: String
    let movieDescription: String
    let averageVote: Double
}
