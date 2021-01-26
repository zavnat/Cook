//
//  AddingViewController.swift
//  Cook
//
//  Created by admin on 17.12.2020.
//

import UIKit
import Firebase

class AddingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, Pr {
  func press() {
    array.insert("B", at: 0)
    tableView.beginUpdates()
    tableView.insertRows(at: [IndexPath(row: 0, section: 1)], with: .right)
    tableView.endUpdates()
  }
  
  
  var array = [String]()
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 3
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    switch section {
    case 0:
      return 1
    case 1:
      return array.count
    case 2:
      return 1
    default:
      return 0
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    switch indexPath.section {
    case 0:
      let cell = tableView.dequeueReusableCell(withIdentifier: "AddInfoCell", for:
                                                indexPath) as! AddInfoCell
      return cell
    case 1:
      let cell = tableView.dequeueReusableCell(withIdentifier: "AddListIngredientsCell", for:
                                                indexPath) as! AddListIngredientsCell
      return cell
    case 2:
      let cell = tableView.dequeueReusableCell(withIdentifier: "AddRecipeCell", for:
                                                indexPath) as! AddRecipeCell
      cell.delegate = self
      return cell
    default:
      let cell = tableView.dequeueReusableCell(withIdentifier: "AddRecipeCell", for:
                                                indexPath) as! AddRecipeCell
      cell.delegate = self
      return cell
    }
  }
  
//  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//    switch indexPath.section {
//    case 0:
//      return 40
//    case 1:
//      return 40
//    default:
//      return 100
//    }
//  }

  
  
//  let db = Firestore.firestore()
//  
  @IBOutlet weak var tableView: UITableView!
  //  @IBOutlet weak var nameField: UITextField!
//  @IBOutlet weak var descriptionField: UITextView!
//  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.delegate = self
    tableView.dataSource = self
    
//    self.tableView.rowHeight = UITableView.automaticDimension
//    self.tableView.estimatedRowHeight = 108.0
//    descriptionField.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).cgColor
//    descriptionField.layer.borderWidth = 1.0
//    descriptionField.layer.cornerRadius = 5
  }

  
//  @IBAction func saveButton(_ sender: Any) {
//    if let message = nameField.text, !message.isEmpty, let messageSender = Auth.auth().currentUser?.email {
//
//      db.collection(Auth.auth().currentUser!.email!).addDocument(data: [
//        "sender": messageSender,
//        "recipe": message,
//        "date": Date().timeIntervalSince1970
//      ]) { err in
//        if let err = err {
//          print("Error adding document: \(err)")
//        } else {
//          print("Successfully saved data")
//        }
//      }
//    }
//    self.navigationController?.popViewController(animated: true)
//  }
  
}
