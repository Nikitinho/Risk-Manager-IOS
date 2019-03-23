//
//  LogOutRMVC.swift
//  Risk Management Tool
//
//  Created by Nikitinho on 17/03/2019.
//  Copyright © 2019 Nikitinho. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class LogOutRMVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var logOutButton: UIBarButtonItem!
    
    var tableView:UITableView!
    
    var risks = [Risk]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        risks = fillTestParams()
        
        logOutButton.target = self;
        logOutButton.action = #selector(self.onLogOutAction(_sender:))
        
        tableView = UITableView(frame: view.bounds, style: .plain)
        
        let cellNib = UINib(nibName: "RiskTableViewCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "riskCell")
        view.addSubview(tableView)
        
        var layoutGuide:UILayoutGuide!
        
        if #available(iOS 11.0, *) {
            layoutGuide = view.safeAreaLayoutGuide
        } else {
            layoutGuide = view.layoutMarginsGuide
        }
        
        self.tableViewConstraintFix(tableView, layoutGuide)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.reloadData()
        
    }
    
    @objc func onLogOutAction(_sender:UIButton!)
    {
        do{
            try FIRAuth.auth()?.signOut()
        } catch {
            print (error)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return risks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "riskCell", for: indexPath) as! RiskTableViewCell
        cell.set(risk: risks[indexPath.row])
        return cell
    }
    
    func fillTestParams() -> [Risk] {
        risks = [
            Risk(id: "1", author: "Andrew Skobtsov", description: "Test description 1"),
            Risk(id: "2", author: "Vadim Margiev", description: "Test description 2"),
            Risk(id: "3", author: "Margij Vadimov", description: "Test description 3")
        ]
        return risks
    }
    
    func tableViewConstraintFix(_ tableView: UITableView, _ layoutGuide: UILayoutGuide) {
        tableView.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: layoutGuide.topAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor).isActive = true
    }
}
