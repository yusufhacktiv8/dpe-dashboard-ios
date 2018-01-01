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
        
    }
    
    private func setDataChart(months: [String], tagihanBrutoValues: [Double], piutangUsahaValues: [Double]) {
        var tagihanBrutoDataEntries: [BarChartDataEntry] = []
        
        for i in 0..<months.count {
            if (i < tagihanBrutoValues.count) {
                tagihanBrutoDataEntries.append(BarChartDataEntry(x: Double(i), y: tagihanBrutoValues[i]))
            }
        }
        
        let tagihanBrutoDataSet = BarChartDataSet(values: tagihanBrutoDataEntries, label: "Tagihan Bruto")
        
        tagihanBrutoDataSet.drawValuesEnabled = false
        
        //        tagihanBrutoDataSet.barSpace = 0.5
        
        var piutangUsahaDataEntries: [BarChartDataEntry] = []
        
        for i in 0..<months.count {
            if(i < piutangUsahaValues.count){
                piutangUsahaDataEntries.append(BarChartDataEntry(x: Double(i), y: piutangUsahaValues[i]))
            }
        }
        
        let piutangUsahaDataSet = BarChartDataSet(values: piutangUsahaDataEntries, label: "Piutang Usaha")
        piutangUsahaDataSet.drawValuesEnabled = false
        piutangUsahaDataSet.setColor(UIColor(red:0.49, green:0.83, blue:0.13, alpha:1.0))
        
        var dataSets : [BarChartDataSet] = [BarChartDataSet]()
        dataSets.append(tagihanBrutoDataSet)
        dataSets.append(piutangUsahaDataSet)
        
        let barChartData = BarChartData(dataSets: dataSets) // BarChartData(xVals: months, dataSets: dataSets)
        
        badChart.leftAxis.spaceBottom = 1
        
        //        badChart.xAxis.labelPosition = .Top
        badChart.chartDescription?.text = ""
        badChart.pinchZoomEnabled = true
        //
        badChart.drawBordersEnabled = false
        badChart.rightAxis.enabled = false
        
        badChart.xAxis.gridColor = UIColor.lightGray
        badChart.legend.enabled = false
        
        badChart.xAxis.labelTextColor = UIColor.white
        badChart.xAxis.drawAxisLineEnabled = false
        
        badChart.leftAxis.enabled = false
        
        badChart.setViewPortOffsets(left: 20, top: 15, right: 20, bottom: 0)
        
        //        badChart.leftAxis.axisMaxValue = 1000
        badChart.drawBarShadowEnabled = false
        
        badChart.data = barChartData
    }
}
