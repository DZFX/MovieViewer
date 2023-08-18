//
//  MainGridCell.swift
//  MovieViewer
//
//  Created by Isaac Delgado on 17/08/23.
//

import UIKit

class MovieCell: UICollectionViewCell {
    private lazy var imageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 25
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private lazy var titleLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = AppColors.green
        return label
    }()

    private lazy var dateLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = AppColors.green
        return label
    }()

    private lazy var ratingLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = AppColors.green
        label.textAlignment = .right
        return label
    }()

    private lazy var descriptionLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 11)
        label.textColor = .white
        label.numberOfLines = 4
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupContent()
        backgroundColor = AppColors.cellBackgroundColor
        clipsToBounds = true
        layer.cornerRadius = 25
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with viewModel: MovieCellModel) {
        titleLabel.text = viewModel.title
        dateLabel.text = viewModel.date
        ratingLabel.text = viewModel.rating
        descriptionLabel.text = viewModel.description
        imageView.image = nil
        imageView.setImage(from: viewModel.imageURL) { [weak self] image in
            guard self?.titleLabel.text == viewModel.title else { return }
            self?.imageView.image = image
        }
    }

    private func setupContent() {
        let verticalStack = UIStackView()
        verticalStack.translatesAutoresizingMaskIntoConstraints = false
        verticalStack.axis = .vertical
        verticalStack.distribution = .fill
        verticalStack.alignment = .center
        verticalStack.spacing = 5
        let horizontalStack = UIStackView()
        horizontalStack.axis = .horizontal
        horizontalStack.distribution = .fillProportionally
        horizontalStack.alignment = .fill
        let bottomVerticalStack = UIStackView()
        bottomVerticalStack.axis = .vertical
        bottomVerticalStack.distribution = .fillProportionally
        bottomVerticalStack.alignment = .fill
        bottomVerticalStack.spacing = 8
        contentView.addSubview(verticalStack)
        verticalStack.addHorizontalPaddingWithSuperview()
        verticalStack.alignTopSpaceWithSuperview()
        verticalStack.alignBottomSpaceWithSuperview(offset: 20)
        verticalStack.addArrangedSubview(imageView)
        imageView.heightAnchor.constraint(equalTo: verticalStack.heightAnchor, multiplier: 0.6).isActive = true
        verticalStack.addArrangedSubview(bottomVerticalStack)
        bottomVerticalStack.addHorizontalPaddingWithSuperview(offset: 10)
        bottomVerticalStack.addArrangedSubview(titleLabel)
        bottomVerticalStack.addArrangedSubview(horizontalStack)
        horizontalStack.addArrangedSubview(dateLabel)
        horizontalStack.addArrangedSubview(ratingLabel)
        bottomVerticalStack.addArrangedSubview(descriptionLabel)
    }
}

extension MovieCell: ReusableIdentifier {}
