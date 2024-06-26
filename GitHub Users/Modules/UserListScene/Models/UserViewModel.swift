//
//  UserViewModel.swift
//  GithubUserListApp
//
//  Created by Animesh Mohanty on 26/06/24.
//

enum UserViewModel {
    case success(UserSuccess)
    case loading
    case error
}

struct UserSuccess {
    let userName: String
    let avatarUrl: String
    let reposUrl: String
}
