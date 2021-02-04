//
//  PickerControllerViewController.swift
//  Cook
//
//  Created by Наталья Заварцева on 02.02.2021.
//

import UIKit

class PickerViewController: UIViewController {
    
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var label: UILabel!
    
    let servingsCount = ["1", "2", "3", "4", "5"]
    var pickerResult: String?
    
    var pickerType: PickerType!
    var isCompleted: ((_ selectedOptions: String?) -> ())? = nil
    func didSelectOptions(completed: @escaping(_ selectedOptions: String?) -> ()){
        self.isCompleted = completed
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        picker.dataSource = self
    }
    
    @IBAction func doneButtonPressed(_ sender: UIButton) {
        
        switch pickerType {
        case .prepareTime:
            if picker.selectedRow(inComponent: 0) != 0 && picker.selectedRow(inComponent: 2) != 0 {
                pickerResult = "\(picker.selectedRow(inComponent: 0))h " +
                    "\(picker.selectedRow(inComponent: 2))m "
            } else if picker.selectedRow(inComponent: 0) == 0 && picker.selectedRow(inComponent: 2) != 0 {
                pickerResult = "\(picker.selectedRow(inComponent: 2))m "
            } else if picker.selectedRow(inComponent: 2) == 0 && picker.selectedRow(inComponent: 0) != 0{
                pickerResult = "\(picker.selectedRow(inComponent: 0))h "
            }
        case .cookTime:
            pickerResult = servingsCount[picker.selectedRow(inComponent: 0)]
        default:
            return
        }
        
        if let completed = isCompleted {
            completed(pickerResult)
        }
        
        
    }

}

extension PickerViewController: UIPickerViewDelegate, UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        switch pickerType {
        case .prepareTime:
            return 4
        case .cookTime:
            return 1
        default:
            return 1
        }
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerType {
        
        case .prepareTime:
            switch (component) {
            case 0:
                return 24
            case 1:
                return 1
            case 2:
                return 60
            case 3:
                return 1
            default:
                return 1
            }
        case .cookTime:
            return servingsCount.count
        default:
            return 1
        }
    }
    

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerType {
        
        case .prepareTime:
        switch (component) {
        case 0:
            return String(row)
        case 1:
            return "hour"
        case 2:
            return String(row)
        default:
            return "min"
            }
        case .cookTime:
            return servingsCount[row]
        default:
            return "_"
        }
    }
    
}





