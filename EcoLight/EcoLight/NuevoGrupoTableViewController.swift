//
//  NuevoGrupoTableViewController.swift
//  EcoLight
//
//  Created by Sebastian Felipe Diaz Avila on 20-09-16.
//  Copyright © 2016 Sebastian Felipe Diaz Avila. All rights reserved.
//

import UIKit
import RealmSwift
import SVProgressHUD



protocol DataDelegate :class{
    
    func getValuesFinish(atributo:String,field: AnyObject,value:AnyObject)
    
}

class NuevoGrupoTableViewController: UITableViewController,DataDelegate {
    
    var grupoTmp : Grupo = Grupo()
    
    var secciones: [seccion] = [seccion]()
    
    struct seccion {
        var seccionNombre : String = ""
        var tituloSeccion: [String] = [String]()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        
        secciones = [seccion(seccionNombre:"Personal",tituloSeccion: ["Nombre"]),
                     seccion(seccionNombre: "Manual", tituloSeccion: ["Activo"]),
                     seccion(seccionNombre: "Automático", tituloSeccion: ["Movimiento","Cercanía","Luz","Retardo","Distancia"])]

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return secciones.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch(secciones[section].seccionNombre){
        
            case "Personal":
                return secciones[section].tituloSeccion.count
        
            case "Manual":
                return secciones[section].tituloSeccion.count
            
            default:
                if(grupoTmp.estado==1){
            
                    return 2;
                }else if(grupoTmp.estado==2){
                    return 4;
                
                }else{
                    return 5;
                    
                }

        }
        
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return secciones[section].seccionNombre
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch secciones[indexPath.section].tituloSeccion[indexPath.row] {
            
        case "Luz":
            let viewController = storyboard?.instantiateViewControllerWithIdentifier("valueGroup") as! NewValueGroup
            viewController.atributo = secciones[indexPath.section].tituloSeccion[indexPath.row]
            viewController.grupo = grupoTmp
            self.navigationController?.pushViewController(viewController, animated: true)
            
        case "Distancia":
            let viewController = storyboard?.instantiateViewControllerWithIdentifier("valueGroup") as! NewValueGroup
            viewController.atributo = secciones[indexPath.section].tituloSeccion[indexPath.row]
            viewController.grupo = grupoTmp
            self.navigationController?.pushViewController(viewController, animated: true)
            
        case "Retardo":
            let viewController = storyboard?.instantiateViewControllerWithIdentifier("valueGroup") as! NewValueGroup
            viewController.atributo = secciones[indexPath.section].tituloSeccion[indexPath.row]
            viewController.grupo = grupoTmp
            self.navigationController?.pushViewController(viewController, animated: true)
            
        default:
            break
            
            
            
        }
        
        
        
        
        //let viewController = storyboard?.instantiateViewControllerWithIdentifier("pickerView")
        //self.navigationController?.pushViewController(viewController!, animated: true)
    }
    
    
    
    
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let atributo: String = secciones[indexPath.section].tituloSeccion[indexPath.row]
        
        
        switch atributo {
        case "Luz":
            let cell = tableView.dequeueReusableCellWithIdentifier("nameCell", forIndexPath: indexPath) as! NameTableViewCell
            
            cell.Titulo?.text = secciones[indexPath.section].tituloSeccion[indexPath.row]
            cell.Name?.text = ""
            return cell
            
            
        case "Distancia":
            let cell = tableView.dequeueReusableCellWithIdentifier("nameCell", forIndexPath: indexPath) as! NameTableViewCell
            
            cell.Titulo?.text = secciones[indexPath.section].tituloSeccion[indexPath.row]
            cell.Name?.text = String(grupoTmp.distancia)+" cm"
            return cell
            
        case "Retardo":
            let cell = tableView.dequeueReusableCellWithIdentifier("nameCell", forIndexPath: indexPath) as! NameTableViewCell
            
            cell.Titulo?.text = secciones[indexPath.section].tituloSeccion[indexPath.row]
            cell.Name?.text = String(grupoTmp.tiempoEncendida)+" seg"
            return cell
            
        case "Nombre","Retardo":
            let cell = tableView.dequeueReusableCellWithIdentifier("editcell", forIndexPath: indexPath) as! EditTableViewCell
            
            cell.Titulo?.text = secciones[indexPath.section].tituloSeccion[indexPath.row]
            cell.Delegate = self
            return cell
            
        case "Activo","Cercania","Movimiento":
            let cell = tableView.dequeueReusableCellWithIdentifier("switchCell", forIndexPath: indexPath) as! SwitchTableViewCell
            cell.Titulo?.text = secciones[indexPath.section].tituloSeccion[indexPath.row]
            
            switch secciones[indexPath.section].tituloSeccion[indexPath.row] {
            case "Activo":
                if grupoTmp.estado == 1 {
                    cell.SwitchButton?.on = true
                }else{
                    cell.SwitchButton?.on = false
                }
                
            case "Movimiento":
                if grupoTmp.estado == 2 {
                    cell.SwitchButton?.on = true
                }else{
                    cell.SwitchButton?.on = false
                }
            default:
                if grupoTmp.estado == 3 {
                    cell.SwitchButton?.on = true
                }else{
                    cell.SwitchButton?.on = false
                }
            }
            cell.Delegate = self
            return cell
            
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier("nameCell", forIndexPath: indexPath) as! NameTableViewCell
            cell.Titulo?.text = "DEFAULT"
            return cell
        }
        
    }
    
    
    @IBAction func didPressSave(sender: UIBarButtonItem?) {
        
        if(grupoTmp.validarGrupo()){
            let realm = try! Realm()
            do{
                try realm.write({
                    realm.add(grupoTmp, update: true)
                    SVProgressHUD.showSuccessWithStatus("Agregado Grupo \(grupoTmp.nombre)")
                    self.navigationController?.popToRootViewControllerAnimated(true)
                })
            }catch {
                SVProgressHUD.showErrorWithStatus("Error agregando Grupo")
            }
            
        
        }else{
            let alertController = UIAlertController(title: "Error", message:"El grupo no ha sido correctamente configurado, Reintente",preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Entendido", style: UIAlertActionStyle.Default,handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        
    }
    
    func getValuesFinish(atributo: String, field: AnyObject, value: AnyObject) {
        let atributo :String = String(field)
        let valor :String = String(value)
        
        
        if valor != ""{
            
            switch atributo {
                case "Activo":
                    grupoTmp.estado = 1
                    self.tableView.reloadData()
                case "Cercania":
                    grupoTmp.estado = 3
                    self.tableView.reloadData()
                case "Movimiento":
                    grupoTmp.estado = 2
                    self.tableView.reloadData()
                case "Nombre":
                    grupoTmp.nombre = valor
                case "Luz":
                    grupoTmp.luz = Int(valor)!
                case "Distancia":
                    grupoTmp.distancia = Int(valor)!
                default:
                    grupoTmp.tiempoEncendida = Int(valor)!
            }
        }
    }

    
    override func viewWillAppear(animated: Bool) {
        self.tableView.reloadData()
        
    }
}








