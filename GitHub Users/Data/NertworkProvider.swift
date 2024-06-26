//
//  NertworkProvider.swift
//  GithubUserListApp
//
//  Created by Animesh Mohanty on 26/06/24.
//

import Foundation

protocol NertworkProviderProcotol {
    typealias Completion<T: Decodable, E: Error> = ((Result<T, E>) -> Void)

    func makeRequest(_ request: NetworkRequest, completion: @escaping Completion<Data, Error>)
    func makeRequest<T>(_ request: NetworkRequest, completion: @escaping Completion<T, Error>)
}

final class NertworkProvider: NertworkProviderProcotol {
    func makeRequest(_ request: NetworkRequest, completion: @escaping Completion<Data, Error>) {
        do {
            let urlRequest = try makeRequest(with: request)
            let task = URLSession.shared.dataTask(with: urlRequest) { [weak self] data, urlResponse, error in
                if let error = error {
                    self?.complete(completion, with: .failure(error))
                    return
                }
                if let urlResponse = urlResponse as? HTTPURLResponse, urlResponse.statusCode != 200 {
                    self?.complete(completion, with: .failure(NertworkError.unknown))
                    return
                }
                guard let data = data else {
                    self?.complete(completion, with: .failure(NertworkError.emptyResponse))
                    return
                }
                self?.complete(completion, with: .success(data))
            }
            task.resume()
        } catch {
            complete(completion, with: .failure(error))
        }
    }

    func makeRequest<T>(_ request: NetworkRequest, completion: @escaping Completion<T, Error>) {
        makeRequest(request) { [weak self] result in
            switch result {
            case let .success(data):
                do {
                    let decodedResponse = try request.decoder.decode(T.self, from: data)
                    self?.complete(completion, with: .success(decodedResponse))
                } catch {
                    self?.complete(completion, with: .failure(NertworkError.decodingError(error.localizedDescription)))
                }
            case let .failure(error):
                self?.complete(completion, with: .failure(error))
            }
        }
    }

    private func makeRequest(with request: NetworkRequest) throws -> URLRequest {
        guard var urlComponents = URLComponents(string: request.endpoint) else {
            throw NertworkError.invalidUrl
        }
        urlComponents.queryItems = request.queryParams?.compactMap { key, value in
            URLQueryItem(name: key, value: value)
        }

        guard let url = urlComponents.url else {
            throw NertworkError.invalidParams
        }

        var urlRequest = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad)
        urlRequest.httpMethod = request.httpMethod.rawValue
        urlRequest.httpBody = request.body
        request.headers?.forEach { key, value in
            urlRequest.addValue(value, forHTTPHeaderField: key)
        }

        return urlRequest
    }

    private func complete<T: Decodable, E: Error>(
        _ completion: @escaping Completion<T, E>,
        with result: Result<T, E>
    ) {
        DispatchQueue.main.async {
            completion(result)
        }
    }
}
