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
    private var observer: Cancellable?
    
    @Published private(set) var movieTrailerKey: String = ""
    
    init(apiService: DataServicing, movieId: Int) {
        self.apiService = apiService
        getMovieTrailerKey(movieID: movieId)
    }
    
    deinit {
        observer?.cancel()
    }
    
    func getMovieTrailerKey(movieID: Int) {
        observer = apiService.getMovieTrailer(movieId: movieID)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    print("Finished getting movie trailer")
                case .failure(let error):
                    print("Error getting movie trailer: \(error)")
                }
            } receiveValue: { [weak self] key in
                self?.movieTrailerKey = key
            }
    }
}
