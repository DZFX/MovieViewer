//
//  ViewController.swift
//  MovieViewer
//
//  Created by Isaac Delgado on 16/08/23.
//

import UIKit

class ViewController: UIViewController {
    override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }
    override func viewDidLoad() {
        super.viewDidLoad()
        let gradientLayer = AppColors.backgroundGradient
        gradientLayer.frame = view.frame
        view.layer.insertSublayer(gradientLayer, at: 0)
        modalPresentationStyle = .fullScreen
    }
}

class NavigationController: UINavigationController {
    override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }
    override func viewDidLoad() {
        super.viewDidLoad()
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithDefaultBackground()
        navigationBarAppearance.backgroundColor = AppColors.navigationBarColor
        navigationBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationBar.tintColor = .white
        navigationBar.standardAppearance = navigationBarAppearance
        navigationBar.scrollEdgeAppearance = navigationBarAppearance
        modalPresentationStyle = .fullScreen
    }
}
