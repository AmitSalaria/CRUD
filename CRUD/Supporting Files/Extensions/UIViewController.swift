//
//  UIViewController.swift
//

import UIKit

extension UIViewController {
  
  func showAlert(title: String? = "Alert", message: String, otherButtons:[String:((UIAlertAction)-> ())]? = nil, cancelTitle: String = "Okay", cancelAction: ((UIAlertAction)-> ())? = nil) {
    
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    
    if otherButtons != nil {
      for key in otherButtons!.keys {
        alert.addAction(UIAlertAction(title: key, style: .default, handler: otherButtons![key]))
      }
    }
    alert.addAction(UIAlertAction(title: cancelTitle, style: .default, handler: cancelAction))
    present(alert, animated: true, completion: nil)
    
  }
  
}
