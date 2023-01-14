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

class MovieDetailsViewController: UIViewController {
    @IBOutlet weak var backdropView: UIImageView!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    @IBOutlet weak var playerView: YTPlayerView!
    @IBOutlet weak var ratingView: CosmosView!
    
    var movie: Movie!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Movie Details UI Elements
        titleLabel.text = movie.title
        titleLabel.sizeToFit()
        
        synopsisLabel.text = movie.synopsis
        synopsisLabel.sizeToFit()
        
        posterView.af.setImage(withURL: movie.posterUrl)
        
        backdropView.af.setImage(withURL: movie.backdropUrl)
        
        ratingView.text = "\(String(describing: movie.rating))"
        setRatingNumberSettings()
        
        // Get YT key using APICaller
        APICaller().getTrailer(movieId: movie.id) { (key, error) in
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
