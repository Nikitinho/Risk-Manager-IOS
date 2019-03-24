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
    
    var riskTitle:String?
    var riskDescription:String?
    var riskAuthor:String?
    var riskAnalysis:[String:String]?
    
    @IBOutlet weak var riskTitleLabel: UILabel!
    @IBOutlet weak var riskDescriptionTV: UITextView!
    @IBOutlet weak var riskAuthorTV: UILabel!
    @IBOutlet weak var riskAnalysisTV: UITextView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        
        riskTitleLabel.text = riskTitle
        riskAnalysisTV.text = parseAnalysis(riskAnalysis)
        riskDescriptionTV.text = riskDescription
        riskAuthorTV.text = "created by: " + riskAuthor!
    }
    
    private func parseAnalysis(_ analysis: [String: String]?) -> String {
        var output = ""
        for (key, value) in analysis! {
            output.append(key + ": " + value + "\n")
        }
        return output
    }
}
