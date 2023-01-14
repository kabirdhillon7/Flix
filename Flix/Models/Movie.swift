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
    let synopsis: String?
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
    
    /*
     
    // Decoding
    init(from decoder: Decoder) throws {
        //let container = try decoder.container(keyedBy: CodingKeys.self)
        
        
        id = try container.decode(Int.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        synopsis = try container.decodeIfPresent(String.self, forKey: .synopsis)
        // posterUrl = try container.decodeUrl(forKey: .posterUrl)
        // backdropUrl = try container.decodeUrl(forKey: .backdropUrl)
        rating = try container.decode(NSNumber.self, forKey: .rating)
        
    }
    
     // don't really need to use these
    enum CodingKeys: String, CodingKeys {
        case id, title
        // poster_path
        // backdrop_path
        case synopsis = "overview"
        case rating = "vote_average"
    }
     */
}
