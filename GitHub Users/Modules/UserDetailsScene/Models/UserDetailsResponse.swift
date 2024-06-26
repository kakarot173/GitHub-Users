//
//  UserDetailsResponse.swift
//  GithubUserListApp
//
//  Created by Animesh Mohanty on 26/06/24.
//

import Foundation

struct UserDetailsResponse: Decodable {
    let login: String
    let avatarUrl: String
    let name: String
    let followers: Int
    let following: Int
}
