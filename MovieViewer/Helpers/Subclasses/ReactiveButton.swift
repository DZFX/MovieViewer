//
//  ReactiveButton.swift
//  MovieViewer
//
//  Created by Isaac Delgado on 16/08/23.
//

import UIKit

class ReactiveButton: UIButton {
    override var isEnabled: Bool {
        didSet {
            alpha = isEnabled ? 1.0 : 0.7
        }
    }
}
