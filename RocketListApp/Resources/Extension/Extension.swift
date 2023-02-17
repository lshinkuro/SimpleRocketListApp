//
//  Extension.swift
//  RocketListApp
//
//  Created by nur kholis on 10/02/23.
//

import Foundation
import UIKit

extension UIView {
  func addSubviews(_ views: UIView...) {
    views.forEach {
      self.addSubview($0)
    }
  }
}

extension String {
  var isNotEmpty: Bool {
      !self.isEmpty
  }

  func containsIgnoringCase(_ anotherString: String) -> Bool {
    return self.range(of: anotherString, options: NSString.CompareOptions.caseInsensitive) != nil
  }
}


extension Int {
  func convertToCurrency(symbol: String = "Rp ", identifier: String = "id_ID", groupingSeparator: String = ".", suffix: String = ",00") -> String {
      let formatter = NumberFormatter()
      formatter.locale = Locale(identifier: identifier)
      formatter.groupingSeparator = groupingSeparator
      formatter.numberStyle = .decimal
      if let formattedTipAmount = formatter.string(from: self as NSNumber) {
          return "\(symbol)\(formattedTipAmount)\(suffix)"
      }
      return ""
  }
}
