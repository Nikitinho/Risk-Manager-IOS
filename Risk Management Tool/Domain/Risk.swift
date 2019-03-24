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
    var title:String
    var description:String
    var timestamp:Double
    var creationDate:Date
    
    var confidentiality:Int
    var integrity:Int
    var availability:Int
    
    var threats:[String: [String: Int]]?
    var risksLevel:[String: String]?
    
    init(id:String, author:UserProfile, title: String, description: String, timestamp: Double, confidentiality: Int, integrity: Int, availability: Int) {
        self.id = id
        self.author = author
        self.title = title
        self.description = description
        self.timestamp = timestamp
        // we divide, because we actually don't need mileseconds.
        self.creationDate = Date(timeIntervalSince1970: timestamp / 1000)
        
        self.confidentiality = confidentiality
        self.integrity = integrity
        self.availability = availability
    }
    
    func addThreats(threats: [String: [String: Int]]) {
        self.threats = threats
    }
    
    func calculateRisksLevel() {
        guard threats != nil else { return }
        
        risksLevel = [String: String]()
        
        for category in threats! {
            var impact = 0
            switch category.key {
            case "confidentiality":
                impact = confidentiality
            case "integrity":
                impact = integrity
            case "availability":
                impact = availability
            default:
                return
            }
            
            for (threat, rate) in category.value {
                let riskLevel = rate * impact
                switch (riskLevel) {
                case 0..<34:
                    risksLevel![threat] = "Low"
                case 34..<69:
                    risksLevel![threat] = "Medium"
                case 70..<101:
                    risksLevel![threat] = "High"
                default:
                    risksLevel![threat] = "Undefined"
                }
            }
        }
    }
}
