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
    var bindMoviesViewModelToController: (() -> ()) = {}
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        // Bind to MoviesViewModel
        moviesViewModel = MoviesViewModel(apiService: APICaller())
        moviesViewModel.bindMoviesViewModelToController = { [weak self] in
            self?.tableView.reloadData()
        }
        
        // Table Views
        tableView.dataSource = self
        tableView.delegate = self
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("Loading segue to MoviesDetailVC")
        
        // Find the selected movie
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)!
        
        let movie = moviesViewModel.movies[indexPath.row]
        
        // Pass the selected movie to the details view controller
        let detailsViewController = segue.destination as! MovieDetailsViewController
        detailsViewController.movie = movie
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension MoviesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesViewModel.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell
        
        let movie = moviesViewModel.movies[indexPath.row]
        
        cell.titleLabel!.text = movie.title
        cell.synopsisLabel!.text = movie.synopsis
        cell.posterView.af.setImage(withURL: movie.posterUrl)
        
        return cell
    }
}
