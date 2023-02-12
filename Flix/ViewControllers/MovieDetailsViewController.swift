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
    
    var movieDetailViewModel: MovieDetailsViewModel!
    var cancellables = Set<AnyCancellable>()
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var backdropView: UIImageView!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    @IBOutlet weak var playerView: YTPlayerView!
    @IBOutlet weak var ratingView: CosmosView!
    
    var movie: Movie!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Bind to ViewModel
        let apiService: DataServicing = APICaller()
        movieDetailViewModel = MovieDetailsViewModel(apiService: apiService, movieId: movie.id)
        movieDetailViewModel.$movieTrailerKey
            .receive(on: DispatchQueue.global(qos: .background))
            .sink { [weak self] value in
                DispatchQueue.main.async {
                    self?.playerView.load(withVideoId: value)
                }
            }
            .store(in: &cancellables)
        
        // Scroll View
        let contentWidth = scrollView.bounds.width
        let contentHeight = scrollView.bounds.height * 3
        scrollView.contentSize = CGSize(width: contentWidth, height: contentHeight)
        
        // Movie Details UI Elements
        titleLabel.text = movie.title
        titleLabel.sizeToFit()
        
        synopsisLabel.text = movie.overview
        synopsisLabel.sizeToFit()
        
        guard let posterUrl = URL(string: "https://image.tmdb.org/t/p/w185" + movie.poster_path) else {
            print("Unable to get posterUrl")
            return
        }
        posterView.af.setImage(withURL: posterUrl)
        
        guard let backdropUrl = URL(string: "https://image.tmdb.org/t/p/w780" + movie.backdrop_path) else {
            print("Unable to get backdropUrl")
            return
        }
        backdropView.af.setImage(withURL: backdropUrl)
        
        ratingView.text = String(format: "%.1f", movie.vote_average)
        setRatingNumberSettings()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        movieDetailViewModel.observer?.cancel()
        
    }
    
    func setRatingNumberSettings() {
        ratingView.settings.filledColor = UIColor.yellow
        ratingView.settings.emptyBorderColor = UIColor.yellow
        ratingView.settings.filledImage = UIImage(named: "star.fill")
        ratingView.settings.emptyImage = UIImage(named: "star")
        ratingView.settings.textColor = UIColor.white
    }
}
