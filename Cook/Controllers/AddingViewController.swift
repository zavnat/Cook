//
//  AddingViewController.swift
//  Cook
//
//  Created by admin on 17.12.2020.
//

import UIKit
import Firebase
import FittedSheets

class AddingViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    let db = Firestore.firestore()
    var ingredientsList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        
        let sections = numberOfSections(in: tableView)
        var name: String?
        var recipe: String?
        
        for num in 0..<sections {
            switch num {
            case 0:
                let cell = tableView.cellForRow(at: AddInfoCell.indexPath) as! AddInfoCell
                name = cell.nameField.text
            case 1:
                print("")
            case 2:
                let cell = tableView.cellForRow(at: AddRecipeCell.indexPath) as! AddRecipeCell
                recipe = cell.textView.text
            default:
                return
            }
        }
        saveRecipeData(name, ingredients: ingredientsList, recipe: recipe)
    }
    
    func saveRecipeData(_ name: String?, ingredients: [String], recipe: String?) {
        if let resipeName = name, let recipeText = recipe, let _ = Auth.auth().currentUser?.email {
            
            db.collection(Auth.auth().currentUser!.email!).addDocument(data: [
                "recipeName": resipeName,
                "recipe": recipeText,
                "ingredients": ingredients,
                "date": Date().timeIntervalSince1970
            ]) { err in
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    print("Successfully saved data")
                }
            }
            self.navigationController?.popViewController(animated: true)
            
        } else {
            // Alert ("Need name and recipe text")
        }
    }
    
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
            AddInfoCell.indexPath = indexPath
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddListIngredientsCell", for:
                                                        indexPath) as! AddListIngredientsCell
            cell.nameLabel.text = ingredientsList[indexPath.row]
            cell.indexPath = indexPath
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddRecipeCell", for:
                                                        indexPath) as! AddRecipeCell
            cell.cellDelegate = self
            AddRecipeCell.indexPath = indexPath
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
    
    func createNewIngredient(_ text: String) {
        ingredientsList.insert(text, at: 0)
        tableView.beginUpdates()
        tableView.insertRows(at: [IndexPath(row: 0, section: 1)],
                             with: .right)
        tableView.endUpdates()
    }
    
    func openBottomSheet(type: PickerType) {

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let optionVC = storyboard.instantiateViewController(withIdentifier: "PickerControllerViewController") as! PickerViewController
        optionVC.pickerType = type
        let sheetController = SheetViewController(
            controller: optionVC,
            sizes: [.percent(0.5)])
        sheetController.overlayColor = UIColor.gray.withAlphaComponent(0.5)
        sheetController.cornerRadius = 25
        self.present(sheetController, animated: false, completion: {})
        
        
        optionVC.didSelectOptions { selectedString in
           
            let cell = self.tableView.cellForRow(at: AddRecipeCell.indexPath) as! AddRecipeCell
    
            guard let result = selectedString else {
                cell.cookTimeButton.setTitle("Добавить", for: .normal)
                sheetController.dismiss(animated: true, completion: nil)
                return
            }

            switch type {
            case .cookTime:
                cell.cookTimeButton.setTitle(result, for: .normal)
            case .servings:
                cell.servingsButton.setTitle(result, for: .normal)
            default:
                print("Not found correct Picker Type")
            }
            sheetController.dismiss(animated: true, completion: nil)
        }
        
    }
}
