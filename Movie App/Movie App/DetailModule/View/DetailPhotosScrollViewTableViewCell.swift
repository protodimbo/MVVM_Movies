//
//  DetailPhotosScrollViewTableViewCell.swift
//  Movie App
//
//  Created by  protodimbo on 12.05.2021.
//

import UIKit

final class DetailPhotosScrollViewTableViewCell: UITableViewCell {
    static let identifier = "DetailPhotosScrollViewTableViewCell"

    var viewModel: DetailPhotoViewModel? {
        didSet(viewModel) {
            guard let viewModel = viewModel else { return }
            configure(images: viewModel.images)
        }
    }

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        return scrollView
    }()

    func configure(images: [UIImage?]) {
        setup(with: images)
    }

    private func setup(with images: [UIImage?]) {
        configureScrollView(
            withHeight: 400,
            contentSize: bounds.width * CGFloat(images.count)
        )

        let imageViews = images.map { UIImageView(image: $0) }

        for index in 0 ..< imageViews.count {
            imageViews[index].layer.masksToBounds = true
            imageViews[index].contentMode = .scaleAspectFill
            scrollView.addSubview(imageViews[index])

            if index == 0 {
                imageViews[index].anchor(
                    top: topAnchor,
                    leading: scrollView.leadingAnchor,
                    width: bounds.width,
                    height: scrollView.contentSize.height
                )
            } else {
                scrollView.addSubview(imageViews[index])
                imageViews[index].anchor(
                    top: topAnchor,
                    leading: imageViews[index - 1].trailingAnchor,
                    width: bounds.width,
                    height: scrollView.contentSize.height
                )
            }
        }
    }

    private func configureScrollView(withHeight height: CGFloat, contentSize: CGFloat) {
        addSubview(scrollView)

        scrollView.contentSize = CGSize(
            width: contentSize,
            height: height
        )

        scrollView.anchor(
            top: topAnchor,
            bottom: bottomAnchor,
            leading: leadingAnchor,
            trailing: trailingAnchor,
            height: height
        )
    }
}
