//
//  AddingViewController.swift
//  Cook
//
//  Created by admin on 17.12.2020.
//

import UIKit
import Firebase

class AddingViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  //  let db = Firestore.firestore()
  var ingredientsList = [String]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.delegate = self
    tableView.dataSource = self
  }
  
  func press() {
    ingredientsList.insert("B", at: 0)
    tableView.beginUpdates()
    tableView.insertRows(at: [IndexPath(row: 0, section: 1)],
                         with: .right)
    tableView.endUpdates()
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

extension AddingViewController: UITableViewDelegate, UITableViewDataSource, AddRecipeCellProtocol {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 3
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    switch section {
    case 0:
      return 1
    case 1:
      return ingredientsList.count
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
      cell.cellDelegate = self
      return cell
    default:
      let cell = tableView.dequeueReusableCell(withIdentifier: "AddRecipeCell", for:
                                                indexPath) as! AddRecipeCell
      cell.cellDelegate = self
      return cell
    }
  }
  
  func updateHeightOfRow(_ cell: AddRecipeCell, _ textView: UITextView) {
    let size = textView.bounds.size
    let newSize = tableView.sizeThatFits(CGSize(width: size.width,
                                                height: CGFloat.greatestFiniteMagnitude))
    if size.height != newSize.height {
      UIView.setAnimationsEnabled(false)
      tableView?.beginUpdates()
      tableView?.endUpdates()
      UIView.setAnimationsEnabled(true)
      if let thisIndexPath = tableView.indexPath(for: cell) {
        tableView.scrollToRow(at: thisIndexPath, at: .bottom,
                              animated: false)
      }
    }
  }
  
}
