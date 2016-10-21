//
//  LightTableViewCell.swift
//  EcoLight
//
//  Created by Sebastian Felipe Diaz Avila on 19-09-16.
//  Copyright © 2016 Sebastian Felipe Diaz Avila. All rights reserved.
//

import UIKit

class LightTableViewCell: UITableViewCell {

    
    @IBOutlet weak var Nombre: UILabel!
    @IBOutlet weak var Grupo: UILabel!
    @IBOutlet weak var Imagen: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
