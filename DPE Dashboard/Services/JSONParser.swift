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
    
    static func parseDashboardDetail(data: AnyObject) -> DashboardDetail {
        let ok = data["ok"] as? Double ?? nil
        let op = data["op"] as? Double ?? nil
        let lsp = data["lsp"] as? Double ?? nil
        let lk = data["lk"] as? Double ?? nil
        return DashboardDetail(ok: ok!, op: op!, lsp: lsp!, lk: lk!)
    }
}
