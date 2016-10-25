//
//  ImageViewController.swift
//  EcoLight
//
//  Created by Sebastian Felipe Diaz Avila on 25-10-16.
//  Copyright © 2016 Sebastian Felipe Diaz Avila. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {
    
    
 
    
    @IBOutlet weak var imagen: UIImageView!
    var tutorial: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch tutorial {
        case 1:
            imagen.image = UIImage(named: "Tutorial_Agregar")
          
        default:
            imagen = UIImageView(image: UIImage(named: "Tutorial_Agregar"))

        }
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    

}
