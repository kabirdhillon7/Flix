//
//  MoviesViewController.swift
//  Flix
//
//  Created by Kabir Dhillon on 11/17/21.
//

import Foundation
import UIKit
import AlamofireImage
import Combine

class MoviesViewController: UIViewController {
    
    private var moviesViewModel: MoviesViewModel!
    var cancellables = Set<AnyCancellable>()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        // Bind to MoviesViewModel
        let apiService: DataServicing = APICaller()
        moviesViewModel = MoviesViewModel(apiService: apiService)
        moviesViewModel.$movies
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
        
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
        
        guard let posterUrl = URL(string: "https://image.tmdb.org/t/p/w185" + movie.poster_path) else {
            print("Unable to get posterUrl")
            return UITableViewCell()
        }
        cell.posterView.af.setImage(withURL: posterUrl)
        
        return cell
    }
}
