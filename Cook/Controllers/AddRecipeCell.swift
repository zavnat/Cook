//
//  AddRecipeCell.swift
//  Cook
//
//  Created by admin on 26.01.2021.
//

import UIKit

protocol AddRecipeCellProtocol: class {
  func press()
  func updateHeightOfRow(_ cell: AddRecipeCell, _ textView: UITextView)
}

class AddRecipeCell: UITableViewCell {
  
  weak var cellDelegate: AddRecipeCellProtocol?
  @IBOutlet weak var textView: UITextView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    settingsTextView()
    textView.delegate = self
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
  @IBAction func buttonPressed(_ sender: UIButton) {
    cellDelegate?.press()
  }
  
  func settingsTextView() {
    textView.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).cgColor
    textView.layer.borderWidth = 1.0
    textView.layer.cornerRadius = 5
    textView.isScrollEnabled = false
  }
}

extension AddRecipeCell: UITextViewDelegate {
  
  func textViewDidChange(_ textView: UITextView) {
    if let deletate = cellDelegate {
      deletate.updateHeightOfRow(self, textView)
    }
  }
}

