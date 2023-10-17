//
//  MovieTests.swift
//  FlixTests
//
//  Created by Kabir Dhillon on 10/17/23.
//

import XCTest
@testable import Flix

final class MovieTests: XCTestCase {
    
    private var movie: Movie!
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        movie = nil
        super.tearDown()
    }
    
    func test_movieInit_shouldBeEqual() {
        movie = Movie(id: 502356,
                      title: "The Super Mario Bros. Movie",
                      overview: "While working underground to fix a water main, Brooklyn plumbers—and brothers—Mario and Luigi are transported down a mysterious pipe and wander into a magical new world. But when the brothers are separated, Mario embarks on an epic quest to find Luigi.",
                      poster_path: "/qNBAXBIQlnOThrVvA6mA2B5ggV6.jpg",
                      backdrop_path: "/nLBRD7UPR6GjmWQp6ASAfCTaWKX.jpg",
                      vote_average: 7.7
        )
        
        XCTAssertEqual(movie.id, 502356)
        XCTAssertEqual(movie.title, "The Super Mario Bros. Movie")
        XCTAssertEqual(movie.overview, "While working underground to fix a water main, Brooklyn plumbers—and brothers—Mario and Luigi are transported down a mysterious pipe and wander into a magical new world. But when the brothers are separated, Mario embarks on an epic quest to find Luigi.")
        XCTAssertEqual(movie.poster_path, "/qNBAXBIQlnOThrVvA6mA2B5ggV6.jpg")
        XCTAssertEqual(movie.backdrop_path, "/nLBRD7UPR6GjmWQp6ASAfCTaWKX.jpg")
        XCTAssertEqual(movie.vote_average, 7.7)
    }
    
    func test_movie_shouldNotBeNil() {
        movie = Movie(id: 502356,
                      title: "The Super Mario Bros. Movie",
                      overview: "While working underground to fix a water main, Brooklyn plumbers—and brothers—Mario and Luigi are transported down a mysterious pipe and wander into a magical new world. But when the brothers are separated, Mario embarks on an epic quest to find Luigi.",
                      poster_path: "/qNBAXBIQlnOThrVvA6mA2B5ggV6.jpg",
                      backdrop_path: "/nLBRD7UPR6GjmWQp6ASAfCTaWKX.jpg",
                      vote_average: 7.7
        )
        
        XCTAssertNotNil(movie)
    }
}
