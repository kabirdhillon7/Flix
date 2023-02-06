//
//  MoviesGridViewModelTests.swift
//  FlixTests
//
//  Created by Kabir Dhillon on 2/2/23.
//

import XCTest
import Combine
@testable import Flix

final class MoviesGridViewModelTests: XCTestCase {
    
    private var moviesGridVM: MoviesGridViewModel!
    private var mockAPIService: MockAPIService!
    
    func testGetSuperheroMovieData() {
        moviesGridVM.getSuperheroMovieData()
        XCTAssertNotNil(moviesGridVM.superheroMovies)
        XCTAssertTrue(moviesGridVM.superheroMovies.isEmpty)
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        mockAPIService = MockAPIService()
        moviesGridVM = MoviesGridViewModel(apiCaller: mockAPIService)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
