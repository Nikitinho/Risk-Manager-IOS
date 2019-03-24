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
        riskTitle.adjustsFontSizeToFitWidth = false
        riskTitle.lineBreakMode = NSLineBreakMode.byTruncatingTail
        riskTitle.numberOfLines = 1

        riskPreviewDescription.text = risk.description.replacingOccurrences(of: "\n", with: " ")
        riskPreviewDescription.adjustsFontSizeToFitWidth = false
        riskPreviewDescription.lineBreakMode = NSLineBreakMode.byTruncatingTail
        riskPreviewDescription.numberOfLines = 1
        
        riskTimestamp.text = risk.creationDate.calenderTimeSinceNow()
    }
}
