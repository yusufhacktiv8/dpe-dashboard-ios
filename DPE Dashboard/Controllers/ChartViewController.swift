//
//  ChartViewController.swift
//  DPE Dashboard
//
//  Created by Muhammad Yusuf on 12/25/17.
//  Copyright © 2017 Department Power Plant & Energy. All rights reserved.
//

import UIKit
import Charts

class ChartViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var chartScrollView: UIScrollView!
    @IBOutlet weak var chartStackView: UIStackView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    private var omzetChartView: DashboardChart? = nil
    private var penjualanChartView: DashboardChart? = nil
    private var labaKotorChartView: DashboardChart? = nil
    private var lspChartView: DashboardChart? = nil
    
    var selectedMonth: Int! = 1
    var selectedYear: Int! = 2017
    
    var chartData: ChartData?
    var omzetMonths: [String] = [String]()
    var planValues: [Double] = [Double]()
    var actualValues: [Double] = [Double]()
    
    let decimalFormatter = NumberFormatter()

    override func viewDidLoad() {
        super.viewDidLoad()
        initFormatter()
        initChartViews()
        initChartScrollView()
        initPageControl()
    }
    
    private func initFormatter() {
        self.decimalFormatter.numberStyle = NumberFormatter.Style.decimal
        self.decimalFormatter.minimumFractionDigits = 2
        self.decimalFormatter.maximumFractionDigits = 2
    }

    private func initChartViews() {
        var chartView = initChart1()
        chartStackView.addArrangedSubview(chartView)
        chartView.widthAnchor.constraint(equalTo: chartScrollView.widthAnchor).isActive = true
        chartView.heightAnchor.constraint(equalTo: chartScrollView.heightAnchor).isActive = true
        omzetChartView = chartView
        
        chartView = initChart2()
        chartStackView.addArrangedSubview(chartView)
        chartView.widthAnchor.constraint(equalTo: chartScrollView.widthAnchor).isActive = true
        chartView.heightAnchor.constraint(equalTo: chartScrollView.heightAnchor).isActive = true
        penjualanChartView = chartView
        
        chartView = initChart3()
        chartStackView.addArrangedSubview(chartView)
        chartView.widthAnchor.constraint(equalTo: chartScrollView.widthAnchor).isActive = true
        chartView.heightAnchor.constraint(equalTo: chartScrollView.heightAnchor).isActive = true
        labaKotorChartView = chartView
        
        chartView = initChart4()
        chartStackView.addArrangedSubview(chartView)
        chartView.widthAnchor.constraint(equalTo: chartScrollView.widthAnchor).isActive = true
        chartView.heightAnchor.constraint(equalTo: chartScrollView.heightAnchor).isActive = true
        lspChartView = chartView
        
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
    
    private func initChart2() -> DashboardChart {
        let chartView = DashboardChart()
        chartView.backgroundColor = UIColor(red:0.22, green:0.40, blue:0.71, alpha:1.0)
        chartView.valueLabelColor = UIColor.white
        chartView.circle1Color = UIColor.yellow
        chartView.legend1Color = UIColor.white
        chartView.circle2Color = UIColor.blue
        chartView.legend2Color = UIColor.white
        chartView.title = "Penjualan"
        chartView.titleColor = UIColor.white
        chartView.legend1 = "Realisasi"
        chartView.legend1Color = UIColor.white
        chartView.legend2 = "Rencana"
        chartView.legend2Color = UIColor.white
        return chartView
    }
    
    private func initChart3() -> DashboardChart {
        let chartView = DashboardChart()
        chartView.backgroundColor = UIColor(red:0.22, green:0.40, blue:0.71, alpha:1.0)
        chartView.valueLabelColor = UIColor.white
        chartView.circle1Color = UIColor.yellow
        chartView.legend1Color = UIColor.white
        chartView.circle2Color = UIColor.blue
        chartView.legend2Color = UIColor.white
        chartView.title = "Laba Kotor"
        chartView.titleColor = UIColor.white
        chartView.legend1 = "Realisasi"
        chartView.legend1Color = UIColor.white
        chartView.legend2 = "Rencana"
        chartView.legend2Color = UIColor.white
        return chartView
    }
    
    private func initChart4() -> DashboardChart {
        let chartView = DashboardChart()
        chartView.backgroundColor = UIColor(red:0.22, green:0.40, blue:0.71, alpha:1.0)
        chartView.valueLabelColor = UIColor.white
        chartView.circle1Color = UIColor.yellow
        chartView.legend1Color = UIColor.white
        chartView.circle2Color = UIColor.blue
        chartView.legend2Color = UIColor.white
        chartView.title = "LSP"
        chartView.titleColor = UIColor.white
        chartView.legend1 = "Realisasi"
        chartView.legend1Color = UIColor.white
        chartView.legend2 = "Rencana"
        chartView.legend2Color = UIColor.white
        return chartView
    }
    
    func loadData(year: Int, month: Int) -> Void{
        DashboardService.getChartsData(year: year) { chartData in
            self.chartData = chartData
            self.fillChart1(chartData: chartData, month: month)
            self.fillChart2(chartData: chartData, month: month)
            self.fillChart3(chartData: chartData, month: month)
            self.fillChart4(chartData: chartData, month: month)
        }
        
    }
    
    private func fillChart1(chartData: ChartData, month: Int) -> Void{
        
        var months: [String] = [String]()
        var planValues: [Double] = [Double]()
        var actualValues: [Double] = [Double]()
        
        var planCumulative: Double = 0.0
        var actualCumulative: Double = 0.0
        
        if (chartData.okData.count > 0) {
            for theData in chartData.okData {
                planCumulative += theData.plan
                actualCumulative += theData.actual
                
                months.append(theData.month)
                planValues.append(planCumulative)
                actualValues.append(actualCumulative)
            }
    
            if(months.count > 0){
                months.insert("", at: 0)
                months.append("")
            }
            
            if(planValues.count > 0){
                planValues.insert(0.0, at: 0)
            }
            if(planValues.count >= 13){
                planValues.append(planValues[planValues.count-1] + 0.01)
            }
            
            if(actualValues.count > 0){
                actualValues.insert(0.0, at: 0)
            }
            
            if(actualValues.count >= 13){
                actualValues.append(actualValues[actualValues.count-1] + 0.01)
            }
            self.setDataChart(months: months, plans: planValues, actuals: actualValues, dashboardChart: self.omzetChartView!)
            
            self.omzetChartView!.zoom(xValue: Double(month - 1), yValue: actualValues[month])
            self.omzetChartView!.setValueCaption(caption: decimalFormatter.string(from: NSNumber(value: actualValues[month]))!)
        } else {
            self.omzetChartView!.clearChartData()
        }
    }
    
    private func fillChart2(chartData: ChartData, month: Int) -> Void{
        
        var months: [String] = [String]()
        var planValues: [Double] = [Double]()
        var actualValues: [Double] = [Double]()
        
        var planCumulative: Double = 0.0
        var actualCumulative: Double = 0.0
        
        if (chartData.opData.count > 0) {
            for theData in chartData.opData {
                planCumulative += theData.plan
                actualCumulative += theData.actual
                
                months.append(theData.month)
                planValues.append(planCumulative)
                actualValues.append(actualCumulative)
            }
            
            if(months.count > 0){
                months.insert("", at: 0)
                months.append("")
            }
            
            if(planValues.count > 0){
                planValues.insert(0.0, at: 0)
            }
            if(planValues.count >= 13){
                planValues.append(planValues[planValues.count-1] + 0.01)
            }
            
            if(actualValues.count > 0){
                actualValues.insert(0.0, at: 0)
            }
            
            if(actualValues.count >= 13){
                actualValues.append(actualValues[actualValues.count-1] + 0.01)
            }
            
            self.setDataChart(months: months, plans: planValues, actuals: actualValues, dashboardChart: self.penjualanChartView!)
            
            self.penjualanChartView!.zoom(xValue: Double(month), yValue: actualValues[month])
            self.penjualanChartView!.setValueCaption(caption: decimalFormatter.string(from: NSNumber(value: actualValues[month]))!)
        } else {
            self.penjualanChartView!.clearChartData()
        }
    }
    
    private func fillChart3(chartData: ChartData, month: Int) -> Void{
        
        var months: [String] = [String]()
        var planValues: [Double] = [Double]()
        var actualValues: [Double] = [Double]()
        
        var planCumulative: Double = 0.0
        var actualCumulative: Double = 0.0
        
        if (chartData.lkData.count > 0) {
            for theData in chartData.lkData {
                planCumulative += theData.plan
                actualCumulative += theData.actual
                
                months.append(theData.month)
                planValues.append(planCumulative)
                actualValues.append(actualCumulative)
            }
            
            if(months.count > 0){
                months.insert("", at: 0)
                months.append("")
            }
            
            if(planValues.count > 0){
                planValues.insert(0.0, at: 0)
            }
            if(planValues.count >= 13){
                planValues.append(planValues[planValues.count-1] + 0.01)
            }
            
            if(actualValues.count > 0){
                actualValues.insert(0.0, at: 0)
            }
            
            if(actualValues.count >= 13){
                actualValues.append(actualValues[actualValues.count-1] + 0.01)
            }
            
            self.setDataChart(months: months, plans: planValues, actuals: actualValues, dashboardChart: self.labaKotorChartView!)
            self.labaKotorChartView!.zoom(xValue: Double(month), yValue: actualValues[month])
            self.labaKotorChartView!.setValueCaption(caption: decimalFormatter.string(from: NSNumber(value: actualValues[month]))!)
        } else {
            self.labaKotorChartView!.clearChartData()
        }
    }
    
    private func fillChart4(chartData: ChartData, month: Int) -> Void{
        
        var months: [String] = [String]()
        var planValues: [Double] = [Double]()
        var actualValues: [Double] = [Double]()
        
        if (chartData.lspData.count > 0) {
            for theData in chartData.lspData {
                months.append(theData.month)
                planValues.append(theData.plan)
                actualValues.append(theData.actual)
            }
            
            if(months.count > 0){
                months.insert("", at: 0)
                months.append("")
            }
            
            if(planValues.count > 0){
                planValues.insert(0.0, at: 0)
            }
            if(planValues.count >= 13){
                planValues.append(planValues[planValues.count-1] + 0.01)
            }
            
            if(actualValues.count > 0){
                actualValues.insert(0.0, at: 0)
            }
            
            if(actualValues.count >= 13){
                actualValues.append(actualValues[actualValues.count-1] + 0.01)
            }
            
            self.setDataChart(months: months, plans: planValues, actuals: actualValues, dashboardChart: self.lspChartView!)
            self.lspChartView!.zoom(xValue: Double(month), yValue: actualValues[month])
            self.lspChartView!.setValueCaption(caption: decimalFormatter.string(from: NSNumber(value: actualValues[month]))!)
        } else {
            self.lspChartView!.clearChartData()
        }
        
        
    }
    
    private func setDataChart(months: [String], plans: [Double], actuals: [Double], dashboardChart: DashboardChart) {
        var planDataEntries: [ChartDataEntry] = []
        for i in 0..<months.count {
            if (i<plans.count){
                //                planDataEntries.append(ChartDataEntry(x: plans[i], y: Double(i)))
                planDataEntries.append(ChartDataEntry(x: Double(i), y: plans[i]))
            }
        }
        let planLineChartDataSet = LineChartDataSet(values: planDataEntries, label: "Plans")
        
//        planLineChartDataSet.mode = LineChartDataSet.Mode.cubicBezier
        planLineChartDataSet.mode = LineChartDataSet.Mode.linear
        planLineChartDataSet.lineWidth = 6.0
        planLineChartDataSet.drawCirclesEnabled = false
//        planLineChartDataSet.drawFilledEnabled = true
        
        planLineChartDataSet.drawValuesEnabled = false
//        planLineChartDataSet.fillColor = UIColor(red:0.41, green:0.72, blue:0.87, alpha:1.0)
//        planLineChartDataSet.fillAlpha = 0.5
        
        var actualDataEntries: [ChartDataEntry] = []
        for i in 0..<months.count {
            if(i < actuals.count){
                //                actualDataEntries.append(ChartDataEntry(x: actuals[i], y: Double(i)))
                actualDataEntries.append(ChartDataEntry(x: Double(i), y: actuals[i]))
            }
        }
        
        let actualLineChartDataSet = LineChartDataSet(values: actualDataEntries, label: "Actuals")
        
//        actualLineChartDataSet.mode = LineChartDataSet.Mode.cubicBezier
        actualLineChartDataSet.mode = LineChartDataSet.Mode.linear
        actualLineChartDataSet.lineWidth = 6.0
        actualLineChartDataSet.setColor(UIColor(red:0.97, green:0.91, blue:0.11, alpha:1.0))
        actualLineChartDataSet.drawCirclesEnabled = false
//        actualLineChartDataSet.drawFilledEnabled = true
        
        actualLineChartDataSet.drawValuesEnabled = false
//        actualLineChartDataSet.fillColor = UIColor(red:0.97, green:0.91, blue:0.11, alpha:1.0)
//        actualLineChartDataSet.fillAlpha = 1.0
        
        var dataSets : [LineChartDataSet] = [LineChartDataSet]()
        dataSets.append(actualLineChartDataSet)
        dataSets.append(planLineChartDataSet)
        
        let omzetLineChartData = LineChartData(dataSets: dataSets)
        dashboardChart.setChartData(chartData: omzetLineChartData, xValues: months)
        
    }
    
    private func initChartScrollView() {
        self.chartScrollView.delegate = self
    }
    
    private func initPageControl() {
        pageControl.addTarget(self, action: #selector(self.changePage(_:)), for: UIControlEvents.valueChanged)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = Int(pageNumber)
    }
    
    @objc func changePage(_ sender: AnyObject) -> () {
        let x = CGFloat(pageControl.currentPage) * chartScrollView.frame.size.width
        chartScrollView.setContentOffset(CGPoint(x: x, y: 0), animated: true)
    }
}
