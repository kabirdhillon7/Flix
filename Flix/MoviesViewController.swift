//
//  MoviesViewController.swift
//  Flix
//
//  Created by Kabir Dhillon on 11/17/21.
//

import Foundation
import UIKit
import AlamofireImage

class MoviesViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    //var moviesDict = [[String:Any]]()
    var movies = [Movie]()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=")!
        APICaller.shared.getMovies(toURL: url) { (data, error) in
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
                        self.movies.append(movie)
                    }
                }
                
                self.movies = self.movies
                self.tableView.reloadData()
                
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("Loading segue to MoviesDetailVC")
        
        // Find the selected movie
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)!
        
        let movie = movies[indexPath.row]
        
        // Pass the selected movie to the details view controller
        let detailsViewController = segue.destination as! MovieDetailsViewController
        detailsViewController.movie = movie
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension MoviesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell
        
        let movie = movies[indexPath.row]
        
        cell.titleLabel!.text = movie.title
        cell.synopsisLabel!.text = movie.synopsis
        cell.posterView.af.setImage(withURL: movie.posterUrl)
        
        return cell
    }
}
