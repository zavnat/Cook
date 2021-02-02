//
//  AddListIngredientsCell.swift
//  Cook
//
//  Created by admin on 26.01.2021.
//

import UIKit

class AddListIngredientsCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    var indexPath: IndexPath!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBAction func deleteButtonPressed(_ sender: UIButton) {
        
    }
}
