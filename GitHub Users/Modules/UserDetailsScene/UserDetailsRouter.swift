//
//  UserDetailsRouter.swift
//  GithubUserListApp
//
//  Created by Animesh Mohanty on 26/06/24.
//

import UIKit

protocol UserDetailsRouterProtocol {
    func openRepo(_ url: String)
}

final class UserDetailsRouter {
    weak var viewController: UserDetailsScreen?

    func setup(userName: String, reposUrl: String) -> UIViewController {
        let provider = NertworkProvider()
        let presenter = UserDetailsPresenter()
        let interactor = UserDetailsInteractor(
            userName: userName,
            reposUrl: reposUrl,
            provider: provider,
            presenter: presenter
        )
        let viewController = UserDetailsScreen(interactor: interactor, router: self)
        presenter.displayer = viewController
        self.viewController = viewController
        return viewController
    }
}

extension UserDetailsRouter: UserDetailsRouterProtocol {
    func openRepo(_ url: String) {
        let webView = WebViewController(url: url)
        viewController?.navigationController?.present(webView, animated: true)
    }
}
