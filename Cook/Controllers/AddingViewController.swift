//
//  AddingViewController.swift
//  Cook
//
//  Created by admin on 17.12.2020.
//

import UIKit
import Firebase

class AddingViewController: UIViewController {
  
  let db = Firestore.firestore()
  
  @IBOutlet weak var nameField: UITextField!
  @IBOutlet weak var descriptionField: UITextView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    descriptionField.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).cgColor
    descriptionField.layer.borderWidth = 1.0
    descriptionField.layer.cornerRadius = 5
  }

  
  @IBAction func saveButton(_ sender: Any) {
    if let message = nameField.text, !message.isEmpty, let messageSender = Auth.auth().currentUser?.email {
      
      db.collection(Auth.auth().currentUser!.email!).addDocument(data: [
        "sender": messageSender,
        "recipe": message,
        "date": Date().timeIntervalSince1970
      ]) { err in
        if let err = err {
          print("Error adding document: \(err)")
        } else {
          print("Successfully saved data")
        }
      }
    }
    self.navigationController?.popViewController(animated: true)
  }
  
}
