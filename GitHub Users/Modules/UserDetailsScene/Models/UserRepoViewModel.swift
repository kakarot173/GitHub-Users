//
//  UserRepoViewModel.swift
//  GithubUserListApp
//
//  Created by Animesh Mohanty on 26/06/24.
//

enum UserRepoViewModel {
    case success(UserRepoSuccess)
    case loading
    case error
}

struct UserRepoSuccess: Decodable {
    let name: String
    let description: String
    let url: String
    let stargazersCount: Int
    let language: String
}
