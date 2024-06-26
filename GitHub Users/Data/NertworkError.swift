//
//  NertworkError.swift
//  GithubUserListApp
//
//  Created by Animesh Mohanty on 26/06/24.
//

enum NertworkError: Error {
    case unknown
    case emptyResponse
    case invalidUrl
    case invalidParams
    case decodingError(String)
}
