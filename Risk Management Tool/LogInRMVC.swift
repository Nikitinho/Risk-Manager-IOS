//
//  ViewController.swift
//  Risk Management Tool
//
//  Created by Nikitinho on 17/03/2019.
//  Copyright © 2019 Nikitinho. All rights reserved.
//

import UIKit
import Firebase

class LogInRMVC: UIViewController {
    
    @IBOutlet weak var userEmail: UITextField!
    
    @IBOutlet weak var userPassword: UITextField!
    
    @IBAction func onLogInAction(_ sender: Any) {
        
        guard let email = userEmail.text,
        email != "",
        let password = userPassword.text,
        password != ""
            else {
                LogMessage.showMessage(inVC: self, title: "Required info is missing", message: "Fill in the gaps, dude")
                return
        }
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
            guard error == nil else {
                LogMessage.showMessage(inVC: self, title: "Error", message: error!.localizedDescription)
                return
            }
        })
    }
}

