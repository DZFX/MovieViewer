//
//  MovieCellModel.swift
//  MovieViewer
//
//  Created by Isaac Delgado on 18/08/23.
//

import Foundation

struct MovieCellModel {
    var title: String
    var date: String
    var rating: String
    var description: String
    var imageURL: String

    init(movie: Movie) {
        title = movie.title
        date = MovieCellModel.formattedDate(from: movie.releaseDate)
        rating = "★ \(movie.rating)"
        description = movie.overview
        imageURL = APIService.resourcesURL + movie.posterPath
    }

    static func formattedDate(from string: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: string)
        return date?.formatted(date: .abbreviated, time: .omitted) ?? "N/A"
    }
}
