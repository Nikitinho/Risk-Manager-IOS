//
//  Extensions.swift
//  Risk Management Tool
//
//  Created by Nikitinho on 24/03/2019.
//  Copyright © 2019 Nikitinho. All rights reserved.
//

import Foundation
import UIKit

public extension UITextView {
    func addRoundedBorder() {
        self.layer.borderColor = UIColor(red: 204.0/255.0, green: 204.0/255.0, blue: 204.0/255.0, alpha: 1.0).cgColor
        self.layer.borderWidth = 1.0
        self.layer.cornerRadius = 5
    }
}

public extension UIPickerView {
    public func addRoundedBorder() {
        self.layer.borderColor = UIColor(red: 204.0/255.0, green: 204.0/255.0, blue: 204.0/255.0, alpha: 1.0).cgColor
        self.layer.borderWidth = 1.0
        self.layer.cornerRadius = 5
    }
}

public extension UISlider {
    func initWithMinAndMaxValues(min: Float, max: Float) {
        self.maximumValue = max
        self.minimumValue = min
    }
}

extension UIImageView {
    func setImageFromURL(url: URL?) {
        guard url != nil else { return}
        ImageService.getImage(url: url!) { image, url in
            return self.image = image
        }
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

public extension UIImageView {
    func createRoundedImageForm() {
        self.layer.borderWidth = 1
        self.layer.masksToBounds = false
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = self.frame.height/2
        self.clipsToBounds = true
    }
}

extension String {
    func charAt(at: Int) -> Character {
        let charIndex = self.index(self.startIndex, offsetBy: at)
        return self[charIndex]
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
