//
//  UserListPresenter.swift
//  GithubUserListApp
//
//  Created by Animesh Mohanty on 26/06/24.
//

import Foundation

protocol UserListPresenterProtocol {
    func presentData(_ response: UserListResponse)
    func presentError()
}

final class UserListPresenter {
    weak var displayer: UserListDisplayProtocol?
}

extension UserListPresenter: UserListPresenterProtocol {
    func presentData(_ response: UserListResponse) {
        var data: [UserViewModel] = response.map { userResponse in
            UserViewModel.success(
                UserSuccess(
                    userName: "@\(userResponse.login)",
                    avatarUrl: userResponse.avatarUrl,
                    reposUrl: userResponse.reposUrl
                )
            )
        }
        if !data.isEmpty {
            data.append(UserViewModel.loading)
        }
        displayer?.displayData(data)
    }

    func presentError() {
        displayer?.displayError()
    }
}
