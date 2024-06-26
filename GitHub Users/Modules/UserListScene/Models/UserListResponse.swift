//
//  UserListResponse.swift
//  GithubUserListApp
//
//  Created by Animesh Mohanty on 26/06/24.
//

import Foundation

typealias UserListResponse = [UserResponse]

struct UserResponse: Decodable {
    let id: Int
    let login: String
    let avatarUrl: String
    let reposUrl: String
}
