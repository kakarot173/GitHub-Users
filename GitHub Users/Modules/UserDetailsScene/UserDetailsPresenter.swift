//
//  UserDetailsPresenter.swift
//  GithubUserListApp
//
//  Created by Animesh Mohanty on 26/06/24.
//

import Foundation

protocol UserDetailsPresenterProtocol {
    func presentUserDetails(_ response: UserDetailsResponse)
    func presentUserDetailsLoading()
    func presentUserDetailsError()
    func presentRepoList(_ response: UserRepoListResponse)
    func presentRepoListError()
}

final class UserDetailsPresenter {
    weak var displayer: UserDetailsDisplayProtocol?
}

extension UserDetailsPresenter: UserDetailsPresenterProtocol {
    func presentUserDetails(_ response: UserDetailsResponse) {
        let viewModel = UserDetailsSuccess(
            userName: response.login,
            avatarUrl: response.avatarUrl,
            fullName: response.name,
            followersCount: response.followers,
            followingCount: response.following
        )
        displayer?.displayUserDetails(.success(viewModel))
    }

    func presentUserDetailsLoading() {
        displayer?.displayUserDetails(.loading)
    }

    func presentUserDetailsError() {
        displayer?.displayUserDetails(.error)
    }

    func presentRepoList(_ response: UserRepoListResponse) {
        var viewModel: [UserRepoViewModel] = response.compactMap { responseModel in
            guard !responseModel.fork else {
                return nil
            }
            return UserRepoViewModel.success(
                UserRepoSuccess(
                    name: responseModel.name,
                    description: responseModel.description ?? String(),
                    url: responseModel.cloneUrl,
                    stargazersCount: responseModel.stargazersCount,
                    language: responseModel.language ?? String()
                )
            )
        }
        if !viewModel.isEmpty {
            viewModel.append(.loading)
        }
        displayer?.displayRepoList(viewModel)
    }

    func presentRepoListError() {
        displayer?.displayRepoList([.error])
    }
}
