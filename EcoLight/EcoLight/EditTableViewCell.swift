//
//  EditTableViewCell.swift
//  EcoLight
//
//  Created by Sebastian Felipe Diaz Avila on 20-09-16.
//  Copyright © 2016 Sebastian Felipe Diaz Avila. All rights reserved.
//

import UIKit

class EditTableViewCell: UITableViewCell {
    
    
    @IBOutlet var Titulo : UILabel!
    @IBOutlet var EditText : UITextField!
    
    let atributo: String = ""
    weak var Delegate : DataDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        self.EditText.delegate = self
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

    extension EditTableViewCell: UITextFieldDelegate {
    func textFieldDidEndEditing(textField: UITextField) {
        let texto = EditText.text
        let atributo = Titulo.text
        self.Delegate?.getValuesFinish("Edit", field: atributo!, value:texto!)
        
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.EditText.resignFirstResponder()
        return false
    }

}
