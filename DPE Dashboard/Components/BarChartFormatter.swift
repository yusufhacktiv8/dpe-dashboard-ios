//
//  BarChartFormatter.swift
//  DPE Dashboard
//
//  Created by Muhammad Yusuf on 1/1/18.
//  Copyright © 2018 Department Power Plant & Energy. All rights reserved.
//

import UIKit
import Foundation
import Charts

public class BarChartFormatter: NSObject, IAxisValueFormatter{
    
    var projectNames: [String]?
    
    init(projectNames: [String]) {
        self.projectNames = projectNames
    }
    
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let index = Int(value)
        if (index >= 0 && index < projectNames!.count) {
            return projectNames![index]
        } else {
            return ""
        }
        
    }
}
