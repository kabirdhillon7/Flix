//
//  MovieGridDetailsViewModel.swift
//  Flix
//
//  Created by Kabir Dhillon on 2/5/23.
//

import Foundation
import Combine

class MovieGridDetailsViewModel {
    // API Service, observer, trailerKey
    private let apiService: DataServicing
    var observer: Cancellable?
    
    @Published var superheroMovieTrailerKey: String = ""
    
    // init: super, call fn for trailer, apiService
    // deinit, cancel observer
    init(apiService: DataServicing, movieId: Int) {
        self.apiService = apiService
        getSuperheroMovieTrailerKey(movieID: movieId)
    }
    
    deinit {
        observer?.cancel()
    }
    
    // func for trailer
    func getSuperheroMovieTrailerKey(movieID: Int) {
        observer = apiService.getMovieTrailer(movieId: movieID)
            .receive(on: DispatchQueue.global(qos: .background))
            .sink { completion in
                switch completion {
                case .finished:
                    print("Finished getting superhero movie trailer")
                case .failure(let error):
                    print("Error getting superhero movie trailer: \(error)")
                }
            } receiveValue: { [weak self] key in
                DispatchQueue.main.async {
                    print("Superhero Movie Trailer Key: \(key)")
                    self?.superheroMovieTrailerKey = key
                }
            }
    }
}
