//
//  MoviesViewModelTests.swift
//  FlixTests
//
//  Created by Kabir Dhillon on 2/2/23.
//

import XCTest
import Combine
@testable import Flix

class MockAPIService: DataServicing {
    
    var mockTrailerKey = ""
    var cancellables = Set<AnyCancellable>()
    
    func getMovies(toUrl url: URL) -> AnyPublisher<[Movie], Error> {
        Result.Publisher([]).eraseToAnyPublisher()
    }
    
    func getMovieTrailer(movieId: Int) -> AnyPublisher<String, Error> {
        Result.Publisher(mockTrailerKey).eraseToAnyPublisher()
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
    
    override func tearDown() {
        moviesVM = nil
        mockAPIService = nil
        super.tearDown()
    }
    
    func test_getMovieData_shouldNotBeNil() {
        moviesVM.getMovieData()
        XCTAssertNotNil(moviesVM.movies)
        XCTAssertTrue(moviesVM.movies.isEmpty)
    }
    
    
}
