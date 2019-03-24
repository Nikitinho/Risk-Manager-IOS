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
}

extension Date {
    func calenderTimeSinceNow() -> String {
        let calendar = Calendar.current
        
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self, to: Date())
        
        let years = components.year!
        let months = components.month!
        let days = components.day!
        let hours = components.hour!
        let minutes = components.minute!
        let seconds = components.second!
        
        if years > 0 {
            return years == 1 ? "1 year ago" : "\(years) years ago"
        } else if months > 0 {
            return months == 1 ? "1 month ago" : "\(months) months ago"
        } else if days >= 7 {
            let weeks = days / 7
            return weeks == 1 ? "1 week ago" : "\(weeks) weeks ago"
        } else if days > 0 {
            return days == 1 ? "1 day ago" : "\(days) days ago"
        } else if hours > 0 {
            return hours == 1 ? "1 hour ago" : "\(hours) hours ago"
        } else if minutes > 0 {
            return minutes == 1 ? "1 minute ago" : "\(minutes) minutes ago"
        } else {
            return seconds == 1 ? "1 second ago" : "\(seconds) seconds ago"
        }
    }
    
}
