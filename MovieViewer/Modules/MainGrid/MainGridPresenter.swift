//
//  MainGridPresenter.swift
//  MovieViewer
//
//  Created by Isaac Delgado on 17/08/23.
//

import Foundation

class MainGridPresenter {
    var title: String = "Movies"
    var categoryTitles: [String] = [
        "Popular", "Top Rated", "On TV", "Airing Today"
    ]
    var items: [MovieCellModel] = [
        MovieCellModel(title: "Sample", date: "Item date", rating: "★ Rating", description: "Show many times over", imageURL: "")
    ]
}

extension MainGridPresenter: MainGridPresenterProtocol {
    func fetch(for categoryIndex: Int) {
        // TODO: - Fetch items
        print("Fetch \(categoryIndex)")
    }
}
