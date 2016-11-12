//
//  EditingViewController.swift
//  EcoLight
//
//  Created by Sebastian Felipe Diaz Avila on 08-10-16.
//  Copyright © 2016 Sebastian Felipe Diaz Avila. All rights reserved.
//

import UIKit
import SVProgressHUD

class EditingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,DataDelegate {

    
    @IBOutlet weak var tableView: UITableView!
    var atributo : String = ""
    var interruptor : Switch = Switch()
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.tableFooterView = UIView()
        
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
            
                cell.valor!.text = String(interruptor.tiempoEncendida)
                cell.slider.minimumValue = 0
                cell.slider.maximumValue = 300
                cell.slider.value = Float(interruptor.distancia)
                cell.slider.continuous = true
                cell.Delegate = self
                return cell
            case "Retardo":
                let cell = self.tableView.dequeueReusableCellWithIdentifier("sliderCell", forIndexPath: indexPath) as! SliderTableViewCell
                cell.Titulo!.text = atributo
                cell.valor!.text = String(interruptor.tiempoEncendida)
                cell.slider.minimumValue = 0
                cell.slider.maximumValue = 30
                cell.slider.value = Float(interruptor.tiempoEncendida)
                cell.slider.continuous = true
                cell.Delegate = self
                return cell
            
            case "Luz":
                let cell = self.tableView.dequeueReusableCellWithIdentifier("sliderCell", forIndexPath: indexPath) as! SliderTableViewCell
                cell.Titulo!.text = atributo

                
                cell.valor!.text = ""
                cell.slider.minimumValue = 0
                cell.slider.maximumValue = 1000
                cell.slider.value = Float(interruptor.luz)
                cell.slider.continuous = true
                cell.Delegate = self
                return cell

            
            case "Nombre":
                let cell = self.tableView.dequeueReusableCellWithIdentifier("editcell", forIndexPath: indexPath) as! EditTableViewCell
                cell.Titulo!.text = atributo
                if(atributo == "Nombre"){
                    cell.EditText.text = interruptor.valorAtributo(atributo) as? String
                }else{
                    cell.EditText.text = String(interruptor.valorAtributo(atributo))
                }
                cell.Delegate = self
                return cell
            
            
            case "Activo","Cercanía","Encender","Movimiento":
                let cell = self.tableView.dequeueReusableCellWithIdentifier("switchCell", forIndexPath: indexPath) as! SwitchTableViewCell
                cell.Titulo!.text = atributo
                switch  atributo{
                case "Activo":
                    if(interruptor.estado==1){
                        cell.SwitchButton?.on = true
                    }else{
                        cell.SwitchButton?.on = false
                    }
                case "Movimiento":
                    if(interruptor.estado==2){
                        cell.SwitchButton?.on = true
                    }else{
                        cell.SwitchButton?.on = false
                    }
                case "Cercanía":
                    if(interruptor.estado==3){
                        cell.SwitchButton?.on = true
                    }else{
                        cell.SwitchButton?.on = false
                    }
                default:
                    if(interruptor.luzOn){
                        cell.SwitchButton?.on = true
                    }else{
                        cell.SwitchButton?.on = false
                    }
                }
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
            interruptor.cambiarParametroIndividual(atributo, valor: valor)
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
