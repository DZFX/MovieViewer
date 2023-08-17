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

    func alignLeadingSpaceWithSuperview(offset: Double = 0.0) {
        guard let superview = superview else { return }
        leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: offset).isActive = true
    }

    func alignTrailingSpaceWithSuperview(offset: Double = 0.0) {
        guard let superview = superview else { return }
        trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -offset).isActive = true
    }

    func addHorizontalPaddingWithSuperview(offset: Double = 0.0) {
        alignLeadingSpaceWithSuperview(offset: offset)
        alignTrailingSpaceWithSuperview(offset: offset)
    }

    func setHeightConstraint(constant: Double) {
        heightAnchor.constraint(equalToConstant: constant).isActive = true
    }

    func setWidthConstraint(constant: Double) {
        widthAnchor.constraint(equalToConstant: constant).isActive = true
    }

    func setSquaredDimensions(to constant: Double) {
        setHeightConstraint(constant: constant)
        setWidthConstraint(constant: constant)
    }
}
