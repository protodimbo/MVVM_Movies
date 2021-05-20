//
//  DetailInfoTableViewCell.swift
//  Movie App
//
//  Created by  protodimbo on 12.05.2021.
//

import UIKit

final class DetailInfoTableViewCell: UITableViewCell {
    static let identifier = "DetailInfoTableViewCell"

    // MARK: - Public Properties

    var viewModel: DetailPhotoViewModelType? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            infoTextView.text = viewModel.film?.overview
        }
    }

    // MARK: - Private Properties

    private let infoTextView: UITextView = {
        let text = UITextView()
        text.isEditable = false
        text.isScrollEnabled = false
        text.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        text.textAlignment = .center
        return text
    }()

    // MARK: - Lifecycle

    override func layoutSubviews() {
        addSubview(infoTextView)
        infoTextView.anchor(
            top: topAnchor,
            bottom: bottomAnchor,
            leading: leadingAnchor,
            trailing: trailingAnchor
        )
    }

    // MARK: - Public Methods

    func configure(text: String?) {
        infoTextView.text = text
    }
}
