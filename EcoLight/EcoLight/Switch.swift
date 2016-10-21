//
//  Stich.swift
//  EcoLight
//
//  Created by Sebastian Felipe Diaz Avila on 19-09-16.
//  Copyright © 2016 Sebastian Felipe Diaz Avila. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

class Switch : Object {
    
   dynamic  var nombre          : String = "Ninguno"
   dynamic  var grupo           : String = "Ninguno"
   dynamic  var estado          : Int = 1;
   dynamic  var luzOn           : Bool = false
   dynamic  var distancia       : Int = 1;
   dynamic  var luz             : Int = 1;
   dynamic  var tiempoEncendida : Int = 1;
   dynamic  var id              : Int = 1;
    
    
    
    required init() {
        super.init()
    }
    
    required init(value: AnyObject, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }


    override class func primaryKey() -> String? {
        return "id"
    }
    
    func valorAtributo(atributo: String) -> AnyObject{
        switch atributo {
        case "Nombre":
            return self.nombre
        case "Luz":
            return self.luz
        case "Retardo":
            return self.tiempoEncendida
        case "Distancia":
            return self.distancia
        case "Activo","Movimiento","Cercania":
            return self.estado
        case "Encender":
            return self.luzOn
        default:
            return self.grupo
        }
    
    }
    
    func cambiarParametros(grupo : Grupo){
        let realm = try! Realm()
        
        try! realm.write {
            self.estado = grupo.estado
            self.distancia = grupo.distancia
            self.luz = grupo.luz
            self.tiempoEncendida = grupo.tiempoEncendida
            self.grupo = grupo.nombre
        }


     }
    
    
    func cambiarParametroIndividual(atributo : String,valor: String){
        let realm = try! Realm()
        
        switch atributo {
        case "Nombre":
            try! realm.write {
                self.nombre = valor
            }
        case "Luz":
            try! realm.write {
                self.luz = Int(valor)!
            }
        case "Retardo":
            try! realm.write {
                self.tiempoEncendida = Int(valor)!
            }
        case "Distancia":
            try! realm.write {
                self.distancia = Int(valor)!
            }
        case "Activo":
            try! realm.write {
                self.estado = 1
            }
        case "Movimiento":
            try! realm.write {
                self.estado = 2
            }
        case"Cercania":
            try! realm.write {
                self.estado = 3
            }
        default:
            try! realm.write {
                if(valor == "1"){
                    self.luzOn = true
                }else{
                    self.luzOn = false
                }
               
            }

        }

        
    }



}