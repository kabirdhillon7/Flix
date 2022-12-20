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
        ratingView.settings.filledColor = UIColor.yellow
        
        /*
        let movieID = movie["id"]
        let videoes = "https://api.themoviedb.org/3/movie/\(movieID)/videos?api_key=93e318361fd7d5007c54fbedb1dc26ee&language=en-US"
        
        playerView.load(withVideoId: "")*/
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
