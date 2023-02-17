//
//  Endpoint.swift
//  RocketListApp
//
//  Created by nur kholis on 10/02/23.
//

import Foundation

enum Endpoint {
  case fetchRocket

  func path() -> String {
    switch self {
    case .fetchRocket:
      return "/rockets"
    }
  }

  func method() -> String {
    switch self {
    case .fetchRocket:
      return "GET"
    }
  }

  var parameters: [String: Any]? {
    switch self {
    case .fetchRocket:
      return nil
    }
  }

  func urlString() -> String {
    return BaseConstant.baseUrl + self.path()
  }
}

