//
//  AppColors.swift
//  MovieViewer
//
//  Created by Isaac Delgado on 16/08/23.
//

import UIKit

enum AppColors {
    static let backgroundDarkColor = UIColor(red: 12/255, green: 21/255, blue: 26/255, alpha: 1)
    static let backgroundLightColor = UIColor(red: 36/255, green: 65/255, blue: 64/255, alpha: 1)

    static let backgroundGradient: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [backgroundDarkColor, backgroundLightColor]
        gradientLayer.locations = [0.0, 0.8]
        gradientLayer.startPoint = CGPoint(x: 0.4, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.6, y: 1.0)
        return gradientLayer
    }()
}
