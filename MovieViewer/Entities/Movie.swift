//
//  Movie.swift
//  MovieViewer
//
//  Created by Isaac Delgado on 18/08/23.
//

import Foundation

struct Movie: Codable {
    var posterPath: String
    var title: String
    var releaseDate: Date
    var rating: Double
    var overview: String

    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case rating = "vote_average"
        case title, overview
    }
}
