//
//  AddRecipeCell.swift
//  Cook
//
//  Created by admin on 26.01.2021.
//

import UIKit

protocol AddRecipeCellProtocol: class {
    func createNewIngredient(_ text: String)
    func updateHeightOfRow(_ cell: AddRecipeCell, _ textView: UITextView)
    func openBottomSheet(type: PickerType)
}

class AddRecipeCell: UITableViewCell {
    
    weak var cellDelegate: AddRecipeCellProtocol?
    static var indexPath: IndexPath!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var engredientField: UITextField!
    @IBOutlet weak var cookTimeButton: UIButton!
    @IBOutlet weak var servingsButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        settingsTextView()
        textView.delegate = self
        engredientField.delegate = self
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func setCookTime(_ sender: UIButton) {
        cellDelegate?.openBottomSheet(type: .cookTime)
    }
    @IBAction func setServings(_ sender: UIButton) {
        cellDelegate?.openBottomSheet(type: .servings)
    }
    
    func settingsTextView() {
        textView.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).cgColor
        textView.layer.borderWidth = 1.0
        textView.layer.cornerRadius = 5
        textView.isScrollEnabled = false
    }
}

extension AddRecipeCell: UITextViewDelegate, UITextFieldDelegate {
    func textViewDidChange(_ textView: UITextView) {
        if let deletate = cellDelegate {
            deletate.updateHeightOfRow(self, textView)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let deletate = cellDelegate, let text = textField.text {
            textField.text?.removeAll()
            deletate.createNewIngredient(text)
        }
    }
}

