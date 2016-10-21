//
//  Grupo.swift
//  EcoLight
//
//  Created by Sebastian Felipe Diaz Avila on 19-09-16.
//  Copyright © 2016 Sebastian Felipe Diaz Avila. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

class Grupo : Object{

    dynamic var nombre  : String = ""
    dynamic var estado  : Int = 1;
    dynamic var distancia   : Int = 1;
    dynamic var tiempoEncendida : Int = 1;
    dynamic var luz     : Int = 1;

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
        return "nombre"
    }
    
    
    func validarGrupo() -> Bool{
        print(self.nombre)
        if self.nombre != "" {
            switch self.estado {
            case 1:
                return true
            case 2 :
                if self.luz >= 0 && self.tiempoEncendida >= 0{
                    return true
                }
                return false
                
            default:
                if self.luz >= 0 && self.distancia >= 0 && self.tiempoEncendida >= 0{
                    return true
                }
                return false

            }
        }else{
            return false;
        }
    
    }
    
    

}