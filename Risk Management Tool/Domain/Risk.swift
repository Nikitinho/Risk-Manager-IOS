//
//  Risk.swift
//  Risk Management Tool
//
//  Created by Nikitinho on 22/03/2019.
//  Copyright © 2019 Nikitinho. All rights reserved.
//

import Foundation


class Risk {
    var id:String
    var author:UserProfile
    var description:String
    var timestamp:Double
    
    init(id:String, author:UserProfile, description:String, timestamp:Double) {
        self.id = id
        self.author = author
        self.description = description
        self.timestamp = timestamp
    }
}
