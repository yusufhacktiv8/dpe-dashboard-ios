//
//  UmurPiutangViewController.swift
//  DPE Dashboard
//
//  Created by Muhammad Yusuf on 1/2/18.
//  Copyright © 2018 Department Power Plant & Energy. All rights reserved.
//

import UIKit
import Charts

class UmurPiutangViewController: UIViewController {
    
    var selectedMonth: Int?
    var selectedYear: Int?
    let SHOW_MONTH_YEAR_PICKER_SEGUE = "ShowMonthYearPickerSegue"
    
    let decimalFormatter = NumberFormatter()

    @IBOutlet weak var upChart: BarChartView!
    @IBOutlet weak var monthYearLabel: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        initFormatter()
        updateDashboardState()
    }
    
    private func initFormatter() {
        self.decimalFormatter.numberStyle = NumberFormatter.Style.decimal
        self.decimalFormatter.minimumFractionDigits = 2
        self.decimalFormatter.maximumFractionDigits = 2
    }
    
    private func updateDashboardState() {
        setMonthYearLabel()
        updateChartData()
    }
    
    private func setMonthYearLabel() {
        self.monthYearLabel.setTitle("\(Constant.months[self.selectedMonth! - 1]), \(self.selectedYear!)", for: .normal)
    }
    
    private func showFilter() {
        performSegue(withIdentifier: SHOW_MONTH_YEAR_PICKER_SEGUE, sender: self)
    }

    @IBAction func monthYearLabelDidTouch(_ sender: Any) {
        showFilter()
    }
    
    private func updateChartData() {
        DashboardService.getUmurPiutangData(year: self.selectedYear!, month: self.selectedMonth!) { upDatas in
            
//            self.bads = upDatas
//            self.badTableView.reloadData()
            var firstDataEntries = [Double]()
            var secondDataEntries = [Double]()
            var thirdDataEntries = [Double]()
            var fourthDataEntries = [Double]()
            
            var totalPdp1 = 0.0
            var totalPdp2 = 0.0
            var totalPdp3 = 0.0
            var totalPdp4 = 0.0
            var totalPdp5 = 0.0
            
            var totalTagihanBruto1 = 0.0
            var totalTagihanBruto2 = 0.0
            var totalTagihanBruto3 = 0.0
            var totalTagihanBruto4 = 0.0
            var totalTagihanBruto5 = 0.0
            
            var totalPiutangUsaha1 = 0.0
            var totalPiutangUsaha2 = 0.0
            var totalPiutangUsaha3 = 0.0
            var totalPiutangUsaha4 = 0.0
            var totalPiutangUsaha5 = 0.0
            
            var totalPiutangRetensi1 = 0.0
            var totalPiutangRetensi2 = 0.0
            var totalPiutangRetensi3 = 0.0
            var totalPiutangRetensi4 = 0.0
            var totalPiutangRetensi5 = 0.0
            
            for upData in upDatas {
                totalPdp1 += upData.pdp1
                totalPdp2 += upData.pdp2
                totalPdp3 += upData.pdp3
                totalPdp4 += upData.pdp4
                totalPdp5 += upData.pdp5
                
                totalTagihanBruto1 += upData.tagihanBruto1
                totalTagihanBruto2 += upData.tagihanBruto2
                totalTagihanBruto3 += upData.tagihanBruto3
                totalTagihanBruto4 += upData.tagihanBruto4
                totalTagihanBruto5 += upData.tagihanBruto5
                
                totalPiutangUsaha1 += upData.piutangUsaha1
                totalPiutangUsaha2 += upData.piutangUsaha2
                totalPiutangUsaha3 += upData.piutangUsaha3
                totalPiutangUsaha4 += upData.piutangUsaha4
                totalPiutangUsaha5 += upData.piutangUsaha5
                
                totalPiutangRetensi1 += upData.piutangRetensi1
                totalPiutangRetensi2 += upData.piutangRetensi2
                totalPiutangRetensi3 += upData.piutangRetensi3
                totalPiutangRetensi4 += upData.piutangRetensi4
                totalPiutangRetensi5 += upData.piutangRetensi5
            }
            
            firstDataEntries.append(totalPdp1)
            firstDataEntries.append(totalPdp2)
            firstDataEntries.append(totalPdp3)
            firstDataEntries.append(totalPdp4)
            firstDataEntries.append(totalPdp5)
            
            secondDataEntries.append(totalTagihanBruto1)
            secondDataEntries.append(totalTagihanBruto2)
            secondDataEntries.append(totalTagihanBruto3)
            secondDataEntries.append(totalTagihanBruto4)
            secondDataEntries.append(totalTagihanBruto5)
            
            thirdDataEntries.append(totalPiutangUsaha1)
            thirdDataEntries.append(totalPiutangUsaha2)
            thirdDataEntries.append(totalPiutangUsaha3)
            thirdDataEntries.append(totalPiutangUsaha4)
            thirdDataEntries.append(totalPiutangUsaha5)
            
            fourthDataEntries.append(totalPiutangRetensi1)
            fourthDataEntries.append(totalPiutangRetensi2)
            fourthDataEntries.append(totalPiutangRetensi3)
            fourthDataEntries.append(totalPiutangRetensi4)
            fourthDataEntries.append(totalPiutangRetensi5)
            
            self.setDataChart(
                firstDataValues: firstDataEntries,
                secondDataValues: secondDataEntries,
                thirdDataValues: thirdDataEntries,
                fourthDataValues: fourthDataEntries
            )
        }
    }
    
    private func setDataChart(firstDataValues: [Double], secondDataValues: [Double], thirdDataValues: [Double], fourthDataValues: [Double]) {
        
        var firstDataEntries: [BarChartDataEntry] = []
        var secondDataEntries: [BarChartDataEntry] = []
        var thirdDataEntries: [BarChartDataEntry] = []
        var fourthDataEntries: [BarChartDataEntry] = []
        var fifthDataEntries: [BarChartDataEntry] = []
        
        firstDataEntries.append(BarChartDataEntry(x: Double(1), y: firstDataValues[0]))
        secondDataEntries.append(BarChartDataEntry(x: Double(1), y: firstDataValues[1]))
        thirdDataEntries.append(BarChartDataEntry(x: Double(1), y: firstDataValues[2]))
        fourthDataEntries.append(BarChartDataEntry(x: Double(1), y: firstDataValues[3]))
        fifthDataEntries.append(BarChartDataEntry(x: Double(1), y: firstDataValues[4]))
        
        firstDataEntries.append(BarChartDataEntry(x: Double(2), y: secondDataValues[0]))
        secondDataEntries.append(BarChartDataEntry(x: Double(2), y: secondDataValues[1]))
        thirdDataEntries.append(BarChartDataEntry(x: Double(2), y: secondDataValues[2]))
        fourthDataEntries.append(BarChartDataEntry(x: Double(2), y: secondDataValues[3]))
        fifthDataEntries.append(BarChartDataEntry(x: Double(2), y: secondDataValues[4]))
        
        firstDataEntries.append(BarChartDataEntry(x: Double(3), y: thirdDataValues[0]))
        secondDataEntries.append(BarChartDataEntry(x: Double(3), y: thirdDataValues[1]))
        thirdDataEntries.append(BarChartDataEntry(x: Double(3), y: thirdDataValues[2]))
        fourthDataEntries.append(BarChartDataEntry(x: Double(3), y: thirdDataValues[3]))
        fifthDataEntries.append(BarChartDataEntry(x: Double(3), y: thirdDataValues[4]))
        
        firstDataEntries.append(BarChartDataEntry(x: Double(4), y: fourthDataValues[0]))
        secondDataEntries.append(BarChartDataEntry(x: Double(4), y: fourthDataValues[1]))
        thirdDataEntries.append(BarChartDataEntry(x: Double(4), y: fourthDataValues[2]))
        fourthDataEntries.append(BarChartDataEntry(x: Double(4), y: fourthDataValues[3]))
        fifthDataEntries.append(BarChartDataEntry(x: Double(4), y: fourthDataValues[4]))
        
        let firstDataSet = BarChartDataSet(values: firstDataEntries, label: "First")
        let secondDataSet = BarChartDataSet(values: secondDataEntries, label: "Second")
        let thirdDataSet = BarChartDataSet(values: thirdDataEntries, label: "Third")
        let fourthDataSet = BarChartDataSet(values: fourthDataEntries, label: "Fourth")
        let fifthDataSet = BarChartDataSet(values: fifthDataEntries, label: "Fifth")
        
        var dataSets : [BarChartDataSet] = [BarChartDataSet]()
        dataSets.append(firstDataSet)
        dataSets.append(secondDataSet)
        dataSets.append(thirdDataSet)
        dataSets.append(fourthDataSet)
        dataSets.append(fifthDataSet)
        
        let barChartData = BarChartData(dataSets: dataSets)
        
        let groupSpace = 0.05
        let barSpace = 0.02
        let barWidth = 0.17
        let groupCount = 4
        let start = 0
        
        barChartData.barWidth = barWidth;
        barChartData.groupBars(fromX: Double(start), groupSpace: groupSpace, barSpace: barSpace)
        
        upChart.chartDescription?.text = ""
        upChart.pinchZoomEnabled = true
        upChart.drawBordersEnabled = false
        upChart.legend.enabled = false
        upChart.drawBarShadowEnabled = false
        upChart.backgroundColor = UIColor(red:0.22, green:0.40, blue:0.71, alpha:1.0)
        upChart.setViewPortOffsets(left: 20, top: 15, right: 20, bottom: 0)
        
        let xAxis = upChart.xAxis
        let leftAxis = upChart.leftAxis
        let rightAxis = upChart.rightAxis
        
        xAxis.axisMinimum = Double(start)
        let gg = barChartData.groupWidth(groupSpace: groupSpace, barSpace: barSpace)
        xAxis.axisMaximum = Double(start) + gg * Double(groupCount)
        xAxis.labelPosition = .topInside
        xAxis.gridColor = UIColor.lightGray
        xAxis.labelTextColor = UIColor.white
        xAxis.drawAxisLineEnabled = false
        
        xAxis.granularity = 1.0
        xAxis.centerAxisLabelsEnabled = true
        xAxis.valueFormatter = UpChartFormatter()
        
        leftAxis.enabled = false
        
        rightAxis.enabled = false
        
        let marker:BalloonMarker = BalloonMarker(color: UIColor.white, font: UIFont(name: "Helvetica", size: 12)!, textColor: UIColor.black, insets: UIEdgeInsets(top: 7.0, left: 7.0, bottom: 7.0, right: 7.0))
        marker.minimumSize = CGSize(width: 75.0, height: 35.0)
        upChart.marker = marker
        
        upChart.data = barChartData
    }

}
