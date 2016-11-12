//
//  GrupoDetailTableViewController.swift
//  EcoLight
//
//  Created by Sebastian Felipe Diaz Avila on 20-09-16.
//  Copyright © 2016 Sebastian Felipe Diaz Avila. All rights reserved.
//

import UIKit

class GrupoDetailTableViewController: UITableViewController{
    
    
    var grupo: Grupo = Grupo()

    var secciones: [seccion] = [seccion]()
    
    struct seccion {
        var seccionNombre : String = ""
        var tituloSeccion: [String] = [String]()
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        secciones = [seccion(seccionNombre:"Personal",tituloSeccion: ["Nombre"]),
                     seccion(seccionNombre: "Manual", tituloSeccion: ["Activo"]),
                     seccion(seccionNombre: "Automático", tituloSeccion: ["Movimiento","Cercanía","Luz","Retardo","Distancia"])]

        
        tableView.tableFooterView = UIView()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
            if(grupo.estado==1){
                
                return 2;
            }else if(grupo.estado==2){
                return 4;
                
            }else{
                return 5;
                
            }
        }
    }

    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return secciones[section].seccionNombre
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let atributo: String = secciones[indexPath.section].tituloSeccion[indexPath.row]
        
        
        switch atributo {
            
        case "Nombre","Grupo","Luz","Distancia","Retardo":
            let cell = tableView.dequeueReusableCellWithIdentifier("nameCell", forIndexPath: indexPath) as! NameTableViewCell
            cell.Titulo?.text = secciones[indexPath.section].tituloSeccion[indexPath.row]
            
            switch secciones[indexPath.section].tituloSeccion[indexPath.row] {
            case "Nombre":
                cell.Name?.text = grupo.nombre
            case "Luz":
                cell.Name?.text = ""
            case "Retardo":
                cell.Name?.text = String(grupo.tiempoEncendida)
            default:
                cell.Name?.text = String(grupo.distancia)
            }
            return cell
            
        case "Activo","Cercania","Movimiento","Encender":
            let cell = tableView.dequeueReusableCellWithIdentifier("nameCell", forIndexPath: indexPath) as! NameTableViewCell
            cell.Titulo?.text = secciones[indexPath.section].tituloSeccion[indexPath.row]
            switch secciones[indexPath.section].tituloSeccion[indexPath.row] {
            case "Activo":
                if(grupo.estado==1){
                    cell.Name?.text = "Activo"
                    //cell.Name?.textColor = UIColor.greenColor()
                }else{
                    cell.Name?.text = "Inactivo"
                    //cell.Name?.textColor = UIColor.redColor()
                }
            case "Movimiento":
                if(grupo.estado==2){
                    cell.Name?.text = "Activo"
                    //cell.Name?.textColor = UIColor.greenColor()
                }else{
                    cell.Name?.text = "Inactivo"
                    //cell.Name?.textColor = UIColor.redColor()
                }
            default:
                if(grupo.estado==3){
                    cell.Name?.text = "Activo"
                    //cell.Name?.textColor = UIColor.greenColor()
                }else{
                    cell.Name?.text = "Inactivo"
                    //cell.Name?.textColor = UIColor.redColor()
                }
            }
            return cell
            
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier("nameCell", forIndexPath: indexPath) as! NameTableViewCell
            cell.Titulo?.text = "DEFAULT"
            return cell
        }

    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
