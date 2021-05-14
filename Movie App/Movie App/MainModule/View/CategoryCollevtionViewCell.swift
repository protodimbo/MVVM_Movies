//
//  CategoryCollevtionViewCell.swift
//  Movie App
//
//  Created by  protodimbo on 12.05.2021.
//

import UIKit

final class CategoryCollectionViewCell: UICollectionViewCell {
    static let identifier = "CategoryCollectionViewCell"

    // MARK: - Private properties

    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 15)
        label.backgroundColor = .systemBackground
        label.layer.cornerRadius = 5
        label.layer.borderWidth = 2
        label.layer.borderColor = UIColor.label.cgColor
        label.layer.masksToBounds = true
        return label
    }()

    // MARK: - View life cycle

    override func layoutSubviews() {
        addSubview(categoryLabel)

        categoryLabel.anchor(top: topAnchor, bottom: bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor)
    }

    // MARK: - Public Methods

    func setup(text: String) {
        categoryLabel.text = text
    }
}
