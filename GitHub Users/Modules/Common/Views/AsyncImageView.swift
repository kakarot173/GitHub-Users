//
//  AsyncImageView.swift
//  GithubUserListApp
//
//  Created by Animesh Mohanty on 26/06/24.
//

import UIKit

final class AsyncImageView: UIImageView {
    // MARK: - Properties
    let iconSize: CGSize
    lazy var customViews = [loadingView, iconView]

    // MARK: - Views
    lazy var loadingView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .medium)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var iconView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: - Life cycle
    init(iconSize: CGSize) {
        self.iconSize = iconSize
        super.init(frame: .zero)
        setupView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods
    func startLoading() {
        updateMainView(with: loadingView)
        loadingView.startAnimating()
    }

    func startDownload(url: String) {
        startLoading()
        ImageProvider.getImage(url: url) { [weak self] uiImage in
            self?.iconView.image = uiImage
            self?.updateMainView(with: self?.iconView)
        }
    }

    private func updateMainView(with view: UIView?) {
        guard let view = view else { return }
        customViews.forEach { view in
            view.isHidden = true
        }
        UIView.transition(
            with: view, duration: 0.5,
            options: .transitionCrossDissolve,
            animations: {
                view.isHidden = false
            }
        )
        setNeedsLayout()
        layoutIfNeeded()
    }
}

// MARK: - ViewCodeProtocol
extension AsyncImageView: ViewCodeProtocol {
    func setupHierarchy() {
        addSubview(loadingView)
        addSubview(iconView)
    }

    func setupConstraints() {
        widthAnchor.constraint(equalToConstant: iconSize.width).isActive = true

        let heightConstraint = heightAnchor.constraint(equalToConstant: iconSize.height)
        heightConstraint.priority = .defaultHigh
        heightConstraint.isActive = true

        customViews.forEach { view in
            NSLayoutConstraint.activate([
                view.widthAnchor.constraint(equalToConstant: iconSize.width),
                view.heightAnchor.constraint(equalToConstant: iconSize.height)
            ])
        }
    }
}
