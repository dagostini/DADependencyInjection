//
//  MoviesFactoryTests.swift
//  DADependencyInjection
//
//  Created by Dejan on 19/04/2017.
//  Copyright © 2017 Dejan. All rights reserved.
//

import XCTest
@testable import DADependencyInjection

class MoviesFactoryTests: XCTestCase {
    
    func testMovieItems_Normal_ItemsArray() {
        let testDataProvider = TestData(withFileName: TestFileNames.PopularMovies)
        
        guard let testJSON = testDataProvider.jsonRepresentation else {
            XCTFail("Failed creating a JSON")
            return
        }
        
        let moviesFactory = MoviesFactory()
        let movies = moviesFactory.movieItems(withJSON: testJSON)
        
        XCTAssertTrue(movies.count == 20)
        
        let firstMovie = movies.sorted(){ $0.title > $1.title }.first
        XCTAssertEqual(firstMovie?.title, "The Fate of the Furious")
    }
}
