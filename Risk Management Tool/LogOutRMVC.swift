//
//  LogOutRMVC.swift
//  Risk Management Tool
//
//  Created by Nikitinho on 17/03/2019.
//  Copyright © 2019 Nikitinho. All rights reserved.
//

import UIKit
import Firebase

class LogOutRMVC: UIViewController {
    
    @IBOutlet weak var message: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let username = FIRAuth.auth()?.currentUser?.displayName else { return }
        
        message.text = "Hello \(username)"
    }
    
    @IBAction func onLogOutAction(_ sender: Any) {
        do{
            try FIRAuth.auth()?.signOut()
            performSegue(withIdentifier: "logOutSegue", sender: nil)
        } catch {
            print (error)
        }
    }
}
