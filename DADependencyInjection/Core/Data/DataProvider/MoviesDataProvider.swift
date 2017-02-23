//
//  MoviesDataProvider.swift
//  DADependencyInjection
//
//  Created by Dejan on 21/02/2017.
//  Copyright © 2017 Dejan. All rights reserved.
//

import Foundation

protocol MoviesDataProvider {
    var networkingProvider: NetworkingProvider { get set }
    var moviesFactory: MoviesFactoryProvider { get set }
    func getMovies(onCompleted: (([MovieItem]) -> ())?)
}
