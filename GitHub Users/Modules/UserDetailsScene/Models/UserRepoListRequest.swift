//
//  UserRepoListRequest.swift
//  GithubUserListApp
//
//  Created by Animesh Mohanty on 26/06/24.
//

import Foundation

struct UserRepoListRequest: NetworkRequest {
    var endpoint: String
    var nextPage: Int
    var pageSize: Int

    var queryParams: [String: String]? {
        [
            Constants.pageParam: "\(nextPage)",
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

extension UserRepoListRequest {
    enum Constants {
        static let pageParam = "page"
        static let pageSizeParam = "per_page"
    }
}
