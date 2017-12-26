//
//  Constant.swift
//  DPE Dashboard
//
//  Created by Muhammad Yusuf on 12/26/17.
//  Copyright © 2017 Department Power Plant & Energy. All rights reserved.
//

import UIKit

struct Constant {
    //App Constants
    static let MAIN_COLOR = UIColor(red:0.23, green:0.39, blue:0.73, alpha:1.0)
    static let defaultMonth: Int = 1
    static let defaultYear: Int = NSCalendar(identifier: NSCalendar.Identifier.gregorian)!.component(.year, from: NSDate() as Date) - 3
    static let months: [String]! = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
}
