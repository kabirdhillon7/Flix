//
//  MovieGridViewController.swift
//  Flix
//
//  Created by Kabir Dhillon on 12/2/21.
//

import UIKit
import AlamofireImage

class MovieGridViewController: UIViewController, UICollectionViewDelegateFlowLayout {
    
    var movies = [[String:Any]]()
    
    //@IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // Adjusts Navigation Bar text color
        // let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        // navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        /*
         let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
         
         layout.minimumLineSpacing = 5
         layout.minimumInteritemSpacing = 5
         
         let width = (view.frame.size.width - layout.minimumInteritemSpacing * 2) / 3
         layout.itemSize = CGSize(width: width, height: width * 3 / 2)
         */
        
        // Do any additional setup after loading the view.
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/297762/similar?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
                self.movies = dataDictionary["results"] as! [[String:Any]]
                
                
                self.collectionView.reloadData()
                print(self.movies)
                
                // TODO: Get the array of movies
                // TODO: Store the movies in a property to use elsewhere
                // TODO: Reload your table view data
                
            }
        }
        task.resume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("loading MovieGridDetailsViewController")
        
        // Find the selected movie
        let cell  = sender as! UICollectionViewCell
        let indexPath = collectionView.indexPath(for: cell)!
        
        let movie = movies[indexPath.row]
        
        // Pass the selected movie to the details view controller
        let movieGridDetailsViewController = segue.destination as! MovieGridDetailsViewController
        movieGridDetailsViewController.movie = movie
        print("Selected cell number: \(indexPath.row)")
    }
    
}

extension MovieGridViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieGridCell", for: indexPath) as! MovieGridCell
        
        let movie = movies[indexPath.item]
        
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string: baseUrl + posterPath)
        
        cell.posterView.af.setImage(withURL: posterUrl!)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width/3.0
        let height = width * 3 / 2
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
