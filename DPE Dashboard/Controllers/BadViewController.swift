//
//  BadViewController.swift
//  DPE Dashboard
//
//  Created by Muhammad Yusuf on 1/1/18.
//  Copyright © 2018 Department Power Plant & Energy. All rights reserved.
//

import UIKit
import Charts

class BadViewController: UIViewController, MonthYearPickerDelegate {
    
    var selectedMonth: Int?
    var selectedYear: Int?
    let SHOW_MONTH_YEAR_PICKER_SEGUE = "ShowMonthYearPickerSegue"
    
    let decimalFormatter = NumberFormatter()
    @IBOutlet weak var badChart: BarChartView!
    @IBOutlet weak var monthYearLabel: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        initFormatter()
        updateDashboardState()
    }

    private func showFilter() {
        performSegue(withIdentifier: SHOW_MONTH_YEAR_PICKER_SEGUE, sender: self)
    }
    
    private func setMonthYearLabel() {
        self.monthYearLabel.setTitle("\(Constant.months[self.selectedMonth! - 1]), \(self.selectedYear!)", for: .normal)
    }
    
    private func initFormatter() {
        self.decimalFormatter.numberStyle = NumberFormatter.Style.decimal
        self.decimalFormatter.minimumFractionDigits = 2
        self.decimalFormatter.maximumFractionDigits = 2
    }

    @IBAction func monthYearLabelDidTouch(_ sender: Any) {
        showFilter()
    }
    
    func monthYearSelected(month: Int, year: Int) {
        self.selectedMonth = month
        self.selectedYear = year
        updateDashboardState()
    }
    
    private func updateDashboardState() {
        setMonthYearLabel()
        updateChartData()
//        updateDashboardDetails()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == SHOW_MONTH_YEAR_PICKER_SEGUE) {
            let destinationVC  = segue.destination as? MonthYearPickerViewController
            destinationVC?.selectedYear = self.selectedYear
            destinationVC?.selectedMonth = self.selectedMonth
            destinationVC?.delegate = self
        }
    }
    
    private func updateChartData() {
        DashboardService.getBadData(year: self.selectedYear!, month: self.selectedMonth!) { badDatas in
            var tagihanBrutoValues = [Double]()
            var piutangUsahaValues = [Double]()
            for badData in badDatas {
                tagihanBrutoValues.append(badData.tagihanBruto)
                piutangUsahaValues.append(badData.piutangUsaha)
            }
            
            self.setDataChart(months: Constant.months, tagihanBrutoValues: tagihanBrutoValues, piutangUsahaValues: piutangUsahaValues)
        }
    }
    
    private func setDataChart(months: [String], tagihanBrutoValues: [Double], piutangUsahaValues: [Double]) {
        var tagihanBrutoDataEntries: [BarChartDataEntry] = []
        
        for i in 0..<tagihanBrutoValues.count {
            tagihanBrutoDataEntries.append(BarChartDataEntry(x: Double(i), y: tagihanBrutoValues[i]))
        }
        
        let tagihanBrutoDataSet = BarChartDataSet(values: tagihanBrutoDataEntries, label: "Tagihan Bruto")
        
        tagihanBrutoDataSet.drawValuesEnabled = false
        
        var piutangUsahaDataEntries: [BarChartDataEntry] = []
        
        for i in 0..<piutangUsahaValues.count {
            piutangUsahaDataEntries.append(BarChartDataEntry(x: Double(i), y: piutangUsahaValues[i]))
        }
        
        let piutangUsahaDataSet = BarChartDataSet(values: piutangUsahaDataEntries, label: "Piutang Usaha")
        piutangUsahaDataSet.drawValuesEnabled = false
        piutangUsahaDataSet.setColor(UIColor(red:0.49, green:0.83, blue:0.13, alpha:1.0))
        
        var dataSets : [BarChartDataSet] = [BarChartDataSet]()
        dataSets.append(tagihanBrutoDataSet)
        dataSets.append(piutangUsahaDataSet)
        
        let barChartData = BarChartData(dataSets: dataSets)
        
        let groupSpace = 0.3
        let barSpace = 0.05
        let barWidth = 0.3
        let groupCount = 1
        let start = 0
        
        barChartData.barWidth = barWidth;
        barChartData.groupBars(fromX: Double(start), groupSpace: groupSpace, barSpace: barSpace)
        
        badChart.chartDescription?.text = ""
        badChart.pinchZoomEnabled = true
        badChart.drawBordersEnabled = false
        badChart.legend.enabled = false
        badChart.drawBarShadowEnabled = false
        badChart.backgroundColor = UIColor(red:0.22, green:0.40, blue:0.71, alpha:1.0)
        badChart.setViewPortOffsets(left: 20, top: 15, right: 20, bottom: 0)
        
        let xAxis = badChart.xAxis
        let leftAxis = badChart.leftAxis
        let rightAxis = badChart.rightAxis
        
        xAxis.axisMinimum = Double(start)
        let gg = barChartData.groupWidth(groupSpace: groupSpace, barSpace: barSpace)
        xAxis.axisMaximum = Double(start) + gg * Double(groupCount)
        xAxis.labelPosition = .topInside
        xAxis.gridColor = UIColor.lightGray
        xAxis.labelTextColor = UIColor.white
        xAxis.drawAxisLineEnabled = false
        
        xAxis.granularity = 1.0
        xAxis.centerAxisLabelsEnabled = true
        xAxis.valueFormatter = BarChartFormatter()
        
        leftAxis.enabled = false
//        leftAxis.spaceBottom = 1
//        leftAxis.spaceTop = 30.0
        leftAxis.axisMinimum = -0.01
//        leftAxis.valueFormatter = BarChartFormatter()
        
        rightAxis.enabled = false
        
        badChart.data = barChartData
    }
}
