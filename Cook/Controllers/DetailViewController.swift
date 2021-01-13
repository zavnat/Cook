//
//  RecipeViewController.swift
//  Cook
//
//  Created by admin on 22.12.2020.
//

import UIKit

class DetailViewController: UIViewController {
  
  var name = "Recipes"
  
  @IBOutlet weak var descriptionLabel: UILabel!
  @IBAction func backButton(_ sender: UIBarButtonItem) {
    self.navigationController?.popViewController(animated: true)
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationItem.title = name
    navigationController?.navigationBar.prefersLargeTitles = true
    descriptionLabel.sizeToFit()
    
  }
}
