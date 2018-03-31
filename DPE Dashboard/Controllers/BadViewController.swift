//
//  BadViewController.swift
//  DPE Dashboard
//
//  Created by Muhammad Yusuf on 1/1/18.
//  Copyright © 2018 Department Power Plant & Energy. All rights reserved.
//

import UIKit
import Charts
import SwiftSpinner

class BadViewController: UIViewController, MonthYearPickerDelegate, MonthSliderDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var selectedMonth: Int?
    var selectedYear: Int?
    let SHOW_MONTH_YEAR_PICKER_SEGUE = "ShowMonthYearPickerSegue"
    
    let decimalFormatter = NumberFormatter()
    @IBOutlet weak var badChart: BarChartView!
    @IBOutlet weak var monthYearLabel: UIButton!
    
    @IBOutlet weak var scrollPageContainer: UIView!
    @IBOutlet weak var monthScrollView: UIScrollView!
    @IBOutlet weak var monthSlider: MonthSlider!
    @IBOutlet weak var mainBackground: UIImageView!
    @IBOutlet weak var badTableView: UITableView!
    var bads = [BadData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initFormatter()
        initMonthSlider(initMonth: self.selectedMonth!)
        initChart()
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
    
    private func initMonthSlider(initMonth: Int) {
        monthSlider.delegate = self
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
    
    func monthSelected(month: Int) {
        self.selectedMonth = month
        updateDashboardState()
    }
    
    private func initChart() {
        badChart.backgroundColor = UIColor(red:0.22, green:0.40, blue:0.71, alpha:1.0)
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
        updateMonthScrollView()
        updateMonthSlider()
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
        SwiftSpinner.show("Loading data...").addTapHandler({
            SwiftSpinner.hide()
        }, subtitle: "")
        
        self.bads = []
        self.badTableView.reloadData()
        
        badChart.clear()
        
        DashboardService.getBadData(year: self.selectedYear!, month: self.selectedMonth!) { status, badDatas in
            
            SwiftSpinner.hide()
            
            if (status == 403) {
                let alertView = UIAlertController(title: "Fetch data error",
                                                  message: "Session expired" as String, preferredStyle:.alert)
                SwiftSpinner.hide()
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertView.addAction(okAction)
                self.present(alertView, animated: true, completion: nil)
            } else if (status == -1) {
                let alertView = UIAlertController(title: "Fetch data error",
                                                  message: "Connection error" as String, preferredStyle:.alert)
                SwiftSpinner.hide()
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertView.addAction(okAction)
                self.present(alertView, animated: true, completion: nil)
            } else if (status == 200) {
                self.bads = badDatas!
                self.badTableView.reloadData()
                var projectNames = [String]()
                var tagihanBrutoValues = [Double]()
                var piutangUsahaValues = [Double]()
                var piutangRetensiValues = [Double]()
                var pdpValues = [Double]()
                var badValues = [Double]()
                for badData in badDatas! {
                    projectNames.append(badData.projectCode)
                    tagihanBrutoValues.append(badData.tagihanBruto)
                    piutangUsahaValues.append(badData.piutangUsaha)
                    piutangRetensiValues.append(badData.piutangRetensi)
                    pdpValues.append(badData.pdp)
                    badValues.append(badData.bad)
                }
                
                self.setDataChart(months: Constant.months, projectNames: projectNames, tagihanBrutoValues: tagihanBrutoValues, piutangUsahaValues: piutangUsahaValues, piutangRetensiValues: piutangRetensiValues, pdpValues: pdpValues, badValues: badValues)
            }
        }
    }
    
    private func setDataChart(months: [String], projectNames: [String], tagihanBrutoValues: [Double], piutangUsahaValues: [Double], piutangRetensiValues: [Double], pdpValues: [Double], badValues: [Double]) {
        
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
        
        var piutangRetensiDataEntries: [BarChartDataEntry] = []
        for i in 0..<piutangRetensiValues.count {
            piutangRetensiDataEntries.append(BarChartDataEntry(x: Double(i), y: piutangRetensiValues[i]))
        }
        let piutangRetensiDataSet = BarChartDataSet(values: piutangRetensiDataEntries, label: "Piutang Retensi")
        piutangRetensiDataSet.drawValuesEnabled = false
        piutangRetensiDataSet.setColor(UIColor(red:0.29, green:0.63, blue:0.13, alpha:1.0))
        
        var pdpDataEntries: [BarChartDataEntry] = []
        for i in 0..<pdpValues.count {
            pdpDataEntries.append(BarChartDataEntry(x: Double(i), y: pdpValues[i]))
        }
        let pdpDataSet = BarChartDataSet(values: pdpDataEntries, label: "PDP")
        pdpDataSet.drawValuesEnabled = false
        pdpDataSet.setColor(UIColor(red:0.59, green:0.13, blue:0.13, alpha:1.0))
        
        var badDataEntries: [BarChartDataEntry] = []
        for i in 0..<badValues.count {
            badDataEntries.append(BarChartDataEntry(x: Double(i), y: badValues[i]))
        }
        let badDataSet = BarChartDataSet(values: badDataEntries, label: "BAD")
        badDataSet.drawValuesEnabled = false
        badDataSet.setColor(UIColor(red:0.59, green:0.63, blue:0.43, alpha:1.0))
        
        var dataSets : [BarChartDataSet] = [BarChartDataSet]()
        dataSets.append(tagihanBrutoDataSet)
        dataSets.append(piutangUsahaDataSet)
        dataSets.append(piutangRetensiDataSet)
        dataSets.append(pdpDataSet)
        dataSets.append(badDataSet)
        
        let barChartData = BarChartData(dataSets: dataSets)
        
//        let groupSpace = 0.3
//        let barSpace = 0.05
//        let barWidth = 0.3
        
        let groupSpace = 0.05
        let barSpace = 0.02
        let barWidth = 0.17
        let groupCount = projectNames.count
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
        xAxis.valueFormatter = BarChartFormatter(projectNames: projectNames)
        
        leftAxis.enabled = false
//        leftAxis.spaceBottom = 1
//        leftAxis.spaceTop = 30.0
        leftAxis.axisMinimum = 0.0
//        leftAxis.valueFormatter = BarChartFormatter()
        
        rightAxis.enabled = false
        
        let marker:BalloonMarker = BalloonMarker(color: UIColor.white, font: UIFont(name: "Helvetica", size: 12)!, textColor: UIColor.black, insets: UIEdgeInsets(top: 7.0, left: 7.0, bottom: 7.0, right: 7.0))
        marker.minimumSize = CGSize(width: 75.0, height: 35.0)
        badChart.marker = marker
        
        badChart.data = barChartData
    }
    
    private func initTableView() {
        badTableView.delegate = self
        badTableView.dataSource = self
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.bads.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 210.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BadTableViewCell") as! BadTableViewCell
        let bad = self.bads[indexPath.row]
        cell.projectName.text = bad.projectName
        cell.piutangUsahaLabel.text = self.decimalFormatter.string(from: NSNumber(value: bad.piutangUsaha))
        cell.tagihanBrutoLabel.text = self.decimalFormatter.string(from: NSNumber(value: bad.tagihanBruto))
        cell.piutangRetensiLabel.text = self.decimalFormatter.string(from: NSNumber(value: bad.piutangRetensi))
        cell.pdpLabel.text = self.decimalFormatter.string(from: NSNumber(value: bad.pdp))
        cell.badLabel.text = self.decimalFormatter.string(from: NSNumber(value: bad.bad))
        return cell
    }
}
