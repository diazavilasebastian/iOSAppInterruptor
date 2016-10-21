//
//  LightTableViewController.swift
//  EcoLight
//
//  Created by Sebastian Felipe Diaz Avila on 19-09-16.
//  Copyright © 2016 Sebastian Felipe Diaz Avila. All rights reserved.
//

import UIKit
import RealmSwift

class LightTableViewController: UITableViewController {
    

    var interruptores: Results<Switch>!

    override func viewDidLoad() {
        
        super.viewDidLoad()
        let realm = try! Realm()
        let interruptor: Switch = Switch()
        interruptor.id = 2
        


        try! realm.write {
            realm.add(interruptor, update: true)
  
        }
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.refreshTable), name: "refresh", object: nil)
        
        interruptores = realm.objects(Switch.self)
        tableView.tableFooterView = UIView()
        
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func viewWillAppear(animated: Bool) {
        let realm = try! Realm()
        interruptores = realm.objects(Switch.self)
        self.tableView.reloadData()
    
    }
    
    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return interruptores.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("lightcell", forIndexPath: indexPath) as! LightTableViewCell

        cell.Nombre.text = interruptores[indexPath.row].nombre
        cell.Grupo.text = interruptores[indexPath.row].grupo
        
        
        if(interruptores[indexPath.row].luzOn){
            cell.Imagen.image = UIImage(named:"light_on")
        }else{
            cell.Imagen.image = UIImage(named:"light_off")
        }
        
        

        return cell
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "detaillightsegue" {
            let destino = segue.destinationViewController as! LightDetailTableViewController
            
            if let selectedinterruptorCell = sender as? LightTableViewCell {
                let indexPath = self.tableView.indexPathForCell(selectedinterruptorCell)!
                let interruptorseleccionado: Switch = interruptores[indexPath.row]
                destino.interruptor = interruptorseleccionado
            }
        }
    }
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .Default, title: "Eliminar") { (ation:UITableViewRowAction!,indexPath:NSIndexPath!) -> Void  in
            HTTPRequest.DeleteSwitch(self.interruptores[indexPath.row].id, completitionHandler: { (exito, mensaje) in
                if(exito){
                    let realm = try! Realm()
                    
                    try! realm.write {
                        realm.delete(self.interruptores[indexPath.row])
                    }
                    self.tableView.reloadData()
                }else{
                    print("No se pudo eliminar elemento ")
                }
            })
            
        }
        deleteAction.backgroundColor = UIColor.redColor()
        return [deleteAction]
    }
    
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    
    func refreshTable(notification: NSNotification) {
        self.tableView.reloadData()
    }
 
    

}
