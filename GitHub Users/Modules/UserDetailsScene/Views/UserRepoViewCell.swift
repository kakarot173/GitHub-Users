//
//  UserRepoViewCell.swift
//  GithubUserListApp
//
//  Created by Animesh Mohanty on 26/06/24.
//

import UIKit

final class UserRepoViewCell: UITableViewCell {
    // MARK: - Properties
    static let reuseIdentifier = String(describing: UserRepoViewCell.self)

    // MARK: - Views
    lazy var nameView: UILabel = {
        let label = UILabel()
        label.font = CustomFont.TitleBold.font
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var descriptionView: UILabel = {
        let label = UILabel()
        label.font = CustomFont.BodyMedium.font
        label.numberOfLines = 4
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var starCountView: IconLabelView = {
        let view = IconLabelView()
        view.setup(image: UIImage(systemName: "star.fill"))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var languageView: IconLabelView = {
        let view = IconLabelView()
        view.setup(image: Image.laptop.value)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameView, descriptionView, starCountView, languageView])
        stackView.axis = .vertical
        stackView.spacing = Spacing.x8.value
        stackView.alignment = .leading
//        stackView.distribution =
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    // MARK: - Methods
    func setup(_ model: UserRepoSuccess) {
        setupView()
        nameView.text = model.name
        descriptionView.text = model.description
        starCountView.labelView.text = "\(model.stargazersCount)"
        languageView.labelView.text = model.language
    }
}

// MARK: - ViewCodeProtocol
extension UserRepoViewCell: ViewCodeProtocol {
    func setupHierarchy() {
        addSubview(mainStackView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Spacing.x16.value),
            mainStackView.topAnchor.constraint(equalTo: topAnchor, constant: Spacing.x16.value),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Spacing.x16.value),
            mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Spacing.x16.value)
        ])
    }
}
