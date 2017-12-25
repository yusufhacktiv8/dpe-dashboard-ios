//
//  ChartViewController.swift
//  DPE Dashboard
//
//  Created by Muhammad Yusuf on 12/25/17.
//  Copyright © 2017 Department Power Plant & Energy. All rights reserved.
//

import UIKit
import Charts

class ChartViewController: UIViewController {
    
    @IBOutlet weak var chartScrollView: UIScrollView!
    @IBOutlet weak var chartStackView: UIStackView!
    private var omzetChartView: DashboardChart? = nil
    
    var selectedMonth: Int! = 1
    var selectedYear: Int! = 2017
    
    var omzetMonths: [String] = [String]()
    var planValues: [Double] = [Double]()
    var actualValues: [Double] = [Double]()

    override func viewDidLoad() {
        super.viewDidLoad()

        initChartViews()
        getChartData1()
    }

    private func initChartViews() {
        var chartView = initChart1()
        chartStackView.addArrangedSubview(chartView)
        chartView.widthAnchor.constraint(equalTo: chartScrollView.widthAnchor).isActive = true
        chartView.heightAnchor.constraint(equalTo: chartScrollView.heightAnchor).isActive = true
        omzetChartView = chartView
        
        chartView = DashboardChart()
        chartView.backgroundColor = UIColor.blue
        chartStackView.addArrangedSubview(chartView)
        
        chartView.widthAnchor.constraint(equalTo: chartScrollView.widthAnchor).isActive = true
        chartView.heightAnchor.constraint(equalTo: chartScrollView.heightAnchor).isActive = true
        
        chartView = DashboardChart()
        chartView.backgroundColor = UIColor.yellow
        chartStackView.addArrangedSubview(chartView)
        
        chartView.widthAnchor.constraint(equalTo: chartScrollView.widthAnchor).isActive = true
        chartView.heightAnchor.constraint(equalTo: chartScrollView.heightAnchor).isActive = true
    }
    
    private func initChart1() -> DashboardChart {
        let chartView = DashboardChart()
        chartView.backgroundColor = UIColor(red:0.22, green:0.40, blue:0.71, alpha:1.0)
        chartView.valueLabelColor = UIColor.white
        chartView.circle1Color = UIColor.yellow
        chartView.legend1Color = UIColor.white
        chartView.circle2Color = UIColor.blue
        chartView.legend2Color = UIColor.white
        chartView.title = "Omzet Kontrak"
        chartView.titleColor = UIColor.white
        chartView.legend1 = "Realisasi"
        chartView.legend1Color = UIColor.white
        chartView.legend2 = "Rencana"
        chartView.legend2Color = UIColor.white
        return chartView
    }
    
    private func getChartData1() -> Void{
        
        var months: [String] = [String]()
        var planValues: [Double] = [Double]()
        var actualValues: [Double] = [Double]()
    
    }
    
    private func setDataChart1(months: [String], plans: [Double], actuals: [Double]) {
        var planDataEntries: [ChartDataEntry] = []
        for i in 0..<months.count {
            if (i<plans.count){
                //                planDataEntries.append(ChartDataEntry(x: plans[i], y: Double(i)))
                planDataEntries.append(ChartDataEntry(x: Double(i), y: plans[i]))
            }
        }
        let planLineChartDataSet = LineChartDataSet(values: planDataEntries, label: "Plans")
        
        planLineChartDataSet.mode = LineChartDataSet.Mode.cubicBezier
        planLineChartDataSet.drawCirclesEnabled = false
        planLineChartDataSet.drawFilledEnabled = true
        
        planLineChartDataSet.drawValuesEnabled = false
        planLineChartDataSet.fillColor = UIColor(red:0.41, green:0.72, blue:0.87, alpha:1.0)
        planLineChartDataSet.fillAlpha = 0.5
        
        var actualDataEntries: [ChartDataEntry] = []
        for i in 0..<months.count {
            if(i < actuals.count){
                //                actualDataEntries.append(ChartDataEntry(x: actuals[i], y: Double(i)))
                actualDataEntries.append(ChartDataEntry(x: Double(i), y: actuals[i]))
            }
        }
        
        let actualLineChartDataSet = LineChartDataSet(values: actualDataEntries, label: "Actuals")
        
        actualLineChartDataSet.mode = LineChartDataSet.Mode.cubicBezier
        actualLineChartDataSet.drawCirclesEnabled = false
        actualLineChartDataSet.drawFilledEnabled = true
        
        actualLineChartDataSet.drawValuesEnabled = false
        actualLineChartDataSet.fillColor = UIColor(red:0.97, green:0.91, blue:0.11, alpha:1.0)
        
        actualLineChartDataSet.fillAlpha = 1.0
        
        var dataSets : [LineChartDataSet] = [LineChartDataSet]()
        dataSets.append(actualLineChartDataSet)
        dataSets.append(planLineChartDataSet)
        
        let omzetLineChartData = LineChartData(dataSets: dataSets)
        omzetChartView?.setChartData(chartData: omzetLineChartData, xValues: months)
        
    }

}
