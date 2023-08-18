//
//  MainGridCell.swift
//  MovieViewer
//
//  Created by Isaac Delgado on 17/08/23.
//

import UIKit

struct MovieCellModel {
    var title: String
}

class MovieCell: UICollectionViewCell {
    private lazy var label = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(label)
        label.centerInSuperview()
        backgroundColor = .brown
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with viewModel: MovieCellModel) {
        label.text = viewModel.title
    }
}

extension MovieCell: ReusableIdentifier {}
