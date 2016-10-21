//
//  PickerViewController.swift
//  EcoLight
//
//  Created by Sebastian Felipe Diaz Avila on 25-09-16.
//  Copyright © 2016 Sebastian Felipe Diaz Avila. All rights reserved.
//

import UIKit
import RealmSwift

class PickerViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {
    
    
   
    @IBOutlet weak var PickerView: UIPickerView!
    var grupos: Results<Grupo>!
    var interruptor : Switch = Switch()

    override func viewDidLoad() {
        super.viewDidLoad()

        
        PickerView.dataSource = self
        PickerView.delegate = self
        
        let realm = try! Realm()

        let grupo : Grupo = realm.objects(Grupo.self).filter("nombre == \"\(interruptor.grupo)\"").first!
        
        let indice : Int = grupos.indexOf(grupo)!
        

        
        PickerView.selectRow(indice, inComponent: 0, animated: true)

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return grupos.count
    }

    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return grupos[row].nombre
    }
    
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let grupo : Grupo = grupos[row]
        interruptor.cambiarParametros(grupo)
        
        
        
        
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
