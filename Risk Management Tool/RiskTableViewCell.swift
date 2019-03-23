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
    
    weak var risk:Risk?
    
    func set(risk:Risk) {
        self.risk = risk
        
        self.userImage.image = nil
        ImageService.getImage(url: risk.author.photoURL) { image, url in
            guard let _risk = self.risk else { return }
            if _risk.author.photoURL.absoluteString == url.absoluteString {
                self.userImage.image = image
            } else {
                print("Error while loading image")
            }
            
        }
        
        userName.text = risk.author.username
        riskDescription.text = risk.description.replacingOccurrences(of: "\n", with: " ")
        if (riskDescription.text!.count > Constants.DESC_PREVIEW_MAX_LENGTH) {
            riskDescription.text = String(riskDescription.text!.prefix(Constants.DESC_PREVIEW_MAX_LENGTH))
            riskDescription.text! += "..."
        }
        riskTimestamp.text = risk.creationDate.calenderTimeSinceNow()
    }
}

extension String {
    func charAt(at: Int) -> Character {
        let charIndex = self.index(self.startIndex, offsetBy: at)
        return self[charIndex]
    }
}
