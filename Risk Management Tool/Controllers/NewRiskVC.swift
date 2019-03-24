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
    
    @IBOutlet weak var descriptionTV: UITextView!
    @IBOutlet weak var riskTitleTV: UITextView!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var approveButton: UIBarButtonItem!
    @IBOutlet weak var confidentialitySilder: UISlider!
    @IBOutlet weak var confidentialityLabel: UILabel!
    @IBOutlet weak var integritySlider: UISlider!
    @IBOutlet weak var integrityLabel: UILabel!
    @IBOutlet weak var availabilityLabel: UILabel!
    @IBOutlet weak var availabilitySlider: UISlider!
    @IBOutlet weak var crammButton: UIButton!
    @IBOutlet weak var impactLabel: UILabel!
    
    var newParameters = [
        "confidentiality": [String](),
        "integrity": [String](),
        "availability" : [String]()
    ]
    
    var textView:UITextView?
    var categoryView:UITextView?
    
    @IBAction func onConfidentialityChanged(_ sender: UISlider) {
        let index = (Int)(sender.value + 0.5);
        let localLabel = "Confidentiality: "
        sender.setValue(Float(index), animated: false)
        confidentialityLabel.text! = localLabel + (String)((Int)(sender.value))
    }
    
    @IBAction func onIntegrityChanged(_ sender: UISlider) {
        let index = (Int)(sender.value + 0.5);
        let localLabel = "Integriy: "
        sender.setValue(Float(index), animated: false)
        integrityLabel.text! = localLabel + (String)((Int)(sender.value))
    }
    
    @IBAction func onAvailabilityChanged(_ sender: UISlider) {
        let index = (Int)(sender.value + 0.5);
        let localLabel = "Availability: "
        sender.setValue(Float(index), animated: false)
        availabilityLabel.text! = localLabel + (String)((Int)(sender.value))
    }
    
    
    @objc func onCRAMMButtonAction(_sender:UIButton!)
    {
        
        if (textView != nil && categoryView != nil) {
            switch categoryView?.text {
            case "3":
                newParameters["confidentiality"]!.append((textView?.text)!)
            case "2":
                newParameters["integrity"]!.append((textView?.text)!)
            case "1":
                newParameters["availability"]!.append((textView?.text)!)
            case .none:
                return
            case .some(_):
                return
            }
        }
        
        let X1 = riskTitleTV.frame.origin.x
        let Y1 = confidentialitySilder.frame.origin.y
        let width1 = riskTitleTV.frame.size.width/2 - 5
        let height1 = riskTitleTV.frame.size.height
        
        textView = UITextView(frame: CGRect(x: X1, y: Y1, width: width1, height: height1))
        textView!.addRoundedBorder()
        
        self.view.addSubview(textView!)
        
        let Y2 = confidentialitySilder.frame.origin.y
        let width2 = riskTitleTV.frame.size.width/2 - 5
        let height2 = riskTitleTV.frame.size.height
        let X2 = riskTitleTV.frame.origin.x + width2 + 10
        
        categoryView = UITextView(frame: CGRect(x: X2, y: Y2, width: width2, height: height2))
        categoryView!.addRoundedBorder()
        
        self.view.addSubview(categoryView!)
        
        hideSliders()
    }
    
    override func viewDidLoad() {
        descriptionTV.addRoundedBorder()
        riskTitleTV.addRoundedBorder()
        confidentialitySilder.maximumValue = 10
        confidentialitySilder.minimumValue = 0
        integritySlider.minimumValue = 0
        integritySlider.maximumValue = 10
        availabilitySlider.minimumValue = 0
        availabilitySlider.maximumValue = 10
        
        crammButton.addTarget(self, action: #selector(self.onCRAMMButtonAction(_sender:)), for: UIControl.Event.touchUpInside)
    }
    
    @IBAction func onCancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func hideSliders() {
        confidentialitySilder.isHidden = true
        confidentialityLabel.isHidden = true
        integritySlider.isHidden = true
        integrityLabel.isHidden = true
        availabilityLabel.isHidden = true
        availabilitySlider.isHidden = true
        impactLabel.text = "Threats. List all that apply"
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
            "additionalParameters": [],
            "confidentiality": (Int)(confidentialitySilder.value),
            "integrity": (Int)(integritySlider.value),
            "availability": (Int)(availabilitySlider.value),
            "title": riskTitleTV.text,
            "description": descriptionTV.text,
            "timestamp": [".sv":"timestamp"]
        ] as [String : Any]
        
        riskRef.setValue(riskObject, withCompletionBlock: { error, ref in
            if error == nil {
                self.dismiss(animated: true, completion: nil)
            } else {
                
            }
        })
        
        riskRef.child("additionalParameters").setValue(newParameters)
        
    }
}

public extension UITextView {
    func addRoundedBorder() {
        self.layer.borderColor = UIColor(red: 204.0/255.0, green: 204.0/255.0, blue: 204.0/255.0, alpha: 1.0).cgColor
        self.layer.borderWidth = 1.0
        self.layer.cornerRadius = 5
    }
}
