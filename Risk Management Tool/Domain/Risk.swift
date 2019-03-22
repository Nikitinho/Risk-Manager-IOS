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
    var author:String
    var description:String
    
    init(id:String, author:String, description:String) {
        self.id = id
        self.author = author
        self.description = description
    }
}
