//
//  APICaller.swift
//  Flix
//
//  Created by Kabir Dhillon on 1/2/23.
//

import Foundation
//import Combine

// create protocol -- DataServicing
// get movies and trailers
// class conforms to DS
// diff responses for testing

class APICaller {
    
    let apiKey: String = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
    
    // Fn to get movies
    
    /*
    func newGetMovies(toUrl url: URL) -> AnyPublisher<[Movie], Error> {
        let requestUrl = URL(string: url.absoluteString + apiKey)!

        return URLSession.shared.dataTaskPublisher(for: url)
                .map { $0.data }
                .decode(type: [Movie].self, decoder: JSONDecoder())
                .receive(on: RunLoop.main)
                .eraseToAnyPublisher()
    }*/
    
    // use decode for [String: Any]?, use result instead
    // Result<Movie, Error>     (Result<Movie, Error> -> Void)
    func getMovies(toURL url: URL, completion: @escaping ([String: Any]?, Error?) -> Void) {
        let requestUrl = URL(string: url.absoluteString + apiKey)!
        let request = URLRequest(url: requestUrl, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main) // don't need OQ.main
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            
            // test errors or decoding (but not needed if decode is done right)
            // Url session gets response
            if let error = error {
                print(error.localizedDescription)
                completion(nil, error)
            } else if let data = data { // use decode instead JSONSerialization
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                                
                completion(dataDictionary, nil) // return model instead
                
                print(dataDictionary)
                
                // TODO: Get the array of movies
                // TODO: Store the movies in a property to use elsewhere
                // TODO: Reload your table view data
            }
        }
        task.resume()
    }

    // Fn to get video
    // look over comments from prev fn
    func getTrailer(movieId: Int, completion: @escaping (String?, Error?) -> Void) {
        // keep base url as constant
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieId)/videos?api_key=\(apiKey)")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        // make var for URLSession.shared.
        //let session = URLSession.shared.dataTask(with: )
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data,
                      let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                      let results = dataDictionary["results"] as? [[String: Any]] {
                for result in results { // use decodeable w/ model setup
                    if let type = result["type"] as? String, type == "Trailer",
                       let key = result["key"] as? String {
                        completion(key, nil)
                        return
                    }
                }
                completion(nil, nil)
            }
        }
        task.resume()
    }


}
