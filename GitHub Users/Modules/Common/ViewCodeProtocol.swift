//
//  ViewCodeProtocol.swift
//  GithubUserListApp
//
//  Created by Animesh Mohanty on 26/06/24.
//

protocol ViewCodeProtocol {
    func setupView()
    func setupHierarchy()
    func setupConstraints()
    func setupConfigurations()
}

extension ViewCodeProtocol {
    func setupView() {
        setupHierarchy()
        setupConstraints()
        setupConfigurations()
    }

    func setupConfigurations() {
        /* Optional */
    }
}
