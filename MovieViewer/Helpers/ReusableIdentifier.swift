//
//  ReusableIdentifier.swift
//  AlOutfits
//
//  Created by Isaac Delgado on 02/06/23.
//

import UIKit

protocol ReusableIdentifier {
    static var reuseIdentifier: String { get }
}

extension ReusableIdentifier where Self: UICollectionViewCell {
    static var reuseIdentifier: String { String(describing: Self.self) }
}

enum ReusableIdentifierError: Error {
    case unregistered
}

extension UICollectionView {
    func dequeueReusableCell<T: UICollectionViewCell & ReusableIdentifier>(ofType type: T.Type, for indexPath: IndexPath) throws -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: type.reuseIdentifier, for: indexPath) as? T else {
            throw ReusableIdentifierError.unregistered
        }
        return cell
    }

    func register<T: UICollectionViewCell & ReusableIdentifier>(cellType: T.Type) {
        register(T.self, forCellWithReuseIdentifier: T.reuseIdentifier)
    }
}
