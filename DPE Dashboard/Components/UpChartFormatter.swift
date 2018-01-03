//
//  UpChartFormatter.swift
//  DPE Dashboard
//
//  Created by Muhammad Yusuf on 1/3/18.
//  Copyright © 2018 Department Power Plant & Energy. All rights reserved.
//

import UIKit
import Foundation
import Charts

public class UpChartFormatter: NSObject, IAxisValueFormatter {
    
    let XAXIS_TITLES = ["PDP", "TAG BRUTO", "PIUTANG USAHA", "PIUTANG RETENSI"]
    
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let index = Int(value)
        if (index >= 0 && index < XAXIS_TITLES.count) {
            return XAXIS_TITLES[index]
        } else {
            return ""
        }
        
    }
}
