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
        let interruptor1 = Switch()
        interruptor1.id = 1
        let interruptor2 = Switch()
        interruptor2.id = 2
        let interruptor3 = Switch()
        interruptor3.id = 3
        let interruptor4 = Switch()
        interruptor4.id = 4
        let interruptor5 = Switch()
        interruptor5.id = 5
        let interruptor6 = Switch()
        interruptor6.id = 6
        let interruptor7 = Switch()
        interruptor7.id = 7
        let interruptor8 = Switch()
        interruptor8.id = 8
        
    
        


        try! realm.write {
            realm.add(interruptor1, update: true)
            realm.add(interruptor2, update: true)
            realm.add(interruptor3, update: true)
            realm.add(interruptor4, update: true)
            realm.add(interruptor5, update: true)
            realm.add(interruptor6, update: true)
            realm.add(interruptor7, update: true)
            realm.add(interruptor8, update: true)
            
  
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
        
        if(interruptores[indexPath.row].estado == 1){
            if(interruptores[indexPath.row].luzOn){
                cell.Imagen.image = UIImage(named:"light_on")
            }else{
                cell.Imagen.image = UIImage(named:"light_off")
            }
        }else{
            cell.Imagen.image = UIImage(named:"light_auto")
        
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
 
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
    

}
