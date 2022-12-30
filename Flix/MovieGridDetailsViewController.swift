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
    
    var movie: [String:Any]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        titleLabel.text = movie["title"] as? String
        titleLabel.sizeToFit()
        
        synopsisLabel.text = movie["overview"] as? String
        synopsisLabel.sizeToFit()
        
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string: baseUrl + posterPath)
        
        posterView.af.setImage(withURL: posterUrl!)
        
        let backdropPath = movie["backdrop_path"] as! String
        let backdropUrl = URL(string: "https://image.tmdb.org/t/p/w780" + backdropPath)
        
        backdropView.af.setImage(withURL: backdropUrl!)
        
        let ratingNumber = movie["vote_average"] as! NSNumber
        ratingView.text = "\(String(describing: ratingNumber))"
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
