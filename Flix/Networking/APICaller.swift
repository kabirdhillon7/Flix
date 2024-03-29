//
//  APICaller.swift
//  Flix
//
//  Created by Kabir Dhillon on 1/2/23.
//

import Foundation
import Combine

/// Enum that stores API information
enum APIInformation: String {
    case key = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
}

/// Protocol for DataServicing
protocol DataServicing {
    func getMovies(toUrl url: URL) -> AnyPublisher<[Movie], Error>
    func getMovieTrailer(movieId: Int) -> AnyPublisher<String, Error>
}

/// Class responsible for making API calls
class APICaller: DataServicing {
    
    let apiKey = APIInformation.key
    
    /**
     Fetches a list of movies recently playing in theaters
     - Parameters:
        - movieId: the id of the specfic movie to fetch the trailer for
     - Returns:
        -  An AnyPublisher of a `String` representing the key for the trailer, and an `Error`
     */
    func getMovies(toUrl url: URL) -> AnyPublisher<[Movie], Error> {
        guard let requestUrl = URL(string: url.absoluteString + apiKey.rawValue) else {
            return Fail(error: NSError(domain: "Invalid url", code: 0)).eraseToAnyPublisher()
        }
        let request = URLRequest(url: requestUrl, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map({ $0.data })
            .decode(type: MovieResults.self, decoder: JSONDecoder())
            .map({ $0.results })
            .eraseToAnyPublisher()
    }
    
    /**
     Fetches movie trailer from The Movie Database API
     - Parameters:
        - movieId: the id of the specfic movie to fetch the trailer for
     - Returns:
        -  An AnyPublisher of a `String` representing the key for the trailer, and an `Error`
     */
    func getMovieTrailer(movieId: Int) -> AnyPublisher<String, Error> {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieId)/videos?api_key=\(apiKey.rawValue)") else {
            return Fail(error: NSError(domain: "Invalid url", code: 0)).eraseToAnyPublisher()
        }
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map { $0.data }
            .tryMap { try JSONSerialization.jsonObject(with: $0) }
            .compactMap { $0 as? [String: Any] }
            .compactMap { $0["results"] as? [[String: Any]] }
            .compactMap { $0.first(where: { ($0["type"] as? String) == "Trailer" }) }
            .map { ($0?["key"] as? String)! }
            .eraseToAnyPublisher()
    }
}
