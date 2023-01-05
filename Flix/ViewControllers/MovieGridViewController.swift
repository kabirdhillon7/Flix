//
//  MovieGridViewController.swift
//  Flix
//
//  Created by Kabir Dhillon on 12/2/21.
//

import UIKit
import AlamofireImage

class MovieGridViewController: UIViewController, UICollectionViewDelegateFlowLayout {
    
    var superheroMovies = [Movie]()
    
    //@IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let superherMovieID: String = "299536"
        let url = URL(string:"https://api.themoviedb.org/3/movie/\(superherMovieID)/similar?api_key=")!
        APICaller.shared.getMovies(toURL: url) { (data, error) in
            if let error = error  {
                print("Error getting movies: \(error.localizedDescription)")
                return
            } else if let data = data {
                if data["results"] == nil {
                    print("Error: No results key found in data")
                    return
                }
                if let results = data["results"] as? [[String:Any]] {
                    for movieDictionary in results {
                        let id = movieDictionary["id"] as! Int
                        let title = movieDictionary["title"] as! String
                        let synopsis = movieDictionary["overview"] as! String
                        
                        let posterBaseUrl = "https://image.tmdb.org/t/p/w185"
                        let posterPath = movieDictionary["poster_path"] as! String
                        let posterUrl = URL(string: posterBaseUrl + posterPath)
                        
                        let backdropBaseUrl = "https://image.tmdb.org/t/p/w780"
                        let backdropPath = movieDictionary["backdrop_path"] as! String
                        let backdropUrl = URL(string: backdropBaseUrl + backdropPath)
                        
                        let rating = movieDictionary["vote_average"] as! NSNumber
                        
                        let movie = Movie(id: id,
                                          title: title,
                                          synopsis: synopsis,
                                          posterUrl: posterUrl!,
                                          backdropUrl: backdropUrl!,
                                          rating: rating)
                        self.superheroMovies.append(movie)
                    }
                }
                
                self.superheroMovies = self.superheroMovies
                self.collectionView.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("loading MovieGridDetailsViewController")
        
        // Find the selected movie
        let cell = sender as! UICollectionViewCell
        let indexPath = collectionView.indexPath(for: cell)!
        
        let movie = superheroMovies[indexPath.row]
        
        // Pass the selected movie to the details view controller
        let movieGridDetailsViewController = segue.destination as! MovieGridDetailsViewController
        movieGridDetailsViewController.superheroMovie = movie
        print("Selected cell number: \(indexPath.row)")
    }
    
}

extension MovieGridViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieGridCell", for: indexPath) as! MovieGridCell
        
        let movie = superheroMovies[indexPath.item]
        
        cell.posterView.af.setImage(withURL: movie.posterUrl)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return superheroMovies.count
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
