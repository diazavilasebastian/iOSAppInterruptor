//
//  tutorialTableViewController.swift
//  EcoLight
//
//  Created by Sebastian Felipe Diaz Avila on 25-10-16.
//  Copyright © 2016 Sebastian Felipe Diaz Avila. All rights reserved.
//

import UIKit

class TutorialTableViewController: UITableViewController {

    var secciones: [seccion] = [seccion]()
    
    struct seccion {
        var nombreTutorial : String = ""
        var numero : Int = 0
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        secciones = [seccion(nombreTutorial: "Agregar interruptor",numero: 1),
                     seccion(nombreTutorial: "¿Que es modo Manual?",numero: 2),
                     seccion(nombreTutorial: "¿Que es modo distancia?",numero: 3),
                     seccion(nombreTutorial: "¿Que es modo movimiento?",numero: 4),
                     seccion(nombreTutorial: "Recomendacion de configuración",numero: 5)]
        tableView.tableFooterView = UIView()
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
      
        
    }
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return secciones.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("tittlecell",forIndexPath: indexPath)
        cell.textLabel!.text = secciones[indexPath.row].nombreTutorial
        return cell
        
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "tutorialsegue" {
            let destino = segue.destinationViewController as! ImageViewController
            
            if let selectedinterruptorCell = sender as? UITableViewCell {
                let indexPath = self.tableView.indexPathForCell(selectedinterruptorCell)!
                let tutorial: Int = secciones[indexPath.row].numero
                destino.tutorial = tutorial
            }
            
            
        }
    }

}
