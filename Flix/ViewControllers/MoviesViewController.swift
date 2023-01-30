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
    
    private var moviesViewModel: MoviesViewModel!
    //var bindMoviesViewModelToController: (() -> ()) = {}
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        // Bind to MoviesViewModel
        moviesViewModel = MoviesViewModel(apiService: APICaller())
        // add for DispatchQuene.async
        moviesViewModel.bindMoviesViewModelToController = { [weak self] in
            self?.tableView.reloadData()
        }
        
        // Table Views
        tableView.dataSource = self
        tableView.delegate = self
        //tableView.rowHeight = UITableView.automaticDimension
        //tableView.estimatedRowHeight = 140*2
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("Loading segue to MoviesDetailVC")
        
        // Find the selected movie
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)!
        
        let movie = moviesViewModel.movies[indexPath.row]
        
        // Pass the selected movie to the details view controller
        
        // if MDVC is complex, make VM for it. Check segue
        let detailsViewController = segue.destination as! MovieDetailsViewController
        detailsViewController.movie = movie
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension MoviesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        moviesViewModel.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // guard let cell, ... as? MovieCell
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell
        
        let movie = moviesViewModel.movies[indexPath.row]
        
        cell.titleLabel!.text = movie.title
        cell.synopsisLabel!.text = movie.overview
        
        // Getting Poster URL
        let posterBaseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie.poster_path
        let posterUrl = URL(string: posterBaseUrl + posterPath)
        
        cell.posterView.af.setImage(withURL: posterUrl!)
        
        return cell
    }
}
