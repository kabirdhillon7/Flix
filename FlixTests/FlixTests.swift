//
//  FlixTests.swift
//  FlixTests
//
//  Created by Kabir Dhillon on 11/17/21.
//

import XCTest
import Combine
@testable import Flix

class MockAPIService: APICaller {
    override func getMovies(toUrl url: URL) -> AnyPublisher<[Movie], Error> {
        return Result.Publisher([]).eraseToAnyPublisher()
    }
}

class FlixTests: XCTestCase {
    
    private var moviesVM: MoviesViewModel!
    private var apiService: MockAPIService!
    
    override func setUp() {
        super.setUp()
        apiService = MockAPIService()
        moviesVM = MoviesViewModel(apiService: apiService)
    }
    
    func testGetMovieData() {
        moviesVM.getMovieData()
        XCTAssertNotNil(moviesVM.movies)
        XCTAssertTrue(moviesVM.movies.isEmpty)
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
