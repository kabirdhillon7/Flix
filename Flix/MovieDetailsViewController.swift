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
    //@IBOutlet weak var playerView: YTPlayerView!
    @IBOutlet weak var ratingView: CosmosView!
    
    var movie: Movie!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        titleLabel.text = movie.title
        titleLabel.sizeToFit()
        
        synopsisLabel.text = movie.synopsis
        synopsisLabel.sizeToFit()
        
        posterView.af.setImage(withURL: movie.posterUrl)
        
        backdropView.af.setImage(withURL: movie.backdropUrl)
        
        ratingView.text = "\(String(describing: movie.rating))"
        ratingView.settings.filledColor = UIColor.yellow
        ratingView.settings.emptyBorderColor = UIColor.yellow
        ratingView.settings.filledImage = UIImage(named: "star.fill")
        ratingView.settings.emptyImage = UIImage(named: "star")
        ratingView.settings.textColor = UIColor.white
        
        /*
        let movieID = movie["id"]
        let videoes = "https://api.themoviedb.org/3/movie/\(movieID)/videos?api_key=93e318361fd7d5007c54fbedb1dc26ee&language=en-US"
        
        playerView.load(withVideoId: "")*/
        
    }
}
