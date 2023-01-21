//
//  MovieDetailsViewController.swift
//  Flix
//
//  Created by Kabir Dhillon on 12/2/21.
//

import UIKit
import AlamofireImage
import YouTubeiOSPlayerHelper
import Cosmos
import Combine

class MovieDetailsViewController: UIViewController {
    @IBOutlet weak var backdropView: UIImageView!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    @IBOutlet weak var playerView: YTPlayerView!
    @IBOutlet weak var ratingView: CosmosView!
    
    var movie: Movie!
    
    var movieTrailerObserver: AnyCancellable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Movie Details UI Elements
        titleLabel.text = movie.title
        titleLabel.sizeToFit()
        
        synopsisLabel.text = movie.overview
        synopsisLabel.sizeToFit()
        
        let posterBaseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie.poster_path
        let posterUrl = URL(string: posterBaseUrl + posterPath)
        posterView.af.setImage(withURL: posterUrl!)
        
        let backdropBaseUrl = "https://image.tmdb.org/t/p/w780"
        let backdropPath = movie.backdrop_path
        let backdropUrl = URL(string: backdropBaseUrl + backdropPath)
        backdropView.af.setImage(withURL: backdropUrl!)
        
        ratingView.text = String(format: "%.1f", movie.vote_average)
        setRatingNumberSettings()
        
        // Get YT key using APICaller
        /*
         APICaller().getTrailer(movieId: movie.id) { (key, error) in
         if let error = error {
         print(error.localizedDescription)
         } else if let key = key {
         // Implementing DispatchQueue.main.async for UI efficency to load playerView
         DispatchQueue.main.async {
         self.playerView.load(withVideoId: key)
         }
         }
         }*/
        
        movieTrailerObserver = APICaller().getMovieTrailer(movieId: movie.id)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    print("Finished getting movie trailer")
                case .failure(let error):
                    print("Error getting movietrailer: \(error)")
                }
            } receiveValue: { [weak self] key in
                print("Movie Trailer Key: \(key)")
                DispatchQueue.main.async {
                    self?.playerView.load(withVideoId: key)
                }
            }
    }
    
    func setRatingNumberSettings() {
        ratingView.settings.filledColor = UIColor.yellow
        ratingView.settings.emptyBorderColor = UIColor.yellow
        ratingView.settings.filledImage = UIImage(named: "star.fill")
        ratingView.settings.emptyImage = UIImage(named: "star")
        ratingView.settings.textColor = UIColor.white
    }
}
