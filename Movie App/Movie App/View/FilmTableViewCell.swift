// FilmTableViewCell.swift

import UIKit

/// Custom table view cell
final class FilmTableViewCell: UITableViewCell {
    static let identifier = "FilmTableViewCell"

    private let filmImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.frame = CGRect(x: 15, y: 15, width: 120, height: 160)
        return imageView
    }()

    private let filmNameTextView: UITextView = {
        let label = UITextView()
        label.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        label.textAlignment = .left
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.frame = CGRect(x: 150, y: 15, width: 220, height: 80)
        return label
    }()

    private let starImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.frame = CGRect(x: 150, y: 100, width: 170, height: 40)
        return imageView
    }()

    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.frame = CGRect(x: 330, y: 100, width: 53, height: 40)
        return label
    }()

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.frame = CGRect(x: 150, y: 145, width: 213, height: 25)
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        return label
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(filmImageView)
        contentView.addSubview(filmNameTextView)
        contentView.addSubview(starImageView)
        contentView.addSubview(ratingLabel)
        contentView.addSubview(dateLabel)
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

    func configureCell(
        filmImageLink: String,
        filmName: String,
        starText: String,
        ratingText: String,
        dateString: String
    ) {
        DispatchQueue.global().async {
            guard let imageURL = URL(string: "https://image.tmdb.org/t/p/w500\(filmImageLink)") else { return }
            guard let data = try? Data(contentsOf: imageURL) else { return }

            DispatchQueue.main.async {
                self.filmImageView.image = UIImage(data: data)
                self.filmNameTextView.text = filmName
                self.ratingLabel.text = ratingText
                self.starImageView.image = UIImage(named: starText)
                self.dateLabel.text = "Вышел: \(dateString.replacingOccurrences(of: "-", with: "/"))"
            }
        }
    }
}
