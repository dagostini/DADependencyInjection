//
//  MoviesManager.swift
//  DADependencyInjection
//
//  Created by Dejan on 22/02/2017.
//  Copyright © 2017 Dejan. All rights reserved.
//

import Foundation

class MoviesManager: ListDisplayableDataProvider {
    
    private var cachedItems: [ListDisplayable]?
    
    var moviesDataProvider: MoviesDataProvider
    
    init(withDataProvider dataProvider: MoviesDataProvider = MoviesDataSource()) {
        self.moviesDataProvider = dataProvider
    }
    
    func getListItems(onCompleted: (([ListDisplayable]) -> ())?) {
        self.moviesDataProvider.getMovies {
            
            (movies) in
            
            let listItems = movies.map({ ListDisplayableItem(withMovieItem: $0) })
            
            DispatchQueue.main.async(execute: { 
                onCompleted?(listItems)
            })
            
            self.cachedItems = listItems
        }
    }
    
    // TODO: Save first movie
    
    func searchListItems(searchTerm: String, onCompleted: (([ListDisplayable]) -> ())?) {
        
        if let cached = cachedItems {
            onCompleted?(self.filter(cached, term: searchTerm))
        } else {
            getListItems(onCompleted: { (items) in
                onCompleted?(self.filter(items, term: searchTerm))
            })
        }
    }
    
    private func filter(_ list: [ListDisplayable], term: String) -> [ListDisplayable] {
        return list.filter(){ $0.listItemTitle.lowercased().contains(term.lowercased()) }
    }
}

// MARK: ListDisplayable
private struct ListDisplayableItem: ListDisplayable {
    var listItemTitle: String
    var listItemSubtitle: String?
    
    init(withMovieItem item: MovieItem) {
        self.listItemTitle = item.title
        self.listItemSubtitle = item.movieDescription
    }
}
