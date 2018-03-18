//
//  JSONParser.swift
//  DPE Dashboard
//
//  Created by Muhammad Yusuf on 12/25/17.
//  Copyright © 2017 Department Power Plant & Energy. All rights reserved.
//

import Foundation
struct JSONParser {
    
    static let divider: Double = 1000.0
    
    static func parseChartDataItem(data: AnyObject) -> ChartDataItem {
        let month = data["month"] as? String ?? ""
        let plan = data["plan"] as? Double ?? 0.0
        let actual = data["actual"] as? Double ?? 0.0
        return ChartDataItem(month: month, plan: plan / divider, actual: actual / divider)
    }
    
    static func parseDashboardDetail(data: AnyObject) -> DashboardDetail {
        let ok = data["ok"] as? Double ?? 0.0
        let op = data["op"] as? Double ?? 0.0
        let lsp = data["lsp"] as? Double ?? 0.0
        let lk = data["lk"] as? Double ?? 0.0
        return DashboardDetail(ok: ok / divider, op: op / divider , lsp: lsp / divider, lk: lk / divider)
    }
    
    static func parseBad(data: AnyObject) -> BadData {
        let project = data["Project"] as AnyObject
        let projectCode = project["code"] as? String ?? ""
        let projectName = project["name"] as? String ?? ""
        let piutangUsaha = data["piutangUsaha"] as? Double ?? 0.0
        let tagihanBruto = data["tagihanBruto"] as? Double ?? 0.0
        let piutangRetensi = data["piutangRetensi"] as? Double ?? 0.0
        let pdp = data["pdp"] as? Double ?? 0.0
        let bad = data["bad"] as? Double ?? 0.0
        return BadData(projectCode: projectCode, projectName: projectName, piutangUsaha: piutangUsaha / divider, tagihanBruto: tagihanBruto / divider, piutangRetensi: piutangRetensi / divider, pdp: pdp / divider, bad: bad / divider)
    }
    
    static func parseUmurPiutang(data: AnyObject) -> UpData {
        let pdp1 = data["pdp1"] as? Double ?? 0.0
        let pdp2 = data["pdp2"] as? Double ?? 0.0
        let pdp3 = data["pdp3"] as? Double ?? 0.0
        let pdp4 = data["pdp4"] as? Double ?? 0.0
        let pdp5 = data["pdp5"] as? Double ?? 0.0
        
        let tagihanBruto1 = data["tagihanBruto1"] as? Double ?? 0.0
        let tagihanBruto2 = data["tagihanBruto2"] as? Double ?? 0.0
        let tagihanBruto3 = data["tagihanBruto3"] as? Double ?? 0.0
        let tagihanBruto4 = data["tagihanBruto4"] as? Double ?? 0.0
        let tagihanBruto5 = data["tagihanBruto5"] as? Double ?? 0.0
        
        let piutangUsaha1 = data["piutangUsaha1"] as? Double ?? 0.0
        let piutangUsaha2 = data["piutangUsaha2"] as? Double ?? 0.0
        let piutangUsaha3 = data["piutangUsaha3"] as? Double ?? 0.0
        let piutangUsaha4 = data["piutangUsaha4"] as? Double ?? 0.0
        let piutangUsaha5 = data["piutangUsaha5"] as? Double ?? 0.0
        
        let piutangRetensi1 = data["piutangRetensi1"] as? Double ?? 0.0
        let piutangRetensi2 = data["piutangRetensi2"] as? Double ?? 0.0
        let piutangRetensi3 = data["piutangRetensi3"] as? Double ?? 0.0
        let piutangRetensi4 = data["piutangRetensi4"] as? Double ?? 0.0
        let piutangRetensi5 = data["piutangRetensi5"] as? Double ?? 0.0
        
        return UpData(
            pdp1: pdp1 / divider,
            pdp2: pdp2 / divider,
            pdp3: pdp3 / divider,
            pdp4: pdp4 / divider,
            pdp5: pdp5 / divider,
            tagihanBruto1: tagihanBruto1 / divider,
            tagihanBruto2: tagihanBruto2 / divider,
            tagihanBruto3: tagihanBruto3 / divider,
            tagihanBruto4: tagihanBruto4 / divider,
            tagihanBruto5: tagihanBruto5 / divider,
            piutangUsaha1: piutangUsaha1 / divider,
            piutangUsaha2: piutangUsaha2 / divider,
            piutangUsaha3: piutangUsaha3 / divider,
            piutangUsaha4: piutangUsaha4 / divider,
            piutangUsaha5: piutangUsaha5 / divider,
            piutangRetensi1: piutangRetensi1 / divider,
            piutangRetensi2: piutangRetensi2 / divider,
            piutangRetensi3: piutangRetensi3 / divider,
            piutangRetensi4: piutangRetensi4 / divider,
            piutangRetensi5: piutangRetensi5 / divider
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
        let rkap = cashFlow["rkap"] as? Double ?? 0.0
        let ra = data["ra"] as? Double ?? 0.0
        let prog = data["prog"] as? Double ?? 0.0
        let ri = data["ri"] as? Double ?? 0.0

        return CashFlow(
            name: name!,
            rkap: rkap / divider,
            rencana: ra / divider,
            prognosa: prog / divider,
            realisasi: ri / divider
        )
    }
    
    static func parsePrognosaPiutang(data: AnyObject) -> PrognosaPiutang {
        let pdp = data["pdp"] as? Double ?? 0.0
        let tagihanBruto = data["tagihanBruto"] as? Double ?? 0.0
        let piutangUsaha = data["piutangUsaha"] as? Double ?? 0.0
        let piutangRetensi = data["piutangRetensi"] as? Double ?? 0.0
        
        return PrognosaPiutang(pdp: pdp / divider, tagihanBruto: tagihanBruto / divider, piutangUsaha: piutangUsaha / divider, piutangRetensi: piutangRetensi / divider)
    }
    
    static func parseOkProjectDetails(data: AnyObject) -> OkProjectDetails {
        let projectName = data["projectName"] as? String ?? ""
        let projectType = data["projectType"] as? Int ?? 0
        let prognosaLk = data["prognosaLk"] as? Double ?? 0.0
        let prognosaOk = data["prognosaOk"] as? Double ?? 0.0
        let prognosaOp = data["prognosaOp"] as? Double ?? 0.0
        let realisasiLk = data["realisasiLk"] as? Double ?? 0.0
        let realisasiOk = data["realisasiOk"] as? Double ?? 0.0
        let realisasiOp = data["realisasiOp"] as? Double ?? 0.0
        let rkapLk = data["rkapLk"] as? Double ?? 0.0
        let rkapOk = data["rkapOk"] as? Double ?? 0.0
        let rkapOp = data["rkapOp"] as? Double ?? 0.0
        return OkProjectDetails(
            projectName: projectName,
            projectType: projectType,
            prognosaLk: prognosaLk / divider,
            prognosaOk: prognosaOk / divider,
            prognosaOp: prognosaOp / divider,
            realisasiLk: realisasiLk / divider,
            realisasiOk: realisasiOk / divider,
            realisasiOp: realisasiOp / divider,
            rkapLk: rkapLk / divider,
            rkapOk: rkapOk / divider,
            rkapOp: rkapOp / divider
        )
    }
}
