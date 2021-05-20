//
//  DetailTitleTableViewCell.swift
//  Movie App
//
//  Created by  protodimbo on 12.05.2021.
//

import UIKit

final class DetailTitleTableViewCell: UITableViewCell {
    static let identifier = "DetailTitleTableViewCell"

    // MARK: - Public Properties

    var viewModel: DetailPhotoViewModelType? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            titleLabel.text = viewModel.film?.title
        }
    }

    // MARK: - Private Properties

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    // MARK: - Lifecycle

    override func layoutSubviews() {
        addSubview(titleLabel)
        titleLabel.anchor(top: topAnchor, bottom: bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor)
    }

    // MARK: - Public Methods

    func configure(text: String?) {
        titleLabel.text = text
    }
}
