//
//  GrupoTableViewController.swift
//  EcoLight
//
//  Created by Sebastian Felipe Diaz Avila on 19-09-16.
//  Copyright © 2016 Sebastian Felipe Diaz Avila. All rights reserved.
//

import UIKit
import RealmSwift

class GrupoTableViewController: UITableViewController {
    

    var grupos: Results<Grupo>!
     let realm = try! Realm()


    override func viewDidLoad() {
        super.viewDidLoad()

        let grupodefault: Grupo = Grupo()
        grupodefault.nombre = "Ninguno"
        grupodefault.estado = 1
        
        try! realm.write{
            realm.add(grupodefault, update: true)
        
        }
        grupos = realm.objects(Grupo.self)
        tableView.tableFooterView = UIView()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    override func viewWillAppear(animated: Bool) {
        let realm = try! Realm()
        grupos = realm.objects(Grupo.self)
        self.tableView.reloadData()
        
    }
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return grupos.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let realm = try! Realm()
        let cell = tableView.dequeueReusableCellWithIdentifier("grupocell", forIndexPath: indexPath)
        let nombreGrupo: String = grupos[indexPath.row].nombre
        cell.textLabel?.text = nombreGrupo
        
        let resultado = realm.objects(Switch.self).filter("grupo == \"\(nombreGrupo)\"")
        cell.detailTextLabel?.text = String(resultado.count)
        

        

        return cell
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "detailgruposegue"){
            let destino = segue.destinationViewController as! GrupoDetailTableViewController
            let grupoSeleccionado = sender as! UITableViewCell
            let indexPath = self.tableView.indexPathForCell(grupoSeleccionado)
            let grupotmp = grupos[(indexPath?.row)!]
            destino.grupo = grupotmp
            
            
            
        
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
 
    
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .Default, title: "Eliminar") { (ation:UITableViewRowAction!,indexPath:NSIndexPath!) -> Void  in
            
            let realm = try! Realm()
            
            try! realm.write {
                realm.delete(self.grupos[indexPath.row])
            }
            self.tableView.reloadData()
            
        }
        deleteAction.backgroundColor = UIColor.redColor()
        return [deleteAction]
    }
    
    
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    

}
