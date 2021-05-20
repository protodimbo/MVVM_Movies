//
//  CategoryView.swift
//  Movie App
//
//  Created by  protodimbo on 12.05.2021.
//

import UIKit

/// CategoryViewDelegate
protocol CategoryViewDelegate: AnyObject {
    func setupCollectionViewDelegate() -> UICollectionViewDelegate
    func setupCollectionViewDataSource() -> UICollectionViewDataSource
}

final class CategoryView: UIView {
    // MARK: - Public properties

    weak var delegate: CategoryViewDelegate? {
        didSet {
            setupDelegate()
        }
    }

    // MARK: - Private properties

    private var categoryCollectionView: UICollectionView? = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 10
        layout.itemSize = CGSize(width: 150, height: 30)
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .systemBackground
        collection.showsHorizontalScrollIndicator = false
        collection.register(
            CategoryCollectionViewCell.self,
            forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier
        )
        return collection
    }()

    // MARK: - View life cycle

    override func layoutSubviews() {
        backgroundColor = .systemBackground

        addSubview(categoryCollectionView ?? UICollectionView())

        categoryCollectionView?.anchor(
            top: topAnchor,
            bottom: bottomAnchor,
            leading: leadingAnchor,
            trailing: trailingAnchor,
            paddingLeading: 10,
            paddingTrailing: 10
        )
    }

    // MARK: - Public Method

    // MARK: - Private methods

    private func setupDelegate() {
        categoryCollectionView?.delegate = delegate?.setupCollectionViewDelegate()
        categoryCollectionView?.dataSource = delegate?.setupCollectionViewDataSource()
    }
}
