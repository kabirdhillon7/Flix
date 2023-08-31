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
    
    override func setUp() {
        mockAPIService = MockAPIService()
        moviesGridVM = MoviesGridViewModel(apiCaller: mockAPIService)
    }
    
    override func tearDown() {
        mockAPIService = nil
        moviesGridVM = nil
        super.tearDown()
    }
    
    func testGetSuperheroMovieData() {
        moviesGridVM.getSuperheroMovieData()
        XCTAssertNotNil(moviesGridVM.superheroMovies)
        XCTAssertTrue(moviesGridVM.superheroMovies.isEmpty)
    }
}
