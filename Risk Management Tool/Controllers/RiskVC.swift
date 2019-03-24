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
    var imageURL:URL?
    
    @IBOutlet weak var riskTitleLabel: UILabel!
    @IBOutlet weak var riskDescriptionTV: UITextView!
    @IBOutlet weak var riskAuthorTV: UILabel!
    @IBOutlet weak var riskAnalysisTV: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        
        riskTitleLabel.text = riskTitle
        riskTitleLabel.numberOfLines = 0
        riskTitleLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        riskAnalysisTV.text = parseAnalysis(riskAnalysis)
        riskAnalysisTV.addRoundedBorder()
        riskDescriptionTV.text = riskDescription
        riskDescriptionTV.addRoundedBorder()
        riskAuthorTV.text = "created by: " + riskAuthor!
        imageView.setImageFromURL(url: imageURL)
        imageView.createRoundedImageForm()
    }
    
    private func parseAnalysis(_ analysis: [String: String]?) -> String {
        var output = ""
        guard analysis != nil else { return output }
        for (key, value) in analysis! {
            output.append(key + ": " + value + "\n")
        }
        return output
    }
}
