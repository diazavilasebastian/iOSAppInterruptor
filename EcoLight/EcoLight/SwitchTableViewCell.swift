//
//  SwitchTableViewCell.swift
//  EcoLight
//
//  Created by Sebastian Felipe Diaz Avila on 19-09-16.
//  Copyright © 2016 Sebastian Felipe Diaz Avila. All rights reserved.
//

import UIKit

class SwitchTableViewCell: UITableViewCell {
    
    
    @IBOutlet var Titulo: UILabel?
    @IBOutlet var SwitchButton : UISwitch?
    weak var Delegate : DataDelegate?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.SwitchButton!.addTarget(self, action: #selector(SwitchTableViewCell.stateChanged(_:)),forControlEvents: UIControlEvents.ValueChanged)
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension SwitchTableViewCell : UITextFieldDelegate{
    func stateChanged(switchState: UISwitch) {
        let atributo = Titulo?.text!
        let valor = switchState.on
        
        self.Delegate?.getValuesFinish("Switch", field:atributo! , value: valor)
    }

}
