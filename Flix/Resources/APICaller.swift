//
//  APICaller.swift
//  Flix
//
//  Created by Kabir Dhillon on 1/2/23.
//

import Foundation
import Combine

// create protocol -- DataServicing
// get movies and trailers
// class conforms to DS
// diff responses for testing

class APICaller {
    
    let apiKey: String = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
    
    // Fn to get movies
    func getMovies(toUrl url: URL) -> AnyPublisher<[Movie], Error> {
        let requestUrl = URL(string: url.absoluteString + apiKey)!
        let request = URLRequest(url: requestUrl, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map({ $0.data })
            .decode(type: MovieResults.self, decoder: JSONDecoder())
            .map({ $0.results })
            .eraseToAnyPublisher()
    }
    
    // Fn to get video
    func getMovieTrailer(movieId: Int) -> AnyPublisher<String, Error> {
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieId)/videos?api_key=\(apiKey)")!
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
