//
//  MovieGridDetailsViewController.swift
//  Flix
//
//  Created by Kabir Dhillon on 12/3/21.
//

import UIKit
import AlamofireImage
import Cosmos

class MovieGridDetailsViewController: UIViewController {
    
    @IBOutlet weak var backdropView: UIImageView!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    
    var superheroMovie: Movie!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        titleLabel.text = superheroMovie.title
        titleLabel.sizeToFit()
        
        synopsisLabel.text = superheroMovie.synopsis
        synopsisLabel.sizeToFit()
        
        posterView.af.setImage(withURL: superheroMovie.posterUrl)
        
        
        backdropView.af.setImage(withURL: superheroMovie.backdropUrl)
        
        ratingView.text = "\(String(describing: superheroMovie.rating))"
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
