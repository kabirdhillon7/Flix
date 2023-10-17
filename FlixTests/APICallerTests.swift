//
//  APICallerTests.swift
//  FlixTests
//
//  Created by Kabir Dhillon on 10/17/23.
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

final class APICallerTests: XCTestCase {

    private var apiCaller: APICaller!
    
    override func setUp() {
        super.setUp()
        apiCaller = APICaller()
    }
    
    override func tearDown() {
        apiCaller = nil
        super.tearDown()
    }

    func test_getMovies_shouldNotBeNil() {
        // given
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=") else {
            return
        }
        
        XCTAssertNotNil(apiCaller.getMovies(toUrl: url))
    }

}
