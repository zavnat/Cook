//
//  RegisterViewController.swift
//  Cook
//
//  Created by admin on 14.01.2021.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {
  
  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  @IBAction func RegisterPressed(_ sender: UIButton) {
    if let email = emailTextField.text, let password = passwordTextField.text {
      Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
        if let err = error {
          Alert.showAlert(with: "Error", and: err.localizedDescription, sender: self)
        } else {
          let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
          let newViewController = storyBoard.instantiateViewController(withIdentifier: "TabBarController")
          self.view.window!.rootViewController = newViewController
        }
      }
    }
  }
  
}
