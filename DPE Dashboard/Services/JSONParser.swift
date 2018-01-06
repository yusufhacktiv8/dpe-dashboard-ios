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
        let plan = data["plan"] as? Double ?? 0.0
        let actual = data["actual"] as? Double ?? 0.0
        return ChartDataItem(month: month, plan: plan, actual: actual)
    }
    
    static func parseDashboardDetail(data: AnyObject) -> DashboardDetail {
        let ok = data["ok"] as? Double ?? nil
        let op = data["op"] as? Double ?? nil
        let lsp = data["lsp"] as? Double ?? 0.0
        let lk = data["lk"] as? Double ?? nil
        return DashboardDetail(ok: ok!, op: op!, lsp: lsp, lk: lk!)
    }
    
    static func parseBad(data: AnyObject) -> BadData {
        let project = data["Project"] as AnyObject
        let projectCode = project["code"] as? String ?? ""
        let projectName = project["name"] as? String ?? ""
        let piutangUsaha = data["piutangUsaha"] as? Double ?? nil
        let tagihanBruto = data["tagihanBruto"] as? Double ?? nil
        let piutangRetensi = data["piutangRetensi"] as? Double ?? nil
        let pdp = data["pdp"] as? Double ?? nil
        let bad = data["bad"] as? Double ?? nil
        return BadData(projectCode: projectCode, projectName: projectName, piutangUsaha: piutangUsaha!, tagihanBruto: tagihanBruto!, piutangRetensi: piutangRetensi!, pdp: pdp!, bad: bad!)
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
    
    static func parseCashFlow(data: AnyObject) -> CashFlow {
        let cashFlow = data["CashFlow"] as AnyObject
        let typeCode = cashFlow["typeCode"] as? Int ?? nil
        var name: String?
        switch (typeCode!) {
        case 1:
            name = "Saldo Awal"
        case 2:
            name = "Penerimaan"
        case 3:
            name = "Pengeluaran"
        case 4:
            name = "Kelebihan / (Kekurangan) Kas"
        case 5:
            name = "Setoran / Pinjaman / TTP"
        case 6:
            name = "Saldo Kas Akhir Bulan"
        case 7:
            name = "Saldo Awal R / K"
        case 8:
            name = "Jumlah Mutasi"
        case 9:
            name = "Jumlah R / K"
        case 10:
            name = "Jumlah Pemakaian Dana"
        case 11:
            name = "Total Bunga"
        case 12:
            name = "Saldo Akhir Pemakaian Dana"
        default:
            name = "-"
        }
        let rkap = cashFlow["rkap"] as? Double ?? nil
        let ra = data["ra"] as? Double ?? nil
        let prog = data["prog"] as? Double ?? nil
        let ri = data["ri"] as? Double ?? nil

        return CashFlow(
            name: name!,
            rkap: rkap!,
            rencana: ra!,
            prognosa: prog!,
            realisasi: ri!
        )
    }
    
    static func parsePrognosaPiutang(data: AnyObject) -> PrognosaPiutang {
        let pdp = data["pdp"] as? Double ?? nil
        let tagihanBruto = data["tagihanBruto"] as? Double ?? nil
        let piutangUsaha = data["piutangUsaha"] as? Double ?? nil
        let piutangRetensi = data["piutangRetensi"] as? Double ?? nil
        
        return PrognosaPiutang(pdp: pdp!, tagihanBruto: tagihanBruto!, piutangUsaha: piutangUsaha!, piutangRetensi: piutangRetensi!)
    }
}
