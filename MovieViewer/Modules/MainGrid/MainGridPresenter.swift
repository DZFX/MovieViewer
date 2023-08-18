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
        MovieCellModel(title: "Sample"),
        MovieCellModel(title: "Items"),
        MovieCellModel(title: "To"),
        MovieCellModel(title: "Show")
    ]
}

extension MainGridPresenter: MainGridPresenterProtocol {
    func fetch(for categoryIndex: Int) {
        // TODO: - Fetch items
        print("Fetch \(categoryIndex)")
    }
}
