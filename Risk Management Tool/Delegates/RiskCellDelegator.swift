//
//  RiskCellDelegator.swift
//  Risk Management Tool
//
//  Created by Nikitinho on 23/03/2019.
//  Copyright © 2019 Nikitinho. All rights reserved.
//

import Foundation
protocol RiskCellDelegator:class {
    func callSegueFromCell(_ sender: RiskTableViewCell)
}
