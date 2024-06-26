//
//  NetworkConstants.swift
//  GithubUserListApp
//
//  Created by Animesh Mohanty on 26/06/24.
//

enum NetworkConstants {
    enum Endpoint {
        static let users = "https://api.github.com/users"
    }

    enum Params {
        static let bearer = "Bearer "
    }

    enum Header {
        static let accept = "Accept"
        static let gitApiVersion = "X-GitHub-Api-Version"
        static let auth = "Authorization"
    }
}
