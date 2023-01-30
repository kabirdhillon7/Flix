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
    
    private var moviesDetailsViewModel: MovieDetailsViewModel!
    
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
        
        // Bind to MoviesViewModel
        
        
        // Movie Details UI Elements
        titleLabel.text = movie.title
        titleLabel.sizeToFit()
        
        synopsisLabel.text = movie.overview
        synopsisLabel.sizeToFit()
        
        let posterUrl = URL(string: "https://image.tmdb.org/t/p/w185" + movie.poster_path)
        posterView.af.setImage(withURL: posterUrl!)
        
        let backdropUrl = URL(string: "https://image.tmdb.org/t/p/w780" + movie.backdrop_path)
        backdropView.af.setImage(withURL: backdropUrl!)
        
        ratingView.text = String(format: "%.1f", movie.vote_average)
        setRatingNumberSettings()
        
        movieTrailerObserver = APICaller().getMovieTrailer(movieId: movie.id)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    print("Finished getting superhero movie trailer")
                case .failure(let error):
                    print("Error getting superhero movie trailer: \(error)")
                }
            } receiveValue: { [weak self] key in
                print("Superhero Movie Trailer Key: \(key)")
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
