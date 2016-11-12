//
//  SocketConexion.swift
//  EcoLight
//
//  Created by Sebastian Felipe Diaz Avila on 20-09-16.
//  Copyright © 2016 Sebastian Felipe Diaz Avila. All rights reserved.
//

import Foundation
import SVProgressHUD
import RealmSwift


class SocketConexion {
    
    //metodo para guardar las configuracion Wifi del interruptor
    class func SaveWifiConfigurationSwitch(ssid: String ,pass: String) {
        let client:TCPClient = TCPClient(addr: "192.168.4.1", port: 80)
        let (success, errmsg) = client.connect(timeout: 2)
        if success {
            let (success, errmsg) = client.send(str:"ssid=\(ssid)&pass=\(pass)" )
            if success {
                let data = client.read(1024*10)
                if let d = data {
                    if let str =  String(bytes: d, encoding: NSUTF8StringEncoding){
                        if(str.containsString("OK")){
                            if(ParserMessage.MessageSocket(str)){
                                ParserMessage.addSwitch(str)
                                SVProgressHUD.showSuccessWithStatus("Interruptor registrado")
                            }else{
                                SVProgressHUD.showSuccessWithStatus("No se registro el interruptor reintente...")
                            }
                            return;
                        }else{
                            print(str)
                            SVProgressHUD.showErrorWithStatus("No se registro el interruptor reintente...")
                            return;
                        }
                    }
                }
            }else {
                SVProgressHUD.showErrorWithStatus("No se pudo conectar")
                print(errmsg+"2")
            }
        } else {
            SVProgressHUD.showErrorWithStatus("No se pudo conectar Verifique conexión a EcoLight")
            print(errmsg+"1")
        }
        
    }

}