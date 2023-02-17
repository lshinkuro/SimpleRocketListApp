//
//  RocketListDetailViewModel.swift
//  RocketListApp
//
//  Created by nur kholis on 10/02/23.
//

import Foundation

class RocketListDetailViewModel: NSObject {
  
  let rocket: RocketTableViewModel
  public let rocketImage: URL?

  init(rocket: RocketTableViewModel) {
    self.rocket = rocket
    self.rocketImage = rocket.rocketImage
  }

  public var title: String {
    return rocket.rocketName.uppercased()
  }

  public func fetchImage(completion: @escaping(Result<Data, Error>) -> Void) {
    guard let url =  rocketImage  else {
      completion(.failure(URLError(.badURL)))
      return
    }
    let request = URLRequest(url: url)
    let task = URLSession.shared.dataTask(with: request) { data, _, error in
      guard let data = data, error == nil else {
        completion(.failure(error ?? URLError(.badServerResponse)))
        return
      }
      completion(.success(data))
    }
   task.resume()
  }
  
}
