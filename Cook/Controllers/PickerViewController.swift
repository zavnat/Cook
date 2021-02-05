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
        pickerHandler()
    }
    
    func pickerHandler() {
        
        switch pickerType {
        case .cookTime:
            let font = UIFont.systemFont(ofSize: 20.0)
            let fontSize: CGFloat = font.pointSize
            let componentWidth: CGFloat = self.view.frame.width / CGFloat(picker.numberOfComponents)
            let y = (picker.frame.size.height / 2) - (fontSize / 2)
            
            let label1 = UILabel(frame: CGRect(x: componentWidth * 0.65, y: y, width: componentWidth * 0.4, height: fontSize))
            label1.font = font
            label1.textAlignment = .left
            label1.text = "hours"
            label1.textColor = UIColor.lightGray
            picker.addSubview(label1)
            
            let label2 = UILabel(frame: CGRect(x: componentWidth * 1.65, y: y, width: componentWidth * 0.4, height: fontSize))
            label2.font = font
            label2.textAlignment = .left
            label2.text = "min"
            label2.textColor = UIColor.lightGray
            picker.addSubview(label2)
        default:
            return
        }
        
    }
    
    @IBAction func doneButtonPressed(_ sender: UIButton) {
        
        switch pickerType {
        case .cookTime:
            if picker.selectedRow(inComponent: 0) != 0 && picker.selectedRow(inComponent: 1) != 0 {
                pickerResult = "\(picker.selectedRow(inComponent: 0))h " +
                    "\(picker.selectedRow(inComponent: 1))m "
            } else if picker.selectedRow(inComponent: 0) == 0 && picker.selectedRow(inComponent: 1) != 0 {
                pickerResult = "\(picker.selectedRow(inComponent: 1))m "
            } else if picker.selectedRow(inComponent: 1) == 0 && picker.selectedRow(inComponent: 0) != 0{
                pickerResult = "\(picker.selectedRow(inComponent: 0))h "
            }
        case .servings:
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
        case .cookTime:
            return 2
        case .servings:
            return 1
        default:
            return 1
        }
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerType {
        
        case .cookTime:
            switch (component) {
            case 0:
                return 24
            case 1:
                return 60
            default:
                return 1
            }
        case .servings:
            return servingsCount.count
        default:
            return 1
        }
    }
    

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerType {
        
        case .cookTime:
        switch (component) {
        case 0:
            return String(row)
        case 1:
            return String(row)
        default:
            return "_"
            }
        case .servings:
            return servingsCount[row]
        default:
            return "_"
        }
    }
    
}





