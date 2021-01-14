//
//  AuthError.swift
//  Cook
//
//  Created by admin on 13.01.2021.
//

import UIKit

struct Alert {
  static func showAlert(with title: String, and message: String, sender: UIViewController) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let action = UIAlertAction(title: "OK", style: .default, handler: nil)
    alertController.addAction(action)
    sender.present(alertController, animated: true, completion: nil)
  }
}
