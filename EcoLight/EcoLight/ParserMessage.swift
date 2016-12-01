//
//  ParserSwitch.swift
//  EcoLight
//
//  Created by Sebastian Felipe Diaz Avila on 22-09-16.
//  Copyright © 2016 Sebastian Felipe Diaz Avila. All rights reserved.
//

import Foundation
import RealmSwift


class ParserMessage {

    class func ParserStringaSwitch(Objecto :String) -> Switch{
        
        //4&ninguno&Ninguno&1&1&100&1000&60
        //id&nombre&grupo&estado&encendido&distancia&luz&retardo;
        
        
        let fullNameArr = Objecto.characters.split{$0 == "&"}.map(String.init)
        let interruptor : Switch = Switch()
        interruptor.id = Int(fullNameArr[0])!
        interruptor.nombre = fullNameArr[1]
        interruptor.grupo = fullNameArr[2]
        interruptor.estado = Int(fullNameArr[3])!
        if(fullNameArr[4] == "1"){
            interruptor.luzOn = true
        }else{
            interruptor.luzOn = false
        }
        interruptor.distancia = Int(fullNameArr[5])!
        interruptor.luz = Int(fullNameArr[5])!
        interruptor.tiempoEncendida = Int(fullNameArr[7])!/1000
        
        return interruptor
    
    }

    
    class func MessageSocket(message :String) -> Bool{
        if(message.containsString("OK")){
            return true;
        }else{
            return false;
        }
    }
    
    
    class func addSwitch(message :String) -> Void{
        if(message.containsString("OK")){
            let range = message.rangeOfString("&")!
            
            let idInterruptor = message.substringFromIndex(range.endIndex)
            let realm = try! Realm()
            let switchNuevo : Switch = Switch()
            switchNuevo.id = Int(idInterruptor)!
            
            try! realm.write {
                realm.add(switchNuevo,update: true)
            }
        }else{
            print("no llego el OK");
        }
        
    }





}