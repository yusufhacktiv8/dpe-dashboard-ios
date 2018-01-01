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
        
        var description: String {
            switch self {
            case .SignIn: return "/signin"
            case .ChartData(let year): return "/dashboard/charts/\(year)"
            case .DetailsData(let year, let month): return "/dashboard/data/\(year)/\(month)"
            }
        }
    }
    
    public static func getChartsData(year: Int, myResponse: @escaping (ChartData) -> ()) {
        let urlString = DashboardConstant.BASE_URL + ResourcePath.ChartData(year: year).description
        
        let headers = ["Authorization": "Basic \(UserVar.token)"]
        
        Alamofire.request(urlString, headers: headers).responseJSON { response in
            
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
                
                myResponse(ChartData(okData: okData, opData: opData, lkData: lkData, lspData: lspData))
            }
            
        }
    }
    
    public static func getDashboardDetailsData(year: Int, month: Int, myResponse: @escaping ([DashboardDetail]) -> ()) {
        let urlString = DashboardConstant.BASE_URL + ResourcePath.DetailsData(year: year, month: month).description
        
        let headers = ["Authorization": "Basic \(UserVar.token)"]
        
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
    
}

