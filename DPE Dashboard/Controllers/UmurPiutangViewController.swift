//
//  UmurPiutangViewController.swift
//  DPE Dashboard
//
//  Created by Muhammad Yusuf on 1/2/18.
//  Copyright © 2018 Department Power Plant & Energy. All rights reserved.
//

import UIKit
import Charts
import SwiftSpinner

class UmurPiutangViewController: UIViewController, MonthYearPickerDelegate, MonthSliderDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var selectedMonth: Int?
    var selectedYear: Int?
    let SHOW_MONTH_YEAR_PICKER_SEGUE = "ShowMonthYearPickerSegue"
    
    let decimalFormatter = NumberFormatter()

    @IBOutlet weak var upChart: BarChartView!
    @IBOutlet weak var monthYearLabel: UIButton!
    
    @IBOutlet weak var monthScrollView: UIScrollView!
    @IBOutlet weak var monthSlider: MonthSlider!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var mainBackground: UIImageView!
    
    var totalRow = 0
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initFormatter()
        initMonthSlider(initMonth: self.selectedMonth!)
        initTableView()
        updateDashboardState()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        initLoginBackground()
    }
    
    private func initLoginBackground() {
        let url = URL(string: DashboardConstant.BASE_URL + "/images/view/BACKGROUND")
        
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            DispatchQueue.main.async {
                if let tempData = data {
                    self.mainBackground.image = UIImage(data: tempData)
                }
            }
        }
    }
    
    private func initFormatter() {
        self.decimalFormatter.numberStyle = NumberFormatter.Style.decimal
        self.decimalFormatter.minimumFractionDigits = 2
        self.decimalFormatter.maximumFractionDigits = 2
    }
    
    private func initMonthSlider(initMonth: Int) {
        monthSlider.delegate = self
    }
    
    func monthSelected(month: Int) {
        self.selectedMonth = month
        updateDashboardState()
    }
    
    private func updateMonthSlider() {
        monthSlider.selectMonth(month: self.selectedMonth!)
    }
    
    func updateMonthScrollView() {
        var currentPage = 1
        if(self.selectedMonth! > 6){
            currentPage = 2
        }
        let x = CGFloat(currentPage - 1) * self.monthScrollView.frame.size.width
        self.monthScrollView.setContentOffset(CGPoint(x: x, y: 0), animated: true)
    }
    
    private func updateDashboardState() {
        setMonthYearLabel()
        updateChartData()
        updateMonthSlider()
        updateMonthScrollView()
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
        
        SwiftSpinner.show("Loading data...").addTapHandler({
            SwiftSpinner.hide()
        }, subtitle: "")
        
        totalRow = 0
        self.tableView.reloadData()
        upChart.clear()
        
        DashboardService.getUmurPiutangData(year: self.selectedYear!, month: self.selectedMonth!) { status, upDatas in
            
            SwiftSpinner.hide()
            
            if (status == 403) {
                let alertView = UIAlertController(title: "Fetch data error",
                                                  message: "Session expired" as String, preferredStyle:.alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertView.addAction(okAction)
                self.present(alertView, animated: true, completion: nil)
            } else if (status == -1) {
                let alertView = UIAlertController(title: "Fetch data error",
                                                  message: "Connection error" as String, preferredStyle:.alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertView.addAction(okAction)
                self.present(alertView, animated: true, completion: nil)
            } else if (status == 200) {
                self.totalRow = 4
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
                
                for upData in upDatas! {
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
                
                self.totalPdp1 = totalPdp1
                self.totalPdp2 = totalPdp2
                self.totalPdp3 = totalPdp3
                self.totalPdp4 = totalPdp4
                self.totalPdp5 = totalPdp5
                
                self.totalTagihanBruto1 = totalTagihanBruto1
                self.totalTagihanBruto2 = totalTagihanBruto2
                self.totalTagihanBruto3 = totalTagihanBruto3
                self.totalTagihanBruto4 = totalTagihanBruto4
                self.totalTagihanBruto5 = totalTagihanBruto5
                
                self.totalPiutangUsaha1 = totalPiutangUsaha1
                self.totalPiutangUsaha2 = totalPiutangUsaha2
                self.totalPiutangUsaha3 = totalPiutangUsaha3
                self.totalPiutangUsaha4 = totalPiutangUsaha4
                self.totalPiutangUsaha5 = totalPiutangUsaha5
                
                self.totalPiutangRetensi1 = totalPiutangRetensi1
                self.totalPiutangRetensi2 = totalPiutangRetensi2
                self.totalPiutangRetensi3 = totalPiutangRetensi3
                self.totalPiutangRetensi4 = totalPiutangRetensi4
                self.totalPiutangRetensi5 = totalPiutangRetensi5
                self.tableView.reloadData()
                
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
        firstDataSet.drawValuesEnabled = false
        firstDataSet.setColor(UIColor(red:0.49, green:0.83, blue:0.13, alpha:1.0))
        
        let secondDataSet = BarChartDataSet(values: secondDataEntries, label: "Second")
        secondDataSet.drawValuesEnabled = false
        secondDataSet.setColor(UIColor(red:0.57, green:0.91, blue:1.00, alpha:1.0))
        
        let thirdDataSet = BarChartDataSet(values: thirdDataEntries, label: "Third")
        thirdDataSet.drawValuesEnabled = false
        thirdDataSet.setColor(UIColor(red:0.58, green:0.22, blue:1.00, alpha:1.0))
        
        let fourthDataSet = BarChartDataSet(values: fourthDataEntries, label: "Fourth")
        fourthDataSet.drawValuesEnabled = false
        fourthDataSet.setColor(UIColor(red:0.45, green:0.22, blue:1.00, alpha:1.0))
        
        let fifthDataSet = BarChartDataSet(values: fifthDataEntries, label: "Fifth")
        fifthDataSet.drawValuesEnabled = false
        fifthDataSet.setColor(UIColor(red:0.13, green:0.10, blue:1.00, alpha:1.0))
        
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
        leftAxis.spaceBottom = 1
//        leftAxis.spaceTop = 30.0
        leftAxis.axisMinimum = 0.0
        
        rightAxis.enabled = false
        
        let marker:BalloonMarker = BalloonMarker(color: UIColor.white, font: UIFont(name: "Helvetica", size: 12)!, textColor: UIColor.black, insets: UIEdgeInsets(top: 7.0, left: 7.0, bottom: 7.0, right: 7.0))
        marker.minimumSize = CGSize(width: 75.0, height: 35.0)
        upChart.marker = marker
        
        upChart.data = barChartData
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == SHOW_MONTH_YEAR_PICKER_SEGUE) {
            let destinationVC  = segue.destination as? MonthYearPickerViewController
            destinationVC?.selectedYear = self.selectedYear
            destinationVC?.selectedMonth = self.selectedMonth
            destinationVC?.delegate = self
        }
    }
    
    func monthYearSelected(month: Int, year: Int) {
        self.selectedMonth = month
        self.selectedYear = year
        updateDashboardState()
    }
    
    private func initTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.totalRow
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 290.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UmurPiutangTableViewCell") as! UmurPiutangTableViewCell
        
        switch (indexPath.row) {
        case 0:
            cell.titleLabel.text = "PDP"
            let totalPdp = self.totalPdp1 + self.totalPdp2 + self.totalPdp3 + self.totalPdp4 + self.totalPdp5
            cell.label1.text = decimalFormatter.string(from: NSNumber(value: self.totalPdp1))
            cell.label2.text = decimalFormatter.string(from: NSNumber(value: self.totalPdp2))
            cell.label3.text = decimalFormatter.string(from: NSNumber(value: self.totalPdp3))
            cell.label4.text = decimalFormatter.string(from: NSNumber(value: self.totalPdp4))
            cell.label5.text = decimalFormatter.string(from: NSNumber(value: self.totalPdp5))
            cell.totalLabel.text = decimalFormatter.string(from: NSNumber(value: totalPdp))
        case 1:
            cell.titleLabel.text = "Tagihan Bruto"
            let totalTagihanBruto = self.totalTagihanBruto1 + self.totalTagihanBruto2 + self.totalTagihanBruto3 + self.totalTagihanBruto4 + self.totalTagihanBruto5
            cell.label1.text = decimalFormatter.string(from: NSNumber(value: self.totalTagihanBruto1))
            cell.label2.text = decimalFormatter.string(from: NSNumber(value: self.totalTagihanBruto2))
            cell.label3.text = decimalFormatter.string(from: NSNumber(value: self.totalTagihanBruto3))
            cell.label4.text = decimalFormatter.string(from: NSNumber(value: self.totalTagihanBruto4))
            cell.label5.text = decimalFormatter.string(from: NSNumber(value: self.totalTagihanBruto5))
            cell.totalLabel.text = decimalFormatter.string(from: NSNumber(value: totalTagihanBruto))
        case 2:
            cell.titleLabel.text = "Piutang Usaha"
            let totalPiutangUsaha = self.totalPiutangUsaha1 + self.totalPiutangUsaha2 + self.totalPiutangUsaha3 + self.totalPiutangUsaha4 + self.totalPiutangUsaha5
            cell.label1.text = decimalFormatter.string(from: NSNumber(value: self.totalPiutangUsaha1))
            cell.label2.text = decimalFormatter.string(from: NSNumber(value: self.totalPiutangUsaha2))
            cell.label3.text = decimalFormatter.string(from: NSNumber(value: self.totalPiutangUsaha3))
            cell.label4.text = decimalFormatter.string(from: NSNumber(value: self.totalPiutangUsaha4))
            cell.label5.text = decimalFormatter.string(from: NSNumber(value: self.totalPiutangUsaha5))
            cell.totalLabel.text = decimalFormatter.string(from: NSNumber(value: totalPiutangUsaha))
        case 3:
            cell.titleLabel.text = "Piutang Retensi"
            let totalPiutangRetensi = self.totalPiutangRetensi1 + self.totalPiutangRetensi2 + self.totalPiutangRetensi3 + self.totalPiutangRetensi4 + self.totalPiutangRetensi5
            cell.label1.text = decimalFormatter.string(from: NSNumber(value: self.totalPiutangRetensi1))
            cell.label2.text = decimalFormatter.string(from: NSNumber(value: self.totalPiutangRetensi2))
            cell.label3.text = decimalFormatter.string(from: NSNumber(value: self.totalPiutangRetensi3))
            cell.label4.text = decimalFormatter.string(from: NSNumber(value: self.totalPiutangRetensi4))
            cell.label5.text = decimalFormatter.string(from: NSNumber(value: self.totalPiutangRetensi5))
            cell.totalLabel.text = decimalFormatter.string(from: NSNumber(value: totalPiutangRetensi))
        default:
            cell.titleLabel.text = "-"
        }
        
        return cell
    }

}
