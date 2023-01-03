//
//  Movie.swift
//  Flix
//
//  Created by Kabir Dhillon on 1/2/23.
//

import Foundation

struct Movie {
    let id: Int
    let title: String
    let synopsis: String
    let posterUrl: URL
    let backdropUrl: URL
    let rating: NSNumber
    
    init(id: Int, title: String, synopsis: String, posterUrl: URL, backdropUrl: URL, rating: NSNumber) {
        self.id = id
        self.title = title
        self.synopsis = synopsis
        self.posterUrl = posterUrl
        self.backdropUrl = backdropUrl
        self.rating = rating
    }
}
