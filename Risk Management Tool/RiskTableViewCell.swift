//
//  RiskTableViewCell.swift
//  Risk Management Tool
//
//  Created by Nikitinho on 22/03/2019.
//  Copyright © 2019 Nikitinho. All rights reserved.
//

import UIKit

class RiskTableViewCell: UITableViewCell {

    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var riskTimestamp: UILabel!
    @IBOutlet weak var riskDescription: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        userImage.layer.borderWidth = 1
        userImage.layer.masksToBounds = false
        userImage.layer.borderColor = UIColor.black.cgColor
        userImage.layer.cornerRadius = userImage.frame.height/2
        userImage.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func set(risk:Risk) {
        userName.text = risk.author.username
        riskDescription.text = risk.description
    }
}
