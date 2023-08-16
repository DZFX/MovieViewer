//
//  UIViewExtensions.swift
//  MovieViewer
//
//  Created by Isaac Delgado on 15/08/23.
//

import UIKit

extension UIView {
    func centerHorizontally(offset: Double = 0.0) {
        guard let superview = superview else { return }
        centerXAnchor.constraint(equalTo: superview.centerXAnchor, constant: offset).isActive = true
    }

    func centerVertically(offset: Double = 0.0) {
        guard let superview = superview else { return }
        centerYAnchor.constraint(equalTo: superview.centerYAnchor, constant: offset).isActive = true
    }

    func centerInSuperview() {
        centerHorizontally()
        centerVertically()
    }
}
