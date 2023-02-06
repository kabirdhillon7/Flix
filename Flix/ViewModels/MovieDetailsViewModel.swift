//
//  MovieDetailsViewModel.swift
//  Flix
//
//  Created by Kabir Dhillon on 2/5/23.
//

import Foundation
import Combine

class MovieDetailsViewModel {
    
    private let apiService: DataServicing
    var observer: Cancellable?
    
    @Published var movieTrailerKey: String = ""
    
    init(apiService: DataServicing, movieId: Int) {
        self.apiService = apiService
        getMovieTrailerKey(movieID: movieId)
    }
    
    deinit {
        observer?.cancel()
    }
    
    func getMovieTrailerKey(movieID: Int) {
        observer = apiService.getMovieTrailer(movieId: movieID)
            .receive(on: DispatchQueue.global(qos: .background))
            .sink { completion in
                switch completion {
                case .finished:
                    print("Finished getting movie trailer")
                case .failure(let error):
                    print("Error getting movie trailer: \(error)")
                }
            } receiveValue: { [weak self] key in
                DispatchQueue.main.async {
                    print("Movie Trailer Key: \(key)")
                    self?.movieTrailerKey = key
                }
            }
    }
}
