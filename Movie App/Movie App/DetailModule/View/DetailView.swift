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

    // MARK: - Private Properties

    private(set) var detailTableView: UITableView = {
        let table = UITableView()
        table.register(
            DetailPhotosScrollViewTableViewCell.self,
            forCellReuseIdentifier: DetailPhotosScrollViewTableViewCell.identifier
        )
        table.register(DetailTitleTableViewCell.self, forCellReuseIdentifier: DetailTitleTableViewCell.identifier)
        table.register(DetailInfoTableViewCell.self, forCellReuseIdentifier: DetailInfoTableViewCell.identifier)
        table.backgroundColor = .systemBackground
        return table
    }()

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

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private methods

    private func setupDelegate() {
        detailTableView.delegate = delegate?.setupTableViewDelegate()
        detailTableView.dataSource = delegate?.setupTableViewDataSource()
    }
}
