//
//  MoviesGridViewModel.swift
//  Flix
//
//  Created by Kabir Dhillon on 1/4/23.
//

import Foundation
import Combine

class MoviesGridViewModel: NSObject {
    
    private var apiCaller: DataServicing!
    @Published var superheroMovies = [Movie]()
    private var observer: Cancellable?
    
    init(apiCaller: DataServicing) {
        super.init()
        
        self.apiCaller = apiCaller
        getSuperheroMovieData()
    }
    
    deinit {
        observer?.cancel()
    }
    
    func getSuperheroMovieData() {
        let superherMovieID: Int = 24428
        let url = URL(string:"https://api.themoviedb.org/3/movie/\(superherMovieID)/similar?api_key=")!
        
        observer = apiCaller.getMovies(toUrl: url)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    print("Finished getting superhero movies")
                case .failure(let error):
                    print("Error getting superhero movies: \(error)")
                }
            } receiveValue: { [weak self] value in
                print("Superhero movie: \(value)")
                self?.superheroMovies = value
            }
    }
}
