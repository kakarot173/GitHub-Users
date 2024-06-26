//
//  NetworkRequest.swift
//  GithubUserListApp
//
//  Created by Animesh Mohanty on 26/06/24.
//

import Foundation

protocol NetworkRequest {
    var endpoint: String { get }
    var body: Data? { get }
    var httpMethod: HTTPMethod { get }
    var queryParams: [String: String]? { get }
    var headers: [String: String]? { get }
    var decoder: JSONDecoder { get }
}

// MARK: - Default values
extension NetworkRequest {
    var body: Data? { nil }
    var httpMethod: HTTPMethod { .get }
    var queryParams: [String: String]? { nil }
    var headers: [String: String]? { nil }
    var decoder: JSONDecoder { JSONDecoder() }
}
