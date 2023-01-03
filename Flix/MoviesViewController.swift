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
    var movies = [[String:Any]]()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        let apiCaller = APICaller()
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=")!
        apiCaller.getMovies(toURL: url) { (data, error) in
            if let error = error  {
                print("Error getting movies: \(error.localizedDescription)")
                return
            } else if let data = data {
                if data["results"] == nil {
                    print("Error: No results key found in data")
                    return
                }
                self.movies = data["results"] as! [[String:Any]]
                self.tableView.reloadData()
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("loading")
        
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
        let title = movie["title"] as! String
        let synopsis = movie["overview"] as! String
        
        cell.titleLabel!.text = title
        cell.synopsisLabel!.text = synopsis
        
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string: baseUrl + posterPath)
        
        cell.posterView.af.setImage(withURL: posterUrl!)
        
        return cell
    }
}
