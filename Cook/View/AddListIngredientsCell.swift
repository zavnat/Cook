//
//  AddListIngredientsCell.swift
//  Cook
//
//  Created by admin on 26.01.2021.
//

import UIKit

protocol AddListIngredientsCellProtocol: class {
    func deleteIngredient(_ cell: AddListIngredientsCell)
}

class AddListIngredientsCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    var delegate: AddListIngredientsCellProtocol?
//    var indexPath: IndexPath!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBAction func deleteButtonPressed(_ sender: UIButton) {
        delegate?.deleteIngredient(self)
    }
}
