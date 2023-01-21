//
//  MoviesViewModel.swift
//  Flix
//
//  Created by Kabir Dhillon on 1/4/23.
//

import Foundation
import Combine

class MoviesViewModel {
    
    // need cancelable via Combine for dataPublisher
    
    private let apiService: APICaller // replace w/ DS
    private(set) var movies = [Movie]() {
        didSet{ // use Combine published instead of didSet w/ Decodeable
            self.bindMoviesViewModelToController()
        }
    }
    private var observer: Cancellable?
    
    var bindMoviesViewModelToController: (() -> ()) = {}
    
    // DataServicing type instead of APICaller
    init(apiService: APICaller) {
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
        /*
        APICaller().getMovies(toURL: url) { (data, error) in
            var movies = [Movie]()
            // Decodable
            if let error = error  {
                print("Error getting movies: \(error.localizedDescription)")
                return
            } else if let data = data {
                if data["results"] == nil {
                    print("Error: No results key found in data")
                    return
                }
                if let results = data["results"] as? [[String:Any]] {
                    for movieDictionary in results {
                        let id = movieDictionary["id"] as! Int
                        let title = movieDictionary["title"] as! String
                        let synopsis = movieDictionary["overview"] as! String
                        
                        let posterBaseUrl = "https://image.tmdb.org/t/p/w185"
                        let posterPath = movieDictionary["poster_path"] as! String
                        let posterUrl = URL(string: posterBaseUrl + posterPath)
                        
                        let backdropBaseUrl = "https://image.tmdb.org/t/p/w780"
                        let backdropPath = movieDictionary["backdrop_path"] as! String
                        let backdropUrl = URL(string: backdropBaseUrl + backdropPath)
                        
                        let rating = movieDictionary["vote_average"] as! NSNumber
                        
                        let movie = Movie(id: id,
                                          title: title,
                                          synopsis: synopsis,
                                          posterUrl: posterUrl!,
                                          backdropUrl: backdropUrl!,
                                          rating: rating)
                        movies.append(movie)
                    }
                }
                
                self.movies = movies
            }
        }*/
