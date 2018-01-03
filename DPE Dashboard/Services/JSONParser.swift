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
    
    static func parseBad(data: AnyObject) -> BadData {
        let project = data["Project"] as AnyObject
        let projectName = project["name"] as? String ?? ""
        let piutangUsaha = data["piutangUsaha"] as? Double ?? nil
        let tagihanBruto = data["tagihanBruto"] as? Double ?? nil
        let piutangRetensi = data["piutangRetensi"] as? Double ?? nil
        let pdp = data["pdp"] as? Double ?? nil
        let bad = data["bad"] as? Double ?? nil
        return BadData(projectName: projectName, piutangUsaha: piutangUsaha!, tagihanBruto: tagihanBruto!, piutangRetensi: piutangRetensi!, pdp: pdp!, bad: bad!)
    }
    
    static func parseUmurPiutang(data: AnyObject) -> UpData {
        let pdp1 = data["pdp1"] as? Double ?? nil
        let pdp2 = data["pdp2"] as? Double ?? nil
        let pdp3 = data["pdp3"] as? Double ?? nil
        let pdp4 = data["pdp4"] as? Double ?? nil
        let pdp5 = data["pdp5"] as? Double ?? nil
        
        let tagihanBruto1 = data["tagihanBruto1"] as? Double ?? nil
        let tagihanBruto2 = data["tagihanBruto2"] as? Double ?? nil
        let tagihanBruto3 = data["tagihanBruto3"] as? Double ?? nil
        let tagihanBruto4 = data["tagihanBruto4"] as? Double ?? nil
        let tagihanBruto5 = data["tagihanBruto5"] as? Double ?? nil
        
        let piutangUsaha1 = data["piutangUsaha1"] as? Double ?? nil
        let piutangUsaha2 = data["piutangUsaha2"] as? Double ?? nil
        let piutangUsaha3 = data["piutangUsaha3"] as? Double ?? nil
        let piutangUsaha4 = data["piutangUsaha4"] as? Double ?? nil
        let piutangUsaha5 = data["piutangUsaha5"] as? Double ?? nil
        
        let piutangRetensi1 = data["piutangRetensi1"] as? Double ?? nil
        let piutangRetensi2 = data["piutangRetensi2"] as? Double ?? nil
        let piutangRetensi3 = data["piutangRetensi3"] as? Double ?? nil
        let piutangRetensi4 = data["piutangRetensi4"] as? Double ?? nil
        let piutangRetensi5 = data["piutangRetensi5"] as? Double ?? nil
        
        return UpData(
            pdp1: pdp1!,
            pdp2: pdp2!,
            pdp3: pdp3!,
            pdp4: pdp4!,
            pdp5: pdp5!,
            tagihanBruto1: tagihanBruto1!,
            tagihanBruto2: tagihanBruto2!,
            tagihanBruto3: tagihanBruto3!,
            tagihanBruto4: tagihanBruto4!,
            tagihanBruto5: tagihanBruto5!,
            piutangUsaha1: piutangUsaha1!,
            piutangUsaha2: piutangUsaha2!,
            piutangUsaha3: piutangUsaha3!,
            piutangUsaha4: piutangUsaha4!,
            piutangUsaha5: piutangUsaha5!,
            piutangRetensi1: piutangRetensi1!,
            piutangRetensi2: piutangRetensi2!,
            piutangRetensi3: piutangRetensi3!,
            piutangRetensi4: piutangRetensi4!,
            piutangRetensi5: piutangRetensi5!
        )
    }
}
