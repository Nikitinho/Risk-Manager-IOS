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

class NewRiskVC:UIViewController, UITextViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
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
        "confidentiality": [String:Int](),
        "integrity": [String:Int](),
        "availability" : [String:Int]()
    ]
    
    var rateSelect:UIPickerView?
    var selectedRate:String?
    var categoryView:UITextView?
    var categorySelect:UIPickerView?
    var selectedCategory:String?
    var textView:UITextView?
    
    // values of picker
    private let categories: NSArray = ["confidentiality", "integrity", "availability"]
    private let rates: NSArray = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case categorySelect:
            return categories.count
        case rateSelect:
            return rates.count
        default:
            return 0
        }
    }
    
    // delegate method to return the value shown in the picker
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case categorySelect:
            return categories[row] as? String
        case rateSelect:
            return rates[row] as? String
        default:
            return nil
        }
    }
    
    // delegate method called when the row was selected.
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case categorySelect:
            selectedCategory = categories[row] as? String
        case rateSelect:
            selectedRate = rates[row] as? String
        default:
            return
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
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
        if (rateSelect != nil && categorySelect != nil && textView != nil) {
            
            guard selectedRate != nil,
            selectedCategory != nil,
            (textView?.text.count)! > 0
            else {
                LogMessage.showMessage(inVC: self, title: "Info is missing", message: "Fill all the gaps")
                return
            }
            
            switch selectedCategory! {
            case "confidentiality":
                (newParameters["confidentiality"])![(textView?.text)!] = (Int)(selectedRate!)
            case "integrity":
                (newParameters["integrity"])![(textView?.text)!] = (Int)(selectedRate!)
            case "availability":
                newParameters["availability"]?[(textView?.text)!] = (Int)(selectedRate!)
            default:
                return
            }
            
            textView!.text = ""
            rateSelect!.selectRow(0, inComponent: 0, animated: false)
            categorySelect!.selectRow(0, inComponent: 0, animated: false)
            
        } else {
        
            let X1 = riskTitleTV.frame.origin.x
            let Y1 = confidentialitySilder.frame.origin.y
            let width1 = riskTitleTV.frame.size.width/4 - 5
            let height1 = riskTitleTV.frame.size.height
            
            rateSelect = UIPickerView(frame: CGRect(x: X1, y: Y1, width: width1, height: height1))
    
            rateSelect?.addRoundedBorder()
            
            rateSelect!.delegate = self
            rateSelect!.dataSource = self
    
            self.view.addSubview(rateSelect!)
            
            rateSelect!.selectRow(0, inComponent: 0, animated: false)
    
            let Y2 = confidentialitySilder.frame.origin.y
            let width2 = riskTitleTV.frame.size.width/4 * 3 - 5
            let height2 = height1
            let X2 = riskTitleTV.frame.origin.x + width1 + 10
    
            categorySelect = UIPickerView(frame:CGRect(x: X2, y: Y2, width: width2, height: height2))
            
            categorySelect?.addRoundedBorder()
    
            categorySelect!.delegate = self
            categorySelect!.dataSource = self
    
            self.view.addSubview(categorySelect!)
            
            categorySelect!.selectRow(0, inComponent: 0, animated: false)
            
            let X3 = riskTitleTV.frame.origin.x
            let Y3 = confidentialitySilder.frame.origin.y + height1 + 10
            let width3 = riskTitleTV.frame.size.width
            let height3 = height1
            
            textView = UITextView(frame:CGRect(x: X3, y: Y3, width: width3, height: height3))
            textView?.addRoundedBorder()
            
            self.view.addSubview(textView!)
            
            hideSliders()
        }
    }
    
    override func viewDidLoad() {
        descriptionTV.addRoundedBorder()
        riskTitleTV.addRoundedBorder()
        confidentialitySilder.initWithMinAndMaxValues(min: 0, max: 10)
        integritySlider.initWithMinAndMaxValues(min: 0, max: 10)
        availabilitySlider.initWithMinAndMaxValues(min: 0, max: 10)
        
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
        
        guard let riskTitle = riskTitleTV.text,
            riskTitle != ""
            else {
                LogMessage.showMessage(inVC: self, title: "Info is missing", message: "Title field is empty")
                return
        }
        
        guard let description = descriptionTV.text,
            description != ""
            else {
                LogMessage.showMessage(inVC: self, title: "Info is missing", message: "Description field is empty")
                return
        }
        
        if (newParameters["confidentiality"]?.count == 0 && newParameters["integrity"]?.count == 0 && newParameters["availability"]?.count == 0) {
            LogMessage.showMessage(inVC: self, title: "Info is missing", message: "Threats field is empty")
            return
        }
        
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
            "title": riskTitle,
            "description": description,
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

public extension UIPickerView {
    func addRoundedBorder() {
        self.layer.borderColor = UIColor(red: 204.0/255.0, green: 204.0/255.0, blue: 204.0/255.0, alpha: 1.0).cgColor
        self.layer.borderWidth = 1.0
        self.layer.cornerRadius = 5
    }
}

public extension UISlider {
    func initWithMinAndMaxValues(min: Float, max: Float) {
        self.maximumValue = max
        self.minimumValue = min
    }
}
