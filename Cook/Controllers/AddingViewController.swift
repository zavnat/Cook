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
  
  @IBOutlet weak var textView: UITextView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
  @IBAction func saveButton(_ sender: Any) {
    if let message = textView.text, textView.text.count > 0, let messageSender = Auth.auth().currentUser?.email {
      
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
