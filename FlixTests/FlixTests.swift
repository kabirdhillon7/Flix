//
//  FlixTests.swift
//  FlixTests
//
//  Created by Kabir Dhillon on 11/17/21.
//

import XCTest
@testable import Flix

class FlixTests: XCTestCase {

    func testGetMovieData () {
        /*
         let api = APICaller.shared
             let expectation = self.expectation(description: "API response received")

             api.getMovies(toURL: "https://api.themoviedb.org/3/movie/now_playing?api_key=", completion: { (response, error) in
                 XCTAssertNotNil(response)
                 XCTAssertNil(error)
                 expectation.fulfill()
             })

             waitForExpectations(timeout: 5.0, handler: nil)
         */
        let api = APICaller()
        let expectation = self.expectation(description: "API response recieved")
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=")
        
        api.getMovies(toURL: url!, completion: { (response, error) in
            XCTAssertNotNil(response)
            XCTAssertNil(error)
            expectation.fulfill()
        })
        
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
