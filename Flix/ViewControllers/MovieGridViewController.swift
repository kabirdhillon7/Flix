//
//  MovieGridViewController.swift
//  Flix
//
//  Created by Kabir Dhillon on 12/2/21.
//

import UIKit
import AlamofireImage

class MovieGridViewController: UIViewController, UICollectionViewDelegateFlowLayout {
    
    private var movieGridViewModel: MoviesGridViewModel!
    var bindToMoviesGridViewModelToController: (() -> ()) = {}
    
    //var superheroMovies = [Movie]()
    
    //@IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Bind to MoviesGridViewModel
        movieGridViewModel = MoviesGridViewModel(apiCaller: APICaller.shared)
        movieGridViewModel.bindToMoviesGridViewModelToController = { [weak self] in
            self?.collectionView.reloadData()
            
        }
        
        // Collection View
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("loading MovieGridDetailsViewController")
        
        // Find the selected movie
        let cell = sender as! UICollectionViewCell
        let indexPath = collectionView.indexPath(for: cell)!
        
        let movie = movieGridViewModel.superheroMovies[indexPath.row]
        
        // Pass the selected movie to the details view controller
        let movieGridDetailsViewController = segue.destination as! MovieGridDetailsViewController
        movieGridDetailsViewController.superheroMovie = movie
        print("Selected cell number: \(indexPath.row)")
    }
    
}

extension MovieGridViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieGridCell", for: indexPath) as! MovieGridCell
        
        let movie = movieGridViewModel.superheroMovies[indexPath.item]
        
        cell.posterView.af.setImage(withURL: movie.posterUrl)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieGridViewModel.superheroMovies.count
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
