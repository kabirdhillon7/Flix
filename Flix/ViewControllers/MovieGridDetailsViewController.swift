//
//  MovieGridDetailsViewController.swift
//  Flix
//
//  Created by Kabir Dhillon on 12/3/21.
//

import UIKit
import AlamofireImage
import Cosmos
import YouTubeiOSPlayerHelper

class MovieGridDetailsViewController: UIViewController {
    
    @IBOutlet weak var backdropView: UIImageView!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    @IBOutlet weak var playerView: YTPlayerView!
    @IBOutlet weak var ratingView: CosmosView!
    
    var superheroMovie: Movie!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        titleLabel.text = superheroMovie.title
        titleLabel.sizeToFit()
        
        synopsisLabel.text = superheroMovie.overview
        synopsisLabel.sizeToFit()
        
        let posterBaseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = superheroMovie.poster_path
        let posterUrl = URL(string: posterBaseUrl + posterPath)
        posterView.af.setImage(withURL: posterUrl!)
        
        let backdropBaseUrl = "https://image.tmdb.org/t/p/w780"
        let backdropPath = superheroMovie.backdrop_path
        let backdropUrl = URL(string: backdropBaseUrl + backdropPath)
        backdropView.af.setImage(withURL: backdropUrl!)
        
        ratingView.text = String(format: "%.1f", superheroMovie.vote_average)
        setRatingNumberSettings()
        
        // Get YT key using APICaller
        APICaller().getTrailer(movieId: superheroMovie.id) { (key, error) in
            if let error = error {
                print(error.localizedDescription)
            } else if let key = key {
                // Implementing DispatchQueue.main.async for UI efficency to load playerView
                DispatchQueue.main.async {
                    self.playerView.load(withVideoId: key)
                }
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
