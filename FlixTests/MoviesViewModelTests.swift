//
//  MoviesViewModelTests.swift
//  FlixTests
//
//  Created by Kabir Dhillon on 2/2/23.
//

import XCTest
import Combine
@testable import Flix

class MockAPIService: APICaller {
    
    var cancellables = Set<AnyCancellable>()
    
    override func getMovies(toUrl url: URL) -> AnyPublisher<[Movie], Error> {
        return Result.Publisher([]).eraseToAnyPublisher()
    }
    
    override func getMovieTrailer(movieId: Int) -> AnyPublisher<String, Error> {
        return Result.Publisher("abc123").eraseToAnyPublisher()
    }
}

final class MoviesViewModelTests: XCTestCase {
    
    private var moviesVM: MoviesViewModel!
    private var mockAPIService: MockAPIService!
    
    override func setUp() {
        super.setUp()
        mockAPIService = MockAPIService()
        moviesVM = MoviesViewModel(apiService: mockAPIService)
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
