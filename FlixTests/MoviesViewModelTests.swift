//
//  MoviesViewModelTests.swift
//  FlixTests
//
//  Created by Kabir Dhillon on 2/2/23.
//

import XCTest
@testable import Flix

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
