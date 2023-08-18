//
//  Protocol.swift
//  MovieViewer
//
//  Created by Isaac Delgado on 18/08/23.
//

import Foundation

protocol LogoutServiceProtocol {
    func performLogout(with sessionID: SessionID, completion: @escaping (Result<Void, Error>) -> Void)
}
