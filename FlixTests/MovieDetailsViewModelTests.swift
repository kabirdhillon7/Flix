//
//  MovieDetailsViewModelTests.swift
//  FlixTests
//
//  Created by Kabir Dhillon on 2/5/23.
//

import XCTest
import Combine
@testable import Flix

final class MovieDetailsViewModelTests: XCTestCase {
    
    private var movieDetailVM: MovieDetailsViewModel!
    private var apiService: MockAPIService!
    
    override func setUp() {
        super.setUp()
        apiService = MockAPIService()
        movieDetailVM = MovieDetailsViewModel(apiService: apiService, movieId: 1)
    }
    
    func testGetTrailerData() {
        // Given
        let expectedMovieTrailerKey = "abc123"
        let movieTrailerKey = expectation(description: "Movie Trailer Key")
        
        // When
        apiService.getMovieTrailer(movieId: 1)
            .sink(receiveCompletion: { _ in }, receiveValue: { [self] trailerKey in
                movieDetailVM.movieTrailerKey = trailerKey
                movieTrailerKey.fulfill()
            })
            .store(in: &apiService.cancellables)
        
        waitForExpectations(timeout: 5) { [self] (error) in
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
            }
            
            // Assert
            XCTAssertEqual(movieDetailVM.movieTrailerKey, expectedMovieTrailerKey)
        }
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
