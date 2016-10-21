//
//  sliderTableViewCell.swift
//  EcoLight
//
//  Created by Sebastian Felipe Diaz Avila on 08-10-16.
//  Copyright © 2016 Sebastian Felipe Diaz Avila. All rights reserved.
//

import UIKit

class SliderTableViewCell: UITableViewCell {

    
    @IBOutlet var Titulo : UILabel!
    @IBOutlet var valor  : UILabel!
    @IBOutlet var slider : UISlider!
    
    
    weak var Delegate : DataDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.slider!.addTarget(self, action: #selector(SliderTableViewCell.stateChanged(_:)),forControlEvents: UIControlEvents.ValueChanged)
        

        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

extension SliderTableViewCell : UITextFieldDelegate{
    func stateChanged(slider: UISlider) {
        let atributo = Titulo?.text!
        let valor2 = round(slider.value)
        if atributo != "Luz"{
            self.valor.text = String(Int(slider.value))
        }
        self.Delegate?.getValuesFinish("Switch", field:atributo! , value: valor2)
    }
    
}
        