//
//  LoadingTableViewCell.swift
//  GithubUserListApp
//
//  Created by Animesh Mohanty on 26/06/24.
//

import UIKit

final class LoadingTableViewCell: UITableViewCell {
    // MARK: - Properties
    static let reuseIdentifier = String(describing: LoadingTableViewCell.self)

    // MARK: - Views
    lazy var loadingView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .medium)
        view.startAnimating()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: - Life cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        loadingView.startAnimating()
    }
}

// MARK: - ViewCodeProtocol
extension LoadingTableViewCell: ViewCodeProtocol {
    func setupHierarchy() {
        addSubview(loadingView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            loadingView.centerXAnchor.constraint(equalTo: centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
