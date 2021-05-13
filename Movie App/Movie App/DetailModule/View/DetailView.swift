//
//  DetailView.swift
//  Movie App
//
//  Created by  protodimbo on 12.05.2021.
//

import UIKit

protocol DetailViewDelegate: AnyObject {
    func setupTableViewDelegate() -> UITableViewDelegate
    func setupTableViewDataSource() -> UITableViewDataSource
}

final class DetailView: UIView {
    // MARK: - Public properties

    weak var delegate: DetailViewDelegate? {
        didSet {
            setupDelegate()
        }
    }

    private(set) var detailTableView = UITableView()

    // MARK: - View life cycle

    override func layoutSubviews() {
        backgroundColor = .systemBackground

        addSubview(detailTableView)

        detailTableView.anchor(
            top: topAnchor,
            bottom: bottomAnchor,
            leading: leadingAnchor,
            trailing: trailingAnchor
        )
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        config()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private methods

    private func config() {
        detailTableView.backgroundColor = .systemBackground
        setupDetailTableView()
    }

    private func setupDetailTableView() {
        detailTableView.register(
            DetailPhotosScrollViewTableViewCell.self,
            forCellReuseIdentifier: DetailPhotosScrollViewTableViewCell.identifier
        )
        detailTableView.register(
            DetailTitleTableViewCell.self,
            forCellReuseIdentifier: DetailTitleTableViewCell.identifier
        )
        detailTableView.register(
            DetailInfoTableViewCell.self,
            forCellReuseIdentifier: DetailInfoTableViewCell.identifier
        )
    }

    private func setupDelegate() {
        detailTableView.delegate = delegate?.setupTableViewDelegate()
        detailTableView.dataSource = delegate?.setupTableViewDataSource()
    }
}
