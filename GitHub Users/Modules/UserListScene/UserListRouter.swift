//
//  UserListRouter.swift
//  GithubUserListApp
//
//  Created by Animesh Mohanty on 26/06/24.
//

import UIKit

protocol UserListRouterProtocol: AnyObject {
    func openDetails(userName: String, reposUrl: String)
    func present(_ viewController: UIViewController)
}

final class UserListRouter {
    weak var viewController: UserListScreen?

    func setup() -> UIViewController {
        let provider = NertworkProvider()
        let presenter = UserListPresenter()
        let interactor = UserListInteractor(provider: provider, presenter: presenter)
        let viewController = UserListScreen(interactor: interactor, router: self)
        presenter.displayer = viewController
        self.viewController = viewController
        return viewController
    }
}

extension UserListRouter: UserListRouterProtocol {
    func openDetails(userName: String, reposUrl: String) {
        let userDetails = UserDetailsRouter().setup(userName: userName, reposUrl: reposUrl)
        viewController?.navigationController?.pushViewController(userDetails, animated: true)
    }

    func present(_ viewController: UIViewController) {
        self.viewController?.navigationController?.present(viewController, animated: true)
    }
}
