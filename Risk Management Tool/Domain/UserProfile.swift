//
//  UserProfile.swift
//  Risk Management Tool
//
//  Created by Nikitinho on 23/03/2019.
//  Copyright © 2019 Nikitinho. All rights reserved.
//

import Foundation
import UIKit

class UserProfile {
    var uid:String
    var username:String
    var photoURL:URL
    
    init(uid:String, username:String, photoURL:URL) {
        self.uid = uid
        self.username = username
        self.photoURL = photoURL
    }
}

public extension UIImageView {
    func createRoundedImageForm() {
        self.layer.borderWidth = 1
        self.layer.masksToBounds = false
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = self.frame.height/2
        self.clipsToBounds = true
    }
}
