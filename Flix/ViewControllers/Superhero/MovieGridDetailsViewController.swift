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
import Combine

class MovieGridDetailsViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var backdropView: UIImageView!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    @IBOutlet weak var playerView: YTPlayerView!
    @IBOutlet weak var ratingView: CosmosView!
    
    var movieGridDetailViewModel: MovieGridDetailsViewModel!
    var cancellables = Set<AnyCancellable>()
    
    var superheroMovie: Movie!
    
    var movieTrailerObserver: AnyCancellable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Bind to ViewModel
        let apiService: DataServicing = APICaller()
        movieGridDetailViewModel = MovieGridDetailsViewModel(apiService: apiService, movieId: superheroMovie.id)
        movieGridDetailViewModel.$superheroMovieTrailerKey
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                DispatchQueue.main.async {
                    self?.playerView.load(withVideoId: value)
                }
            }
            .store(in: &cancellables)
        
        // Scroll View
        let contentWidth = scrollView.bounds.width
        let contentHeight = scrollView.bounds.height * 2
        scrollView.contentSize = CGSize(width: contentWidth, height: contentHeight)
        
        // Superhero Movie Detail UI Elements
        titleLabel.text = superheroMovie.title
        titleLabel.sizeToFit()
        
        synopsisLabel.text = superheroMovie.overview
        synopsisLabel.sizeToFit()
        
//        let posterBaseUrl = "https://image.tmdb.org/t/p/w185"
//        let posterPath = superheroMovie.poster_path
        guard let posterUrl = URL(string: "https://image.tmdb.org/t/p/w185" + superheroMovie.poster_path) else {
            print("Unable to get superhero posterUrl")
            return
        }
        posterView.af.setImage(withURL: posterUrl)
        
//        let backdropBaseUrl = "https://image.tmdb.org/t/p/w780"
//        let backdropPath = superheroMovie.backdrop_path
        guard let backdropUrl = URL(string: "https://image.tmdb.org/t/p/w780" + superheroMovie.backdrop_path) else {
            print("Unable to get superhero backdropUrl")
            return
        }
        backdropView.af.setImage(withURL: backdropUrl)
        
        ratingView.text = String(format: "%.1f", superheroMovie.vote_average)
        setRatingNumberSettings()
    }
    
    func setRatingNumberSettings() {
        ratingView.settings.filledColor = UIColor.yellow
        ratingView.settings.emptyBorderColor = UIColor.yellow
        ratingView.settings.filledImage = UIImage(named: "star.fill")
        ratingView.settings.emptyImage = UIImage(named: "star")
        ratingView.settings.textColor = UIColor.white
    }
}
