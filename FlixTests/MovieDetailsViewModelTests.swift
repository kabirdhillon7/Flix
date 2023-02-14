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
    var cancellable: AnyCancellable?
    
    private var movieDetailVM: MovieDetailsViewModel!
    private var mockAPIService: MockAPIService!
    
    override func setUp() {
        super.setUp()
        mockAPIService = MockAPIService()
        movieDetailVM = MovieDetailsViewModel(apiService: mockAPIService, movieId: 1)
    }
    
    func testGetTrailerData() {
        let exp = expectation(description: #function)
        
        let expectedMovieTrailerKey = "abc123"
        
        cancellable = mockAPIService.getMovieTrailer(movieId: 1)
            .sink(receiveCompletion: { [weak self] completion in
                guard case .finished = completion else { return }
                //                XCTAssertEqual(self?.movieDetailVM.movieTrailerKey, expectedMovieTrailerKey)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    XCTAssertEqual(self?.movieDetailVM.movieTrailerKey, expectedMovieTrailerKey)
                    exp.fulfill()
                }
                exp.fulfill()
            }, receiveValue: { _ in
                print("test")
            })
        
        mockAPIService.mockTrailerKey = expectedMovieTrailerKey
        
        waitForExpectations(timeout: 1.0)
    }
}
