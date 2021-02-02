//
//  AddInfoCell.swift
//  Cook
//
//  Created by admin on 26.01.2021.
//

import UIKit

class AddInfoCell: UITableViewCell {
  
  @IBOutlet weak var nameField: UITextField!
  static var indexPath: IndexPath!
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
  }
  
}
