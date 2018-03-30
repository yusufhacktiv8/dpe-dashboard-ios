//
//  DashboardService.swift
//  DPE Dashboard
//
//  Created by Muhammad Yusuf on 12/25/17.
//  Copyright © 2017 Department Power Plant & Energy. All rights reserved.
//

import Foundation
import Alamofire

public struct DashboardService {
    
    private enum ResourcePath: CustomStringConvertible {
        case SignIn
        case ChartData(year: Int)
        case DetailsData(year: Int, month: Int)
        case BadData(year: Int, month: Int)
        case UmurPiutangData(year: Int, month: Int)
        case CashFlow(year: Int, month: Int)
        case PrognosaPiutang(year: Int, month: Int)
        case OkProjectDetails(year: Int, month: Int, projectType: Int)
        
        var description: String {
            switch self {
            case .SignIn: return "/signin"
            case .ChartData(let year): return "/dashboard/charts/\(year)"
            case .DetailsData(let year, let month): return "/dashboard/data/\(year)/\(month)"
            case .BadData(let year, let month): return "/bads/all/\(year)/\(month)"
            case .UmurPiutangData(let year, let month): return "/piutangs/piutang/\(year)/\(month)"
            case .CashFlow(let year, let month): return "/cashflows/all/\(year)/\(month)"
            case .PrognosaPiutang(let year, let month): return "/projections/proyeksi/\(year)/\(month)"
            case .OkProjectDetails(let year, let month, let projectType): return "/okdetails/\(year)/\(month)/\(projectType)"
            }
        }
    }
    
    public static func getChartsData(year: Int, myResponse: @escaping (Int, ChartData?) -> ()) {
        let urlString = DashboardConstant.BASE_URL + ResourcePath.ChartData(year: year).description
        
        let headers = ["Authorization": "Bearer \(UserVar.token)"]
        
        Alamofire.request(urlString, headers: headers).responseJSON { response in
            
            if let statusCode = response.response?.statusCode {
                if (statusCode == 403) {
                    myResponse(statusCode, nil)
                }
                
                if let data = response.result.value {
                    
                    var okData: [ChartDataItem] = [ChartDataItem]()
                    var opData: [ChartDataItem] = [ChartDataItem]()
                    var lkData: [ChartDataItem] = [ChartDataItem]()
                    var lspData: [ChartDataItem] = [ChartDataItem]()
                    
                    guard let json = data as? [String : AnyObject] else {
                        print("Failed to get expected response from webserver.")
                        return
                    }
                    
                    let okDataJSONArray = (json["okData"] as! NSArray) as Array
                    let opDataJSONArray = (json["opData"] as! NSArray) as Array
                    let lkDataJSONArray = (json["lkData"] as! NSArray) as Array
                    let lspDataJSONArray = (json["lspData"] as! NSArray) as Array
                    
                    for itemArray in okDataJSONArray {
                        let chartDataItem = JSONParser.parseChartDataItem(data: itemArray)
                        okData.append(chartDataItem)
                    }
                    
                    for itemArray in opDataJSONArray {
                        let chartDataItem = JSONParser.parseChartDataItem(data: itemArray)
                        opData.append(chartDataItem)
                    }
                    
                    for itemArray in lkDataJSONArray {
                        let chartDataItem = JSONParser.parseChartDataItem(data: itemArray)
                        lkData.append(chartDataItem)
                    }
                    
                    for itemArray in lspDataJSONArray {
                        let chartDataItem = JSONParser.parseChartDataItem(data: itemArray)
                        lspData.append(chartDataItem)
                    }
                    
                    myResponse(200, ChartData(okData: okData, opData: opData, lkData: lkData, lspData: lspData))
                }
                
            } else {
                myResponse(-1, nil)
            }
        }
    }
    
    public static func getDashboardDetailsData(year: Int, month: Int, myResponse: @escaping ([DashboardDetail]) -> ()) {
        let urlString = DashboardConstant.BASE_URL + ResourcePath.DetailsData(year: year, month: month).description
        
        let headers = ["Authorization": "Bearer \(UserVar.token)"]
        
        Alamofire.request(urlString, headers: headers).responseJSON { response in
            
            if let data = response.result.value {
                guard let json = data as? [String : AnyObject] else {
                    print("Failed to get expected response from webserver.")
                    return
                }
            
                var dashboardDetails = [DashboardDetail]()
                dashboardDetails.append(JSONParser.parseDashboardDetail(data: json["data1"]!))
                dashboardDetails.append(JSONParser.parseDashboardDetail(data: json["data2"]!))
                dashboardDetails.append(JSONParser.parseDashboardDetail(data: json["data3"]!))
                dashboardDetails.append(JSONParser.parseDashboardDetail(data: json["data4"]!))
                dashboardDetails.append(JSONParser.parseDashboardDetail(data: json["data5"]!))
                dashboardDetails.append(JSONParser.parseDashboardDetail(data: json["data6"]!))
                dashboardDetails.append(JSONParser.parseDashboardDetail(data: json["data7"]!))
                dashboardDetails.append(JSONParser.parseDashboardDetail(data: json["data8"]!))
                
                myResponse(dashboardDetails)
            }
            
        }
    }
    
    public static func getBadData(year: Int, month: Int, myResponse: @escaping ([BadData]) -> ()) {
        let urlString = DashboardConstant.BASE_URL + ResourcePath.BadData(year: year, month: month).description
        
        let headers = ["Authorization": "Bearer \(UserVar.token)"]
        
        Alamofire.request(urlString, headers: headers).responseJSON { response in
            if let data = response.result.value {
                guard let json = (data as? NSArray) as Array<AnyObject>? else {
                    print("Failed to get expected response from webserver.")
                    return
                }
                
                var badDatas = [BadData]()
                for badData in json {
                    badDatas.append(JSONParser.parseBad(data: badData))
                }
                
                myResponse(badDatas)
            }

        }
    }
    
    public static func getUmurPiutangData(year: Int, month: Int, myResponse: @escaping ([UpData]) -> ()) {
        let urlString = DashboardConstant.BASE_URL + ResourcePath.UmurPiutangData(year: year, month: month).description
        
        let headers = ["Authorization": "Bearer \(UserVar.token)"]
        
        Alamofire.request(urlString, headers: headers).responseJSON { response in
            if let data = response.result.value {
                guard let json = (data as? NSArray) as Array<AnyObject>? else {
                    print("Failed to get expected response from webserver.")
                    return
                }
                
                var upDatas = [UpData]()
                for upData in json {
                    upDatas.append(JSONParser.parseUmurPiutang(data: upData))
                }
                
                myResponse(upDatas)
            }
            
        }
    }
    
    public static func getCashFlowData(year: Int, month: Int, myResponse: @escaping ([CashFlow]) -> ()) {
        let urlString = DashboardConstant.BASE_URL + ResourcePath.CashFlow(year: year, month: month).description
        
        let headers = ["Authorization": "Bearer \(UserVar.token)"]
        
        Alamofire.request(urlString, headers: headers).responseJSON { response in
            if let data = response.result.value {
                guard let json = (data as? NSArray) as Array<AnyObject>? else {
                    print("Failed to get expected response from webserver.")
                    return
                }
                
                var cashFlows = [CashFlow]()
                for cashFlow in json {
                    cashFlows.append(JSONParser.parseCashFlow(data: cashFlow))
                }
                
                myResponse(cashFlows)
            }
            
        }
    }
    
    public static func getPrognosaPiutangData(year: Int, month: Int, myResponse: @escaping (PrognosaPiutang) -> ()) {
        let urlString = DashboardConstant.BASE_URL + ResourcePath.PrognosaPiutang(year: year, month: month).description
        
        let headers = ["Authorization": "Bearer \(UserVar.token)"]
        
        Alamofire.request(urlString, headers: headers).responseJSON { response in
            
            if let data = response.result.value {
                guard let json = (data as? NSArray) as Array<AnyObject>? else {
                    print("Failed to get expected response from webserver.")
                    return
                }
                
                var prognosa = PrognosaPiutang(pdp: 0.0, tagihanBruto: 0.0, piutangUsaha: 0.0, piutangRetensi: 0.0)
                for item in json {
                    prognosa = JSONParser.parsePrognosaPiutang(data: item)
                }
                
                myResponse(prognosa)
            }
            
        }
    }
    
    public static func getOkProjectDetailsData(year: Int, month: Int, projectType: Int, myResponse: @escaping ([OkProjectDetails]) -> ()) {
        let urlString = DashboardConstant.BASE_URL + ResourcePath.OkProjectDetails(year: year, month: month, projectType: projectType).description
        
        let headers = ["Authorization": "Bearer \(UserVar.token)"]
        
        Alamofire.request(urlString, headers: headers).responseJSON { response in
            if let data = response.result.value {
                guard let json = (data as? NSArray) as Array<AnyObject>? else {
                    print("Failed to get expected response from webserver.")
                    return
                }
                
                var okProjects = [OkProjectDetails]()
                for okProject in json {
                    okProjects.append(JSONParser.parseOkProjectDetails(data: okProject))
                }
                
                myResponse(okProjects)
            }
            
        }
    }
    
}

