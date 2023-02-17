//
//  Constant.swift
//  RocketListApp
//
//  Created by nur kholis on 10/02/23.
//

import Foundation
import UIKit

class BaseConstant {
  static let baseUrl = "https://api.spacexdata.com/v4"
}

enum SFSymbols {
    static let profileSymbol = UIImage(systemName: "person.fill")
    static let rocketSymbol = UIImage(systemName: "list.bullet")
    static let arrowSymbol = UIImage(systemName: "arrow.right.circle.fill")
    static let statusSymbol = UIImage(systemName: "circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 8, weight: .regular, scale: .default))
}

enum ScreenSize {
    static let width        = UIScreen.main.bounds.size.width
    static let height       = UIScreen.main.bounds.size.height
    static let maxLength    = max(ScreenSize.width, ScreenSize.height)
    static let minLength    = min(ScreenSize.width, ScreenSize.height)
}

