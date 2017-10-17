//
//  MoviesManagerTests.swift
//  DADependencyInjection
//
//  Created by Dejan on 19/04/2017.
//  Copyright © 2017 Dejan. All rights reserved.
//

import XCTest
@testable import DADependencyInjection

class MoviesManagerTests: XCTestCase {
    
    private func createManager() -> MoviesManager {
        let networkProvider = MockNetworkProvider(withDataProvider: TestData(withFileName: TestFileNames.PopularMovies))
        let dataProvider = MoviesDataSource(withNetworkingProvider: networkProvider, andFactory: JSONMoviesFactory())
        return MoviesManager(withDataProvider: dataProvider)
    }
    
    func testGetListItemsDisplayable_Normal_ListItemsArray() {
        let manager = createManager()
        
        var result: [ListDisplayable]?
        
        let getItemsExpectation = self.expectation(description: "Get List Items Displayable Expectation")
        manager.getListItems { (items) in
            result = items
            getItemsExpectation.fulfill()
        }
        self.waitForExpectations(timeout: 0.1) { (error) in
            guard error == nil else {
                XCTFail("Expectation error: \(String(describing: error?.localizedDescription))")
                return
            }
            
            XCTAssertNotNil(result)
            
            XCTAssertTrue(result?.count == 100) // Operations demo
            
            let firstItem = result?.sorted(){ $0.listItemTitle > $1.listItemTitle }.first
            XCTAssertEqual(firstItem?.listItemTitle, "The Fate of the Furious")
            XCTAssertEqual(firstItem?.listItemSubtitle, "When a mysterious woman seduces Dom into the world of crime and a betrayal of those closest to him, the crew face trials that will test them as never before.")
        }
    }
    
    func testSearchListItems_NotCached() {
        let manager = createManager()
        
        var result: [ListDisplayable]?
        
        let searchItemsExpectation = self.expectation(description: "Search List Items Displayable Expectation")
        manager.searchListItems(searchTerm: "ghost") { (items) in
            result = items
            searchItemsExpectation.fulfill()
        }
        self.waitForExpectations(timeout: 0.1) { (error) in
            guard error == nil else {
                XCTFail("Expectation error: \(String(describing: error?.localizedDescription))")
                return
            }
            
            XCTAssertNotNil(result)
            
            XCTAssertTrue(result?.count == 5) // Operations demo
            
            let item = result?.first
            XCTAssertEqual(item?.listItemTitle, "Ghost in the Shell")
        }
    }
    
    func testSearchListItems_Cached() {
        let manager = createManager()
        
        var result: [ListDisplayable]?
        
        let getItemsExpectation = self.expectation(description: "Get List Items Displayable Expectation")
        manager.getListItems { (items) in
            result = items
            getItemsExpectation.fulfill()
        }
        self.waitForExpectations(timeout: 0.1) { (error) in
            guard error == nil else {
                XCTFail("Expectation error: \(String(describing: error?.localizedDescription))")
                return
            }
            
            XCTAssertNotNil(result)
        }
        
        let searchItemsExpectation = self.expectation(description: "Search List Items Displayable Expectation")
        manager.searchListItems(searchTerm: "ghost") { (items) in
            result = items
            searchItemsExpectation.fulfill()
        }
        self.waitForExpectations(timeout: 0.1) { (error) in
            guard error == nil else {
                XCTFail("Expectation error: \(String(describing: error?.localizedDescription))")
                return
            }
            
            XCTAssertNotNil(result)
            
            XCTAssertTrue(result?.count == 5) // Operations demo
            
            let item = result?.first
            XCTAssertEqual(item?.listItemTitle, "Ghost in the Shell")
        }
    }
}
