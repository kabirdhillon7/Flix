//
//  MovieGridDetailsViewModelTests.swift
//  FlixTests
//
//  Created by Kabir Dhillon on 2/5/23.
//

import XCTest
import Combine
@testable import Flix

final class MovieGridDetailsViewModelTests: XCTestCase {
    
    private var movieGridDetailsVM: MovieGridDetailsViewModel!
    private var mockAPIService: MockAPIService!
    
    override func setUp() {
        super.setUp()
        mockAPIService = MockAPIService()
        movieGridDetailsVM = MovieGridDetailsViewModel(apiService: mockAPIService, movieId: 1)
    }
    
//    func testGetTrailerData() {
//        // Given
//        let expectedMovieTrailerKey = "abc123"
//        let movieTrailerKey = expectation(description: "Movie Trailer Key")
//        
//        // When
//        mockAPIService.getMovieTrailer(movieId: 1)
//            .sink(receiveCompletion: { _ in }, receiveValue: { trailerKey in
//                self.movieGridDetailsVM.superheroMovieTrailerKey = trailerKey
//                movieTrailerKey.fulfill()
//            })
//            .store(in: &mockAPIService.cancellables)
//        
//        waitForExpectations(timeout: 5) { [self] (error) in
//            if let error = error {
//                XCTFail("Error: \(error.localizedDescription)")
//            }
//            
//            // Assert
//            XCTAssertEqual(movieGridDetailsVM.superheroMovieTrailerKey, expectedMovieTrailerKey)
//        }
//    }
}
