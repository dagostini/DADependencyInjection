//
//  MoviesDataSourceTests.swift
//  DADependencyInjection
//
//  Created by Dejan on 19/04/2017.
//  Copyright © 2017 Dejan. All rights reserved.
//

import XCTest
@testable import DADependencyInjection

class MoviesDataSourceTests: XCTestCase {
    
    func testGetMovies_Normal_ListOfMovies() {
        let testDataProvider = TestData(withFileName: TestFileNames.PopularMovies)
        let networkingProvider = MockNetworkProvider(withDataProvider: testDataProvider)
        let dataSource = MoviesDataSource(withNetworkingProvider: networkingProvider, andFactory: MoviesFactory())
        var movies: [MovieItem]?
        
        let getMoviesExpectation = self.expectation(description: "Get Movies Expectation")
        dataSource.getMovies { (items) in
            movies = items
            getMoviesExpectation.fulfill()
        }
        self.waitForExpectations(timeout: 0.1) { (error) in
            guard error == nil else {
                XCTFail("Expectation error: \(String(describing: error?.localizedDescription))")
                return
            }
            
            XCTAssertNotNil(movies)
            XCTAssertTrue(movies?.count == 20)
            
            let firstMovie = movies?.sorted(){ $0.title > $1.title }.first
            XCTAssertEqual(firstMovie?.title, "The Fate of the Furious")
        }
    }
}
