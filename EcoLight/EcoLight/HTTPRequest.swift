//
//  HTTPRequest.swift
//  EcoLight
//
//  Created by Sebastian Felipe Diaz Avila on 06-10-16.
//  Copyright © 2016 Sebastian Felipe Diaz Avila. All rights reserved.
//

import Foundation
import Alamofire
import RealmSwift




class HTTPRequest {

    class func UpdateSwitch(interruptor : Switch , completitionHandler:(exito:Bool,mensaje:String)->Void){
        Alamofire.request(.GET, "http://sdiaz.nosze.co/prueba1/phone/Upload.php", parameters: ["id": interruptor.id,"nombre": interruptor.nombre,"grupo": interruptor.grupo,"estado": interruptor.estado,"luz": interruptor.luz,"distancia": interruptor.distancia,"retardo": interruptor.tiempoEncendida*1000,"encendido": interruptor.luzOn]).responseString { response in
            if let respuesta: String = response.result.value {
                print(respuesta)
                let respuesta: String = response.result.value!
                if respuesta.containsString("OK"){
                    completitionHandler (exito: true,mensaje:String(response.result.value!))
                }else{
                    completitionHandler (exito: false,mensaje:String(response.result.value!))
                    
                }
            
            }
            
        }
    
    }
    
    class func DeleteSwitch(idinterruptor : Int , completitionHandler:(exito:Bool,mensaje:String)->Void){
        Alamofire.request(.GET, "http://sdiaz.nosze.co/prueba1/phone/Delete.php", parameters: ["id": idinterruptor])
            .responseString { response in
                
                
                let respuesta: String = response.result.value!
                if respuesta.containsString("OK"){
                    completitionHandler (exito: true,mensaje:String(response.result.value!))
                }else{
                    completitionHandler (exito: false,mensaje:String(response.result.value!))
                    
                }
        }
    }
    
    class func DownloadSwitch(idinterruptor : Int , completitionHandler:(exito:Bool,mensaje:String)->Void){
        Alamofire.request(.GET, "http://sdiaz.nosze.co/prueba1/phone/Download.php", parameters: ["id": idinterruptor])
            .responseString { response in
                if let respuesta: String = response.result.value {
                    print(respuesta)
                    if respuesta.containsString(String(idinterruptor)){
                        completitionHandler (exito: true,mensaje:String(response.result.value!))
                    }else{
                        completitionHandler (exito: false,mensaje:String(response.result.value!))
                        
                    }
                }else{
                    print("llego un mensaje con error")
                }
        }
        
    }
    

    
    class func UpdateAll(){
        let realm = try! Realm()
        let interruptores = realm.objects(Switch.self)
        for interrupor in interruptores {
            self.DownloadSwitch(interrupor.id, completitionHandler: { (exito, mensaje) in
                if(exito){
                    let nuevo: Switch = ParserMessage.ParserStringaSwitch(mensaje)
                    try! realm.write {
                        realm.add(nuevo,update: true)
                    }
                    NSNotificationCenter.defaultCenter().postNotificationName("refresh", object: nil)
                }else{
                    print(mensaje)
                }
            })
        }

    }


    

}