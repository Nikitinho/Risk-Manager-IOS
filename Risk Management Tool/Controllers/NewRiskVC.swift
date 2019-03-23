//
//  NewRiskVC.swift
//  Risk Management Tool
//
//  Created by Nikitinho on 23/03/2019.
//  Copyright © 2019 Nikitinho. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class NewRiskVC:UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var approveButton: UIBarButtonItem!
    
    @IBAction func onCancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func onApproveAction(_ sender: Any) {
        
        guard let userProfile = UserService.currentUserProfile else { return }
        
        let riskRef = FIRDatabase.database().reference().child("risks").childByAutoId()
        
        let riskObject = [
            "author": [
                "uid": userProfile.uid,
                "username": userProfile.username,
                "photoURL": userProfile.photoURL.absoluteString
            ],
            "description": textView.text,
            "timestamp": [".sv":"timestamp"]
            ] as [String : Any]
        
        riskRef.setValue(riskObject, withCompletionBlock: { error, ref in
            if error == nil {
                self.dismiss(animated: true, completion: nil)
            } else {
                
            }
        })
        
    }
}
