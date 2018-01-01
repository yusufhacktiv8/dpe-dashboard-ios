//
//  MainViewController.swift
//  DPE Dashboard
//
//  Created by Muhammad Yusuf on 12/26/17.
//  Copyright © 2017 Department Power Plant & Energy. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, MonthYearPickerDelegate, MonthSliderDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var selectedMonth: Int = Constant.defaultMonth
    var selectedYear: Int = Constant.defaultYear
    let SHOW_MONTH_YEAR_PICKER_SEGUE = "ShowMonthYearPickerSegue"
    let BAD_SEGUE = "BadSegue"
    
    @IBOutlet weak var chartContainer: UIView!
    @IBOutlet weak var scrollPageContainer: UIView!
    @IBOutlet weak var monthYearLabel: UIButton!
    @IBOutlet weak var monthScrollView: UIScrollView!
    @IBOutlet weak var monthSlider: MonthSlider!
    @IBOutlet weak var tableView: UITableView!
    
    var chartViewController: ChartViewController?
    
    let decimalFormatter = NumberFormatter()
    let numberFormatter = NumberFormatter()
    var dashboardDetails = [DashboardDetail]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initFormatter()
        initMonthYear()
        initChartView()
        initMonthSlider(initMonth: self.selectedMonth)
        initTableView()
        updateDashboardState()
    }

    private func showFilter() {
        performSegue(withIdentifier: SHOW_MONTH_YEAR_PICKER_SEGUE, sender: self)
    }
    
    @IBAction func searchButtonDidTouch(_ sender: Any) {
        showFilter()
    }
    
    private func setMonthYearLabel() {
        self.monthYearLabel.setTitle("\(Constant.months[self.selectedMonth - 1]), \(self.selectedYear)", for: .normal)
    }
    
    func monthYearSelected(month: Int, year: Int) {
        self.selectedMonth = month
        self.selectedYear = year
        updateDashboardState()
    }
    
    func monthSelected(month: Int) {
        self.selectedMonth = month
        updateDashboardState()
    }
    
    func updateMonthScrollView() {
        var currentPage = 1
        if(self.selectedMonth > 6){
            currentPage = 2
        }
        let x = CGFloat(currentPage - 1) * self.monthScrollView.frame.size.width
        self.monthScrollView.setContentOffset(CGPoint(x: x, y: 0), animated: true)
    }
    
    private func updateMonthSlider() {
        monthSlider.selectMonth(month: self.selectedMonth)
    }
    
    private func updateDashboardState() {
        setMonthYearLabel()
        updateMonthScrollView()
        updateMonthSlider()
        updateChartViewController()
        updateDashboardDetails()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == SHOW_MONTH_YEAR_PICKER_SEGUE) {
            let destinationVC  = segue.destination as? MonthYearPickerViewController
            destinationVC?.selectedYear = self.selectedYear
            destinationVC?.selectedMonth = self.selectedMonth
            destinationVC?.delegate = self
        } else if (segue.identifier == BAD_SEGUE) {
            let destinationVC  = segue.destination as? BadViewController
            destinationVC?.selectedYear = self.selectedYear
            destinationVC?.selectedMonth = self.selectedMonth
        }
    }
    
    @IBAction func monthYearButtonDidSelect(_ sender: Any) {
        showFilter()
    }
    
    private func initMonthYear() {
        let date = Date()
        let calendar = Calendar.current
        
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        
        self.selectedMonth = month
        self.selectedYear = year
    }
    
    private func initMonthSlider(initMonth: Int) {
        monthSlider.delegate = self
    }
    
    private func initFormatter() {
        self.decimalFormatter.numberStyle = NumberFormatter.Style.decimal
        self.decimalFormatter.minimumFractionDigits = 2
        self.decimalFormatter.maximumFractionDigits = 2
        
        self.numberFormatter.numberStyle = NumberFormatter.Style.decimal
        self.numberFormatter.minimumFractionDigits = 0
        self.numberFormatter.maximumFractionDigits = 0
    }
    
    private func initChartView() {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        let chartViewController = storyboard.instantiateViewController(withIdentifier: "chartViewController") as! ChartViewController
        
        chartContainer.addSubview(chartViewController.view)
//        chartViewController.view.frame = chartContainer.bounds
        chartViewController.view.frame = CGRect(x: 0, y: 0, width: chartContainer.bounds.size.width, height: chartContainer.bounds.size.height)
//        chartViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        chartViewController.didMove(toParentViewController: self)
        
        self.chartViewController = chartViewController
    }
    
    private func updateChartViewController() {
        if let chartViewController = self.chartViewController {
            chartViewController.loadData(year: self.selectedYear, month: self.selectedMonth)
        }
    }
    
    private func updateDashboardDetails() {
        DashboardService.getDashboardDetailsData(year: self.selectedYear, month: self.selectedMonth) { dashboardDetails in
            self.dashboardDetails.removeAll()
            self.dashboardDetails = dashboardDetails
            self.tableView.reloadData()
        }
    }
    
    private func initTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.row == 2) {
            return 48.0
        }
        return 150.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "FirstTableViewCell") as! FirstTableViewCell
            if (dashboardDetails.count > 2) {
                var dashboardDetail1 = dashboardDetails[0]
                let rkapOk = dashboardDetail1.ok
                let rkapOp = dashboardDetail1.op
                let rkapLsp = dashboardDetail1.lsp
                cell.rkapOkLabel.text = decimalFormatter.string(from: NSNumber(value: rkapOk))
                cell.rkapOpLabel.text = decimalFormatter.string(from: NSNumber(value: rkapOp))
                cell.rkapLspLabel.text = decimalFormatter.string(from: NSNumber(value: rkapLsp))
                
                dashboardDetail1 = dashboardDetails[1]
                let riOk = dashboardDetail1.ok
                let riOp = dashboardDetail1.op
                let riLsp = dashboardDetail1.lsp
                cell.riOkLabel.text = decimalFormatter.string(from: NSNumber(value: riOk))
                cell.riOpLabel.text = decimalFormatter.string(from: NSNumber(value: riOp))
                cell.riLspLabel.text = decimalFormatter.string(from: NSNumber(value: riLsp))
                
                dashboardDetail1 = dashboardDetails[2]
                let progOk = dashboardDetail1.ok
                let progOp = dashboardDetail1.op
                let progLsp = dashboardDetail1.lsp
                cell.progOkLabel.text = decimalFormatter.string(from: NSNumber(value: progOk))
                cell.progOpLabel.text = decimalFormatter.string(from: NSNumber(value: progOp))
                cell.progLspLabel.text = decimalFormatter.string(from: NSNumber(value: progLsp))
            } else {
                cell.rkapOkLabel.text = "-"
                cell.rkapOpLabel.text = "-"
                cell.rkapLspLabel.text = "-"
                
                cell.riOkLabel.text = "-"
                cell.riOpLabel.text = "-"
                cell.riLspLabel.text = "-"
                
                cell.progOkLabel.text = "-"
                cell.progOpLabel.text = "-"
                cell.progLspLabel.text = "-"
            }
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SecondTableViewCell") as! SecondTableViewCell
            cell.titleLabel.text = "Sisa"
            var dashboardDetail2: DashboardDetail?
            if (dashboardDetails.count > 3) {
                dashboardDetail2 = dashboardDetails[3]
            }
            setDetailLabels(dashboardDetail: dashboardDetail2, cell: cell)
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ThirdTableViewCell") as! ThirdTableViewCell
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SecondTableViewCell") as! SecondTableViewCell
            var dashboardDetail3: DashboardDetail?
            if (dashboardDetails.count > 4) {
                dashboardDetail3 = dashboardDetails[4]
            }
            setDetailLabels(dashboardDetail: dashboardDetail3, cell: cell)
            cell.titleLabel.text = "OK Lama"
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SecondTableViewCell") as! SecondTableViewCell
            cell.titleLabel.text = "OK Baru (Sudah Didapat)"
            var dashboardDetail4: DashboardDetail?
            if (dashboardDetails.count > 4) {
                dashboardDetail4 = dashboardDetails[4]
            }
            setDetailLabels(dashboardDetail: dashboardDetail4, cell: cell)
            return cell
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SecondTableViewCell") as! SecondTableViewCell
            cell.titleLabel.text = "OK Baru (Dalam Pengusahaan)"
            var dashboardDetail5: DashboardDetail?
            if (dashboardDetails.count > 6) {
                dashboardDetail5 = dashboardDetails[6]
            }
            setDetailLabels(dashboardDetail: dashboardDetail5, cell: cell)
            return cell
        case 6:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SecondTableViewCell") as! SecondTableViewCell
            cell.titleLabel.text = "Lain - lain"
            var dashboardDetail6: DashboardDetail?
            if (dashboardDetails.count > 7) {
                dashboardDetail6 = dashboardDetails[7]
            }
            setDetailLabels(dashboardDetail: dashboardDetail6, cell: cell)
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SecondTableViewCell") as! SecondTableViewCell
            return cell
        }
    }
    
    private func setDetailLabels(dashboardDetail: DashboardDetail?, cell: SecondTableViewCell) {
        if let detail = dashboardDetail {
            let ok = detail.ok
            let op = detail.op
            let lsp = detail.lsp
            cell.okLabel.text = decimalFormatter.string(from: NSNumber(value: ok))
            cell.opLabel.text = decimalFormatter.string(from: NSNumber(value: op))
            cell.lspLabel.text = decimalFormatter.string(from: NSNumber(value: lsp))
        } else {
            cell.okLabel.text = "-"
            cell.opLabel.text = "-"
            cell.lspLabel.text = "-"
        }
    }
    @IBAction func onMenuButtonDidTouch(_ sender: Any) {
        performSegue(withIdentifier: "BadSegue", sender: self)
    }
    
}

extension UIViewController {
    func performSegueToReturnBack()  {
        if let nav = self.navigationController {
            nav.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
}
