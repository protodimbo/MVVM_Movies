//
//  DetailViewController.swift
//  Movie App
//
//  Created by  protodimbo on 05.03.2021.
//

import UIKit

/// Detail vc
final class DetailViewController: UIViewController {
    private let posterImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.frame = CGRect(x: 40, y: 90, width: 310, height: 500)
        return image
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center
        label.frame = CGRect(x: 50, y: 580, width: 310, height: 30)
        return label
    }()

    private let infoTextView: UITextView = {
        let text = UITextView()
        text.isEditable = false
        text.isScrollEnabled = true
        text.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        text.textAlignment = .center
        text.frame = CGRect(x: 5, y: 610, width: 380, height: 200)
        return text
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureVC()
    }

    func configure(posterName: String, title: String, info: String) {
        DispatchQueue.global().async {
            guard let imageURL = URL(string: "https://image.tmdb.org/t/p/original\(posterName)") else { return }
            guard let data = try? Data(contentsOf: imageURL) else { return }

            DispatchQueue.main.async {
                self.posterImage.image = UIImage(data: data)
                self.titleLabel.text = title
                self.infoTextView.text = info
            }
        }
    }

    private func configureVC() {
        view.backgroundColor = .systemBackground
        view.addSubview(posterImage)
        view.addSubview(titleLabel)
        view.addSubview(infoTextView)
    }
}
