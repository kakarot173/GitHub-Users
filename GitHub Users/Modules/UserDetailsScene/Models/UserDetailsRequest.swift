//
//  UserDetailsRequest.swift
//  GithubUserListApp
//
//  Created by Animesh Mohanty on 26/06/24.
//

import Foundation

struct UserDetailsRequest: NetworkRequest {
    var userName: String

    var endpoint: String {
        NetworkConstants.Endpoint.users + "/" + userName
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
