//
//  RegisterRMVCViewController.swift
//  Risk Management Tool
//
//  Created by Nikitinho on 17/03/2019.
//  Copyright © 2019 Nikitinho. All rights reserved.
//

// TODO: reset password option
// TODO: user photo
// TODO: other user information, like age, country, etc.

import UIKit
import Firebase

class RegisterRMVCViewController: UIViewController {
    
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var userEmail: UITextField!
    @IBOutlet weak var userPassword: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    
    @IBAction func onRegisterAction(_ sender: Any) {
        
        let username = userName.text ?? ""
        let email = userEmail.text ?? ""
        let passwordConfirmation = confirmPassword.text ?? ""
        let password = userPassword.text ?? ""
        
        let errorMessage = localVerification(username: username, email: email, password: password, confirmPassword: passwordConfirmation)
        
        if (!errorMessage.isEmpty) {
            LogMessage.showMessage(inVC: self, title: "Info is missing", message: errorMessage)
            return
        }
        
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
            
            guard error == nil else {
                LogMessage.showMessage(inVC: self, title: "Error", message: error!.localizedDescription)
                return
            }
            guard let user = user else {
                return
            }
            print(user.email ?? "No email info provided")
            print(user.uid)
            
            let profileChangeRequest = user.profileChangeRequest()
            profileChangeRequest.displayName = username
            profileChangeRequest.commitChanges(completion: { (error) in
                guard error == nil else {
                    LogMessage.showMessage(inVC: self, title: "Something went wrong", message: error!.localizedDescription)
                    return
                }
                
                self.performSegue(withIdentifier: "registerSegue", sender: nil)
            })
        })
    }
    
    func localVerification(
        username: String,
        email: String,
        password: String,
        confirmPassword: String
        ) -> String {
        if (username == "") {
            return "Empty username field"
        } else if (email == "") {
            return "Empty email field"
        } else if (password == "") {
            return "Empty password field"
        } else if (confirmPassword == "") {
            return "Confirm password"
        } else if (password != confirmPassword) {
            return "Passwords do not match"
        }
        return ""
    }
}
