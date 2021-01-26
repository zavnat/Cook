//
//  AddRecipeCell.swift
//  Cook
//
//  Created by admin on 26.01.2021.
//

import UIKit

protocol Pr {
  func press()
}

class AddRecipeCell: UITableViewCell {

  var delegate: Pr?
  
  @IBAction func buttonPressed(_ sender: UIButton) {
    delegate?.press()
    
  }
  override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
