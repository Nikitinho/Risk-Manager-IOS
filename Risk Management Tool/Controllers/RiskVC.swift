//
//  RiskVC.swift
//  Risk Management Tool
//
//  Created by Nikitinho on 24/03/2019.
//  Copyright © 2019 Nikitinho. All rights reserved.
//

import Foundation
import Firebase

class RiskVC: UIViewController {
    
    var riskDescription:String?
    var riskAuthor:String?
    
    @IBOutlet weak var riskDescriptionTV: UITextView!
    @IBOutlet weak var riskAuthorTV: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        riskDescriptionTV.text = riskDescription
        riskAuthorTV.text = "created by: " + riskAuthor!
    }
}
