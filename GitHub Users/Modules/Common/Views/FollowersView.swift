//
//  FollowersView.swift
//  GithubUserListApp
//
//  Created by Animesh Mohanty on 26/06/24.
//

import UIKit

final class FollowersView: UIView {
    // MARK: - Properties
    var followersCount: Int
    var followingCount: Int

    // MARK: - Views
    lazy var iconLabelView: IconLabelView = {
        let view = IconLabelView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setup(image: UIImage(systemName: "person.3.sequence"))
        return view
    }()

    // MARK: - Life cycle
    init(followersCount: Int = 0, followingCount: Int = 0) {
        self.followersCount = followersCount
        self.followingCount = followingCount
        super.init(frame: .zero)
        setupView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods
    func update(followersCount: Int = 0, followingCount: Int = 0) {
        self.followersCount = followersCount
        self.followingCount = followingCount
        setupConfigurations()
    }
}

// MARK: - ViewCodeProtocol
extension FollowersView: ViewCodeProtocol {
    func setupHierarchy() {
        addSubview(iconLabelView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            iconLabelView.leadingAnchor.constraint(equalTo: leadingAnchor),
            iconLabelView.topAnchor.constraint(equalTo: topAnchor),
            iconLabelView.trailingAnchor.constraint(equalTo: trailingAnchor),
            iconLabelView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    func setupConfigurations() {
        let attributedText = NSMutableAttributedString()
        attributedText.append(NSAttributedString(string: "\(followersCount) ", attributes: [
            .font: UIFont.boldSystemFont(ofSize: UIFont.systemFontSize)
        ]))
        attributedText.append(NSAttributedString(string: "followers - ", attributes: [
            .font: UIFont.systemFont(ofSize: UIFont.systemFontSize)
        ]))
        attributedText.append(NSAttributedString(string: "\(followingCount) ", attributes: [
            .font: UIFont.boldSystemFont(ofSize: UIFont.systemFontSize)
        ]))
        attributedText.append(NSAttributedString(string: "following", attributes: [
            .font: UIFont.systemFont(ofSize: UIFont.systemFontSize)
        ]))
        iconLabelView.labelView.attributedText = attributedText
    }
}
