//
//  NewValueGroup.swift
//  EcoLight
//
//  Created by Sebastian Felipe Diaz Avila on 25-10-16.
//  Copyright © 2016 Sebastian Felipe Diaz Avila. All rights reserved.
//

import UIKit

class NewValueGroup: UIViewController,UITableViewDelegate, UITableViewDataSource, DataDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    var atributo : String = ""
    var grupo : Grupo = Grupo()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.tableFooterView = UIView()
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch atributo{
        case "Distancia":
            let cell = self.tableView.dequeueReusableCellWithIdentifier("sliderCell", forIndexPath: indexPath) as! SliderTableViewCell
            cell.Titulo!.text = atributo
            
            cell.valor!.text = String(grupo.distancia)
            cell.slider.minimumValue = 0
            cell.slider.maximumValue = 300
            cell.slider.value = Float(grupo.distancia)
            cell.slider.continuous = true
            cell.Delegate = self
            return cell
        case "Retardo":
            let cell = self.tableView.dequeueReusableCellWithIdentifier("sliderCell", forIndexPath: indexPath) as! SliderTableViewCell
            cell.Titulo!.text = atributo
            cell.valor!.text = String(grupo.tiempoEncendida)
            cell.slider.minimumValue = 0
            cell.slider.maximumValue = 30
            cell.slider.value = Float(grupo.tiempoEncendida)
            cell.slider.continuous = true
            cell.Delegate = self
            return cell
            
        case "Luz":
            let cell = self.tableView.dequeueReusableCellWithIdentifier("sliderCell", forIndexPath: indexPath) as! SliderTableViewCell
            cell.Titulo!.text = atributo
            cell.valor!.text = ""
            cell.slider.minimumValue = 0
            cell.slider.maximumValue = 1000
            cell.slider.value = Float(grupo.luz)
            cell.slider.continuous = true
            cell.Delegate = self
            return cell

            
        default:
            let cell = self.tableView.dequeueReusableCellWithIdentifier("editcell", forIndexPath: indexPath) as! EditTableViewCell
            cell.Titulo.text? = atributo
            return cell
            
            
        }
    }
    
    func getValuesFinish(atributo: String, field: AnyObject, value: AnyObject) {
        print("atributo: \(atributo) campo: \(field)  valor: \(value)")
        let valor : String = String(value)
        let atributo : String = String(field)
        if(valor != ""){
            grupo.cambiarParametro(atributo, valor: valor)
        }
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch atributo {
        case "Luz","Retardo","Distancia":
            return 110
        default:
            return 45
        }
    }
    
    
    
    

}
