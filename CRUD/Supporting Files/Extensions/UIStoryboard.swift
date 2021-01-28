//
//  UIStoryboard.swift
//

import UIKit

enum Storyboard : String {
  case main = "Main"
}

extension UIStoryboard {

  class func storyboard(_ storyboard: Storyboard, _ bundle: Bundle? = nil) -> UIStoryboard {
    UIStoryboard(name: storyboard.rawValue, bundle: bundle)
  }
}
