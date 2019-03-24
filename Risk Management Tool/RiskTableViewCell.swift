//
//  RiskTableViewCell.swift
//  Risk Management Tool
//
//  Created by Nikitinho on 22/03/2019.
//  Copyright © 2019 Nikitinho. All rights reserved.
//

import UIKit

class RiskTableViewCell: UITableViewCell {

    @IBOutlet weak var riskTitle: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var riskTimestamp: UILabel!
    @IBOutlet weak var riskPreviewDescription: UILabel!
    @IBOutlet weak var bttn: UIButton!
    
    weak var delegate: RiskCellDelegator?
    
    @IBAction func cellTapped(_ sender: UIButton) {
        delegate?.callSegueFromCell(self)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
        userImage.createRoundedImageForm()
    }

    @IBAction func buttonTapped(_ sender: Any) {
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
        
        riskTitle.text = risk.title.replacingOccurrences(of: "\n", with: " ")
        if (riskTitle.text!.count > Constants.RISK_TITLE_MAX_LENGTH) {
            riskTitle.text = String(riskTitle.text!.prefix(Constants.RISK_TITLE_MAX_LENGTH))
            riskTitle.text! += "..."
        }
        riskPreviewDescription.text = risk.description.replacingOccurrences(of: "\n", with: " ")
        if (riskPreviewDescription.text!.count > Constants.DESC_PREVIEW_MAX_LENGTH) {
            riskPreviewDescription.text = String(riskPreviewDescription.text!.prefix(Constants.DESC_PREVIEW_MAX_LENGTH))
            riskPreviewDescription.text! += "..."
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
