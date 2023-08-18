//
//  MainGridContract.swift
//  MovieViewer
//
//  Created by Isaac Delgado on 18/08/23.
//

import Foundation

protocol MainGridPresenterProtocol {
    var title: String { get }
    var categoryTitles: [String] { get }
    var items: [MovieCellModel] { get }

    func viewDidLoad()
    func fetch(for categoryIndex: Int)
    func displayGridMenu()
}

protocol MainGridInteractorProtocol {
    func fetchMovies(for sourceIndex: Int, completion: @escaping (Result<[Movie], Error>) -> Void)
}

protocol MainGridViewProtocol: AnyObject {
    func loadedNewMovies()
}

protocol MainGridRouterProtocol {
    func displayGridMenu(in view: MainGridViewProtocol?, title: String, actionTitles: [String], selectedAction: @escaping (String) -> Void)
}
