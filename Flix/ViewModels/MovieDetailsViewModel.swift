//
//  MovieDetailsViewModel.swift
//  Flix
//
//  Created by Kabir Dhillon on 1/29/23.
//

import Foundation
import Combine

class MovieDetailsViewModel {
    // need to bind
    var MovieDetailsViewModelToController: (() -> ()) = {}
    
    private let apiService: APICaller // replace w/ DS
    
    let videoKey: String
    
    // add cancelable for networking
    private var observer: Cancellable?
    
    // need an init & deinit
    init(apiService: APICaller, videoKey: String){
        self.apiService = apiService
        self.videoKey = videoKey
    }
    
    deinit{
        observer?.cancel()
    }
    
    // publish key for YT video key
    
    
    
    // make networking call
    
}
