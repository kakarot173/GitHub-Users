//
//  UserListRequest.swift
//  GithubUserListApp
//
//  Created by Animesh Mohanty on 26/06/24.
//

import Foundation

struct UserListRequest: NetworkRequest {
    var lastId: Int
    var pageSize: Int

    var endpoint: String {
        NetworkConstants.Endpoint.users
    }

    var queryParams: [String: String]? {
        [
            Constants.lastIdParam: "\(lastId)",
            Constants.pageSizeParam: "\(pageSize)"
        ]
    }

    var headers: [String: String]? {
        [
            NetworkConstants.Header.accept: "application/vnd.github+json",
            NetworkConstants.Header.gitApiVersion: "2022-11-28"
        ]
    }

    var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
}

extension UserListRequest {
    enum Constants {
        static let lastIdParam = "since"
        static let pageSizeParam = "per_page"
    }
}
