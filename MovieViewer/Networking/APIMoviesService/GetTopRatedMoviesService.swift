//
//  GetTopRatedMoviesService.swift
//  MovieViewer
//
//  Created by Isaac Delgado on 18/08/23.
//

import Foundation

class GetTopRatedMoviesService: GetMoviesServiceProtocol {
    var client: HTTPClient
    var serviceURL = APIService.baseURL + "/movie/top_rated"
    var urlRequest: URLRequest
    
    init(client: HTTPClient = AuthorizedHTTPClientDecorator(client: URLSession.shared, bearerToken: APIToken())) {
        self.client = client
        urlRequest = URLRequest(url: URL(string: serviceURL)!,
                                cachePolicy: .returnCacheDataElseLoad)
    }
}
