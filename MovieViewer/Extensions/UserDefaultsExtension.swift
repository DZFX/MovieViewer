//
//  UserDefaultsExtension.swift
//  MovieViewer
//
//  Created by Isaac Delgado on 18/08/23.
//

import Foundation

fileprivate let sessionIDUserDefaultsKey = "sessionIDUserDefaultsKey"
extension UserDefaults: MainGridRepoProtocol {
    var storedSessionID: SessionID {
        value(forKey: sessionIDUserDefaultsKey) as? String ?? ""
    }
}

extension UserDefaults: LoginRepoProtocol {
    func set(sessionID: String) {
        setValue(sessionID, forKey: sessionID)
    }
}
