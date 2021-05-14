// FilmTableViewCell.swift

import UIKit

/// Custom table view cell
final class FilmTableViewCell: UITableViewCell {
    static let identifier = "FilmTableViewCell"
    weak var viewModel: TableViewCellViewModelType? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            filmImageView.image = viewModel.filmImage
            filmNameTextView.text = viewModel.filmName
            starImageView.image = viewModel.heartImage
            ratingLabel.text = viewModel.stringVoteAverage
            dateLabel.text = "Вышел: \(viewModel.releaseDate.replacingOccurrences(of: "-", with: "/"))"
        }
    }

    private let filmImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        return imageView
    }()

    private let filmNameTextView: UITextView = {
        let label = UITextView()
        label.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        label.textAlignment = .left
        label.isUserInteractionEnabled = false
        return label
    }()

    private let starImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25, weight: .medium)
        return label
    }()

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(filmImageView)
        contentView.addSubview(filmNameTextView)
        contentView.addSubview(starImageView)
        contentView.addSubview(ratingLabel)
        contentView.addSubview(dateLabel)
        layoutConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        selectionStyle = .none
    }

    private func layoutConstraints() {
        layoutFilmImageViewConstraints()
        layoutFilmNameTextViewConstraints()
        layoutStarImageViewConstraints()
        layoutRatingLabelConstraints()
        layoutDateLabelConstraints()
    }

    private func layoutFilmImageViewConstraints() {
        filmImageView.anchor(
            top: contentView.topAnchor,
            bottom: contentView.bottomAnchor,
            leading: contentView.leadingAnchor,
            trailing: filmNameTextView.leadingAnchor,
            paddingTop: 5,
            paddingBottom: 5,
            paddingLeading: 5,
            paddingTrailing: 5,
            width: 150
        )
    }

    private func layoutFilmNameTextViewConstraints() {
        filmNameTextView.anchor(
            top: contentView.topAnchor,
            bottom: starImageView.topAnchor,
            trailing: contentView.trailingAnchor,
            paddingTop: 5,
            paddingBottom: 5,
            paddingTrailing: 5
        )
    }

    private func layoutStarImageViewConstraints() {
        starImageView.anchor(
            bottom: dateLabel.topAnchor,
            leading: filmImageView.trailingAnchor,
            trailing: ratingLabel.leadingAnchor,
            paddingBottom: 5,
            paddingLeading: 5,
            paddingTrailing: 5
        )
    }

    private func layoutRatingLabelConstraints() {
        ratingLabel.anchor(
            top: filmNameTextView.bottomAnchor,
            bottom: dateLabel.topAnchor,
            trailing: contentView.trailingAnchor,
            paddingTop: 5,
            paddingBottom: 5,
            paddingTrailing: 5
        )
    }

    private func layoutDateLabelConstraints() {
        dateLabel.anchor(
            bottom: contentView.bottomAnchor,
            leading: filmImageView.trailingAnchor,
            trailing: contentView.trailingAnchor,
            paddingBottom: 5,
            paddingLeading: 5,
            paddingTrailing: 5
        )
    }
}
