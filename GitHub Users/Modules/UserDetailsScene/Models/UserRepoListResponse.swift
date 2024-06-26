//
//  UserRepoListResponse.swift
//  GithubUserListApp
//
//  Created by Animesh Mohanty on 26/06/24.
//

import Foundation

struct UserRepoResponse: Decodable {
    let name: String
    let description: String?
    let cloneUrl: String
    let stargazersCount: Int
    let language: String?
    let fork: Bool
}

typealias UserRepoListResponse = [UserRepoResponse]
