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
        
        userImage.createRoundedImageForm()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func set(risk:Risk) {
        ImageService.getImage(url: risk.author.photoURL) { image in
            self.userImage.image = image
        }
        
        userName.text = risk.author.username
        riskDescription.text = risk.description
    }
}
