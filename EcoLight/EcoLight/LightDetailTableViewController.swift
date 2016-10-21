 //
//  LightDetailTableViewController.swift
//  EcoLight
//
//  Created by Sebastian Felipe Diaz Avila on 19-09-16.
//  Copyright © 2016 Sebastian Felipe Diaz Avila. All rights reserved.
//

import UIKit
import RealmSwift
import SVProgressHUD

class LightDetailTableViewController: UITableViewController {
    
    
    var interruptor: Switch = Switch()
    var secciones: [seccion] = [seccion]()
    
    struct seccion {
        var seccionNombre : String = ""
        var tituloSeccion: [String] = [String]()
    }
    


    override func viewDidLoad() {
        
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        secciones = [seccion(seccionNombre:"Personal",tituloSeccion: ["Nombre","Grupo"]),
                     seccion(seccionNombre: "Manual", tituloSeccion: ["Activo","Encender"]),
                     seccion(seccionNombre: "Automatico", tituloSeccion: ["Movimiento","Cercania","Luz","Retardo","Distancia"])]
        
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
                if(interruptor.estado == 1){
                    return 2
                }else{
                    return 1
                }
            default:
                if(interruptor.estado == 1){
                    return 2
                }else if (interruptor.estado == 2){
                    return 4
                }else{
                    return 5
                }
        }
    }
    
    
    override func viewWillAppear(animated: Bool) {
        self.tableView.reloadData()
        
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return secciones[section].seccionNombre
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch secciones[indexPath.section].tituloSeccion[indexPath.row] {
            
            case "Grupo":
                let viewController = storyboard?.instantiateViewControllerWithIdentifier("pickerView") as! PickerViewController
                let realm = try! Realm()
                let grupos = realm.objects(Grupo.self)
                viewController.grupos = grupos
                viewController.interruptor = interruptor
                self.navigationController?.pushViewController(viewController, animated: true)


            default:
                let viewController = storyboard?.instantiateViewControllerWithIdentifier("EditingView") as! EditingViewController
                viewController.atributo = secciones[indexPath.section].tituloSeccion[indexPath.row]
                viewController.interruptor = interruptor
                self.navigationController?.pushViewController(viewController, animated: true)
            
            
        
        }
        
        
        
        
         //let viewController = storyboard?.instantiateViewControllerWithIdentifier("pickerView")
         //self.navigationController?.pushViewController(viewController!, animated: true)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let atributo: String = secciones[indexPath.section].tituloSeccion[indexPath.row]
        
        
        switch atributo {
            
        case "Nombre","Grupo","Luz","Distancia","Retardo":
            let cell = tableView.dequeueReusableCellWithIdentifier("nameCell", forIndexPath: indexPath) as! NameTableViewCell
            cell.Titulo?.text = secciones[indexPath.section].tituloSeccion[indexPath.row]
            switch secciones[indexPath.section].tituloSeccion[indexPath.row] {
            case "Nombre":
                cell.Name?.text = interruptor.nombre
            case "Grupo":
                cell.Name?.text = interruptor.grupo
            case "Luz":
                cell.Name?.text = ""
            case "Retardo":
                cell.Name?.text = String(interruptor.tiempoEncendida)+" seg"
            default:
                cell.Name?.text = String(interruptor.distancia)+" cm"
            }

            return cell
            
        case "Activo","Cercania","Movimiento","Encender":
            let cell = tableView.dequeueReusableCellWithIdentifier("nameCell", forIndexPath: indexPath) as! NameTableViewCell
            cell.Titulo?.text = secciones[indexPath.section].tituloSeccion[indexPath.row]
            switch secciones[indexPath.section].tituloSeccion[indexPath.row] {
            case "Activo":
                if(interruptor.estado==1){
                    cell.Name?.text = "Activo"
                }else{
                    cell.Name?.text = "Inactivo"
                }
            case "Movimiento":
                if(interruptor.estado==2){
                    cell.Name?.text = "Activo"
                }else{
                    cell.Name?.text = "Inactivo"
                }
            case "Cercania":
                if(interruptor.estado==3){
                    cell.Name?.text = "Activo"
                }else{
                    cell.Name?.text = "Inactivo"
                }
            default:
                if(interruptor.luzOn){
                    cell.Name?.text = "Encendida"
                }else{
                    cell.Name?.text = "Apagada"
                }
            }
            
            return cell
            
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier("nameCell", forIndexPath: indexPath) as! NameTableViewCell
            cell.Titulo?.text = "DEFAULT"
            return cell
        }
    }
    

    override func willMoveToParentViewController(parent: UIViewController?) {
        super.willMoveToParentViewController(parent)
        if parent == nil {
            HTTPRequest.UpdateSwitch(self.interruptor) { (exito, mensaje) in
                if(exito){
                    print("el interruptor guardo los datos con exito")
                }else{
                    SVProgressHUD.showErrorWithStatus("ERROR al guardar, Verifique conexion a internet")
                }
            }
        }
    }
    


}
