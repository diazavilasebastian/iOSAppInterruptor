//
//  WifiConfigurationViewController.swift
//  EcoLight
//
//  Created by Sebastian Felipe Diaz Avila on 21-09-16.
//  Copyright © 2016 Sebastian Felipe Diaz Avila. All rights reserved.
//

import UIKit

class WifiConfigurationViewController: UIViewController ,UITextFieldDelegate{

    @IBOutlet weak var ssidTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    @IBOutlet weak var agregarButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ssidTextField.delegate = self
        passTextField.delegate = self
        
        agregarButton.addTarget(self, action: #selector(self.buttonClicked), forControlEvents: UIControlEvents.TouchUpInside)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    func buttonClicked() {
        let ssid:String = ssidTextField.text!
        let pass:String = passTextField.text!
        
        SocketConexion.SaveWifiConfigurationSwitch(ssid, pass: pass)
        
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
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
