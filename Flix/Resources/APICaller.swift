//
//  APICaller.swift
//  Flix
//
//  Created by Kabir Dhillon on 1/2/23.
//

import Foundation

class APICaller {
    
    let apiKey: String = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
    
    // Singelton Method: creating shared instance of APICaller
    static let shared = APICaller()
    
    private init() {}
    
    // Fn to get movies
    func getMovies(toURL url: URL, completion: @escaping ([String: Any]?, Error?) -> Void) {
        let requestUrl = URL(string: url.absoluteString + apiKey)!
        let request = URLRequest(url: requestUrl, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                                
                completion(dataDictionary, nil)
                
                print(dataDictionary)
                
                // TODO: Get the array of movies
                // TODO: Store the movies in a property to use elsewhere
                // TODO: Reload your table view data
                
            }
        }
        task.resume()
    }

    
    // Fn to get trailer
}
