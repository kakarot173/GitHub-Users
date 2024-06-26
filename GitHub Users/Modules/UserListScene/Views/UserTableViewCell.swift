//
//  UserTableViewCell.swift
//  GithubUserListApp
//
//  Created by Animesh Mohanty on 26/06/24.
//

import UIKit

final class UserTableViewCell: UITableViewCell {
    // MARK: - Properties
    static let reuseIdentifier = String(describing: UserTableViewCell.self)
    let iconSize = Spacing.x64.value

    // MARK: - Views
    lazy var iconView: AsyncImageView = {
        let view = AsyncImageView(iconSize: CGSize(width: iconSize, height: iconSize))
        view.layer.cornerRadius = iconSize / 2
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var userName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        return label
    }()

    lazy var mainStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [iconView, userName])
        stack.axis = .horizontal
        stack.spacing = iconSize / 2
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var decorImageView: UIImageView = {
        let obj = UIImageView(image: UIImage(systemName: "chevron.right"))
        obj.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: Spacing.x16.value, height: Spacing.x16.value))
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()
    // MARK: - Life cycle
    override func prepareForReuse() {
        super.prepareForReuse()
        iconView.startAnimating()
    }

    // MARK: Methods
    func setup(_ model: UserSuccess) {
        userName.text = model.userName
        setupView()
        iconView.startDownload(url: model.avatarUrl)
    }
}

// MARK: - ViewCodeProtocol
extension UserTableViewCell: ViewCodeProtocol {
    func setupHierarchy() {
//        addSubview(decorImageView)
        addSubview(mainStackView)
    }

    func setupConstraints() {
//        NSLayoutConstraint.activate([
////            decorImageView.widthAnchor.constraint(equalToConstant: Spacing.x16.value),
////            decorImageView.heightAnchor.constraint(equalToConstant: Spacing.x16.value),
//            decorImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Spacing.x8.value),
//            decorImageView.topAnchor.constraint(equalTo: topAnchor, constant: contentView.frame.height/2)
//                                    ])
        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Spacing.x16.value),
            mainStackView.topAnchor.constraint(equalTo: topAnchor, constant: Spacing.x16.value),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Spacing.x4.value),
            mainStackView.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -Spacing.x16.value)
        ])
    }
}
