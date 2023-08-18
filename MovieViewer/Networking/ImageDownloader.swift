//
//  ImageDownloader.swift
//  MovieViewer
//
//  Created by Isaac Delgado on 18/08/23.
//

import UIKit

struct ImageDownloaderError: Error {}
class ImageDownloader {
    static var cache: [String: UIImage] = [:]
    static func downloadImage(from urlString: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        if let image = cache[urlString] {
            return completion(.success(image))
        }
        guard let url = URL(string: urlString) else {
            return completion(.failure(ImageDownloaderError()))
        }
        URLSession.shared.dataTask(with: URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad)) { data, _, error in
            guard let data = data, let image = UIImage(data: data) else {
                guard let error = error else {
                    return completion(.failure(ImageDownloaderError()))
                }
                return completion(.failure(error))
            }
            cache[urlString] = image
            completion(.success(image))
        }
        .resume()
    }
}

extension UIImageView {
    func setImage(from urlString: String, completion: ((UIImage?) -> Void)? = nil) {
        ImageDownloader.downloadImage(from: urlString) { [weak self] result in
            guaranteeMainThread {
                switch result {
                case .success(let image):
                    guard let completion = completion else {
                        self?.image = image
                        return
                    }
                    completion(image)
                case .failure:
                    completion?(nil)
                }
            }
        }
    }
}
