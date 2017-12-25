//
//  JSONParser.swift
//  DPE Dashboard
//
//  Created by Muhammad Yusuf on 12/25/17.
//  Copyright © 2017 Department Power Plant & Energy. All rights reserved.
//

import Foundation
struct JSONParser {
    static func parseChartDataItem(data: AnyObject) -> ChartDataItem {
        let month = data["month"] as? String ?? ""
        let plan = data["plan"] as? Double ?? nil
        let actual = data["actual"] as? Double ?? nil
        return ChartDataItem(month: month, plan: plan!, actual: actual!)
    }
}
