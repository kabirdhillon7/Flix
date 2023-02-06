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
    
    var movieDetailVM: MovieDetailsViewModel!
    var cancellables = Set<AnyCancellable>()
    
    var movie: Movie!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Bind to ViewModel
        let apiService: DataServicing = APICaller()
        movieDetailVM = MovieDetailsViewModel(apiService: apiService, movieId: movie.id)
        movieDetailVM.$movieTrailerKey
            .receive(on: DispatchQueue.global(qos: .background))
            .sink { [weak self] value in
                DispatchQueue.main.async {
                    self?.playerView.load(withVideoId: value)
                }
            }
            .store(in: &cancellables)
        
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
        movieDetailVM.observer?.cancel()
        
    }
    
    func setRatingNumberSettings() {
        ratingView.settings.filledColor = UIColor.yellow
        ratingView.settings.emptyBorderColor = UIColor.yellow
        ratingView.settings.filledImage = UIImage(named: "star.fill")
        ratingView.settings.emptyImage = UIImage(named: "star")
        ratingView.settings.textColor = UIColor.white
    }
}
