//
//  UserDetailsViewModel.swift
//  GithubUserListApp
//
//  Created by Animesh Mohanty on 26/06/24.
//

enum UserDetailsViewModel {
    case success(UserDetailsSuccess)
    case loading
    case error
}

struct UserDetailsSuccess: Decodable {
    let userName: String
    let avatarUrl: String
    let fullName: String
    let followersCount: Int
    let followingCount: Int
}
