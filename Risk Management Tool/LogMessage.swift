//
//  LogMessage.swift
//  Risk Management Tool
//
//  Created by Nikitinho on 18/03/2019.
//  Copyright © 2019 Nikitinho. All rights reserved.
//

import UIKit

class LogMessage {
    static func showMessage(inVC: UIViewController, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        inVC.present(alert, animated: true, completion: nil)
    }
}
