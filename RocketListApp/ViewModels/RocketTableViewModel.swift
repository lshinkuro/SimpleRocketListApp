//
//  RocketTableViewModel.swift
//  RocketListApp
//
//  Created by nur kholis on 10/02/23.
//

import Foundation
import UIKit


final class RocketTableViewModel: NSObject {

  public let rocketName: String
  public let rocketDescription: String
  public let rocketImage: URL?
  public let country: String
  public let costPerLaunch: Int
  public let firstFlight: String

  init(rocketName: String,
       rocketDescription: String,
       rocketImage: URL?,
       country: String,
       costPerLaunch: Int,
       firstFlight: String) {
    self.rocketName = rocketName
    self.rocketDescription = rocketDescription
    self.rocketImage = rocketImage
    self.country = country
    self.costPerLaunch = costPerLaunch
    self.firstFlight = firstFlight
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
