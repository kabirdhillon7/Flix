//
//  MoviesViewModel.swift
//  Flix
//
//  Created by Kabir Dhillon on 1/4/23.
//

import Foundation
import Combine

class MoviesViewModel {
        
    private let apiService: DataServicing

    @Published private(set) var movies = [Movie]()
    
    private var observer: Cancellable?
    
    // DataServicing type instead of APICaller
    init(apiService: DataServicing) {
        self.apiService = apiService
        getMovieData()
    }
    
    deinit {
        observer?.cancel()
    }
    
    func getMovieData() {
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=")!
        observer = apiService.getMovies(toUrl: url)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    print("Finished getting movies")
                case .failure(let error):
                    print("Error getting movies: \(error)")
                }
            } receiveValue: { [weak self] value in
                print("Movie: \(value)")
                self?.movies = value
            }
    }
}
