//
//  ViewController.swift
//  Cook
//
//  Created by admin on 17.12.2020.
//

import UIKit
import Firebase

class ListRecipesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
  @IBOutlet weak var tableView: UITableView!
  let db = Firestore.firestore()
  var recipes = [Recipe]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.dataSource = self
    tableView.delegate = self
    loadRecipes()
  }
  
  @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
    performSegue(withIdentifier: "goToAdd", sender: self)
  }
  
  @IBAction func loOutPressed(_ sender: UIBarButtonItem) {
    do {
      try Auth.auth().signOut()
      print("Sign out")
      let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
      let newViewController = storyBoard.instantiateViewController(withIdentifier: "WelcomeViewController")
      self.view.window!.rootViewController = newViewController
    } catch let signOutError as NSError {
      print ("Error signing out: %@", signOutError)
    }
  }
  
  func loadRecipes() {
    
    db.collection(Auth.auth().currentUser?.email ?? "")
      .order(by: "date", descending: true)
      .addSnapshotListener { (querySnapshot, err) in
        if let err = err {
          print("Error getting documents: \(err)")
        } else {
          self.recipes = []
          if let snapshotDocuments = querySnapshot?.documents {
            for doc in snapshotDocuments {
              let id = doc.documentID
              let data = doc.data()
              if let recipe = data["recipe"] as? String {
                  let newRecipe = Recipe(name: recipe, id: id)
                  self.recipes.append(newRecipe)
                
                DispatchQueue.main.async {
                  self.tableView.reloadData()
                }
              }
            }
            
          }
        }
      }
  }
  
  //MARK: - UITableView Methods
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return recipes.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! RecipeCell
    
    cell.name.text = recipes[indexPath.row].name
    return cell
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      let doc = recipes[indexPath.row].id
      
      db.collection("recipe").document("\(doc)").delete() { err in
        if let err = err {
          print("Error removing document: \(err)")
        } else {
          print("Document successfully removed!")
        }
      }
    }
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    performSegue(withIdentifier: "goToDetail", sender: self)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    if segue.identifier == "goToDetail" {
      let destinationVC = segue.destination as! DetailViewController
      if let indexPath = tableView.indexPathForSelectedRow {
        destinationVC.name = recipes[indexPath.row].name
      }
    }
  }
  
}


