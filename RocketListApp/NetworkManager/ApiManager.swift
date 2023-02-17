//
//  ApiManager.swift
//  RocketListApp
//
//  Created by nur kholis on 10/02/23.
//

import Foundation

final class RMService {

  static let shared = RMService()
  private init() {}

  enum RMServiceError: Error {
    case failedToCreateRequest
    case failedToGetData
  }

  public func execute<T: Codable>(endpoint: Endpoint,
                                  expecting type: T.Type,
                                  completion: @escaping(Result<T, Error>) -> Void) {

    guard let urlRequest = self.request(endpoint: endpoint)  else {
      completion(.failure(RMServiceError.failedToCreateRequest))
      return
    }

    let task = URLSession.shared.dataTask(with: urlRequest) { data, _, error in
      guard let data = data, error == nil else {
        completion(.failure(RMServiceError.failedToGetData))
        return
      }

      do {
        let result = try JSONDecoder().decode(type.self , from: data)
        completion(.success(result))
      } catch {
        completion(.failure(error))
      }
    }
    task.resume()

  }

  public func request(endpoint: Endpoint) -> URLRequest? {
    var url : URL {
      return URL(string: endpoint.urlString()) ?? URL(string: "")!
    }
    var request = URLRequest(url: url)
    request.httpMethod =  endpoint.method()
    return request
  }


}

