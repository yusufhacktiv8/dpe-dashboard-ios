//
//  MainViewController.swift
//  DPE Dashboard
//
//  Created by Muhammad Yusuf on 12/26/17.
//  Copyright © 2017 Department Power Plant & Energy. All rights reserved.
//

import UIKit
import SwiftSpinner

class MainViewController: UIViewController, MonthYearPickerDelegate, MonthSliderDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var selectedMonth: Int = Constant.defaultMonth
    var selectedYear: Int = Constant.defaultYear
    
    var selectedDataType: String?
    var selectedProjectType: Int?
    let SHOW_MONTH_YEAR_PICKER_SEGUE = "ShowMonthYearPickerSegue"
    let BAD_SEGUE = "BadSegue"
    let UMUR_PIUTANG_SEGUE = "UmurPiutangSegue"
    let CASH_FLOW_SEGUE = "CashFlowSegue"
    let PROGNOSA_SEGUE = "PrognosaSegue"
    let OK_DETAILS_SEGUE = "OkDetailsSegue"
    
    @IBOutlet weak var chartContainer: UIView!
    @IBOutlet weak var scrollPageContainer: UIView!
    @IBOutlet weak var monthYearLabel: UIButton!
    @IBOutlet weak var monthScrollView: UIScrollView!
    @IBOutlet weak var monthSlider: MonthSlider!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mainBackground: UIImageView!
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
        } else if (segue.identifier == UMUR_PIUTANG_SEGUE) {
            let destinationVC  = segue.destination as? UmurPiutangViewController
            destinationVC?.selectedYear = self.selectedYear
            destinationVC?.selectedMonth = self.selectedMonth
        } else if (segue.identifier == CASH_FLOW_SEGUE) {
            let destinationVC  = segue.destination as? CashFlowViewController
            destinationVC?.selectedYear = self.selectedYear
            destinationVC?.selectedMonth = self.selectedMonth
        } else if (segue.identifier == PROGNOSA_SEGUE) {
            let destinationVC  = segue.destination as? PrognosaViewController
            destinationVC?.selectedYear = self.selectedYear
            destinationVC?.selectedMonth = self.selectedMonth
        }  else if (segue.identifier == OK_DETAILS_SEGUE) {
            let destinationVC  = segue.destination as? OkDetailsViewController
            destinationVC?.selectedYear = self.selectedYear
            destinationVC?.selectedMonth = self.selectedMonth
            destinationVC?.projectType = self.selectedProjectType
            destinationVC?.dataType = self.selectedDataType
        }
    }
    
    @IBAction func monthYearButtonDidSelect(_ sender: Any) {
        showFilter()
    }
    
    private func initMonthYear() {
        let date = Calendar.current.date(byAdding: .month, value: -1, to: Date())
        let calendar = Calendar.current
        
        let year = calendar.component(.year, from: date!)
        let month = calendar.component(.month, from: date!)
        
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
        
        SwiftSpinner.show("Loading data...").addTapHandler({
            SwiftSpinner.hide()
        }, subtitle: "")
        
        self.dashboardDetails.removeAll()
        self.tableView.reloadData()
        
        DashboardService.getDashboardDetailsData(year: self.selectedYear, month: self.selectedMonth) { status, dashboardDetails in
            
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
                self.dashboardDetails = dashboardDetails!
                self.tableView.reloadData()
            }
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
        return 190.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
    
    }
    
    func getSelectedDataTypeByTag(tag: Int) -> String {
        switch (tag) {
        case 1:
            return "OK"
        case 2:
            return "OP"
        case 3:
            return "LK"
        case 4:
            return "LSP"
        default:
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "FirstTableViewCell") as! FirstTableViewCell
            if (dashboardDetails.count > 2) {
                var dashboardDetail1 = dashboardDetails[0]
                let rkapOk = dashboardDetail1.ok
                let rkapOp = dashboardDetail1.op
                let rkapLk = dashboardDetail1.lk
                let rkapLsp = dashboardDetail1.lsp
                cell.rkapOkLabel.text = decimalFormatter.string(from: NSNumber(value: rkapOk))
                cell.rkapOpLabel.text = decimalFormatter.string(from: NSNumber(value: rkapOp))
                cell.rkapLkLabel.text = decimalFormatter.string(from: NSNumber(value: rkapLk))
                cell.rkapLspLabel.text = decimalFormatter.string(from: NSNumber(value: rkapLsp))
                
                dashboardDetail1 = dashboardDetails[1]
                let riOk = dashboardDetail1.ok
                let riOp = dashboardDetail1.op
                let riLk = dashboardDetail1.lk
                let riLsp = dashboardDetail1.lsp
                cell.riOkLabel.text = decimalFormatter.string(from: NSNumber(value: riOk))
                cell.riOpLabel.text = decimalFormatter.string(from: NSNumber(value: riOp))
                cell.riLkLabel.text = decimalFormatter.string(from: NSNumber(value: riLk))
                cell.riLspLabel.text = decimalFormatter.string(from: NSNumber(value: riLsp))
                
                dashboardDetail1 = dashboardDetails[2]
                let progOk = dashboardDetail1.ok
                let progOp = dashboardDetail1.op
                let progLk = dashboardDetail1.lk
                let progLsp = dashboardDetail1.lsp
                cell.progOkLabel.text = decimalFormatter.string(from: NSNumber(value: progOk))
                cell.progOpLabel.text = decimalFormatter.string(from: NSNumber(value: progOp))
                cell.progLkLabel.text = decimalFormatter.string(from: NSNumber(value: progLk))
                cell.progLspLabel.text = decimalFormatter.string(from: NSNumber(value: progLsp))
                
                cell.onOkButtonTapped = { tag in
                    self.selectedDataType = self.getSelectedDataTypeByTag(tag: tag)
                    self.selectedProjectType = 1
                    self.performSegue(withIdentifier: self.OK_DETAILS_SEGUE, sender: self)
                }
            } else {
                cell.rkapOkLabel.text = "-"
                cell.rkapOpLabel.text = "-"
                cell.rkapLkLabel.text = "-"
                cell.rkapLspLabel.text = "-"
                
                cell.riOkLabel.text = "-"
                cell.riOpLabel.text = "-"
                cell.riLkLabel.text = "-"
                cell.riLspLabel.text = "-"
                
                cell.progOkLabel.text = "-"
                cell.progOpLabel.text = "-"
                cell.progLkLabel.text = "-"
                cell.progLspLabel.text = "-"
            }
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SecondTableViewCell") as! SecondTableViewCell
            cell.titleLabel.text = "Sisa Hasil Usaha"
            cell.titleLabel.textColor = UIColor.red
            cell.onOkButtonTapped = { tag in
                self.selectedDataType = self.getSelectedDataTypeByTag(tag: tag)
                self.selectedProjectType = 2
                self.performSegue(withIdentifier: self.OK_DETAILS_SEGUE, sender: self)
            }
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
            cell.onOkButtonTapped = { tag in
                self.selectedDataType = self.getSelectedDataTypeByTag(tag: tag)
                self.selectedProjectType = 3
                self.performSegue(withIdentifier: self.OK_DETAILS_SEGUE, sender: self)
            }
            var dashboardDetail3: DashboardDetail?
            if (dashboardDetails.count > 4) {
                dashboardDetail3 = dashboardDetails[4]
            }
            setDetailLabels2(dashboardDetail: dashboardDetail3, cell: cell)
            cell.titleLabel.text = "OK Lama"
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SecondTableViewCell") as! SecondTableViewCell
            cell.onOkButtonTapped = { tag in
                self.selectedDataType = self.getSelectedDataTypeByTag(tag: tag)
                self.selectedProjectType = 4
                self.performSegue(withIdentifier: self.OK_DETAILS_SEGUE, sender: self)
            }
            cell.titleLabel.text = "OK Baru (Sudah Didapat)"
            var dashboardDetail4: DashboardDetail?
            if (dashboardDetails.count > 5) {
                dashboardDetail4 = dashboardDetails[5]
            }
            setDetailLabels2(dashboardDetail: dashboardDetail4, cell: cell)
            return cell
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SecondTableViewCell") as! SecondTableViewCell
            cell.onOkButtonTapped = { tag in
                self.selectedDataType = self.getSelectedDataTypeByTag(tag: tag)
                self.selectedProjectType = 5
                self.performSegue(withIdentifier: self.OK_DETAILS_SEGUE, sender: self)
            }
            cell.titleLabel.text = "OK Baru (Dalam Pengusahaan)"
            var dashboardDetail5: DashboardDetail?
            if (dashboardDetails.count > 6) {
                dashboardDetail5 = dashboardDetails[6]
            }
            setDetailLabels2(dashboardDetail: dashboardDetail5, cell: cell)
            return cell
        case 6:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SecondTableViewCell") as! SecondTableViewCell
            cell.onOkButtonTapped = { tag in
                self.selectedDataType = self.getSelectedDataTypeByTag(tag: tag)
                self.selectedProjectType = 6
                self.performSegue(withIdentifier: self.OK_DETAILS_SEGUE, sender: self)
            }
            cell.titleLabel.text = "Klaim"
            var dashboardDetail6: DashboardDetail?
            if (dashboardDetails.count > 7) {
                dashboardDetail6 = dashboardDetails[7]
            }
            setDetailLabels2(dashboardDetail: dashboardDetail6, cell: cell)
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
            let lk = detail.lk
            let lsp = detail.lsp
            cell.okLabel.text = decimalFormatter.string(from: NSNumber(value: ok))
            cell.opLabel.text = decimalFormatter.string(from: NSNumber(value: op))
            cell.lkLabel.text = decimalFormatter.string(from: NSNumber(value: lk))
            cell.lspLabel.text = decimalFormatter.string(from: NSNumber(value: lsp))
        } else {
            cell.okLabel.text = "-"
            cell.opLabel.text = "-"
            cell.lkLabel.text = "-"
            cell.lspLabel.text = "-"
        }
    }
    
    private func setDetailLabels2(dashboardDetail: DashboardDetail?, cell: SecondTableViewCell) {
        if let detail = dashboardDetail {
            let ok = detail.ok
            let op = detail.op
            let lk = detail.lk
            let lsp = detail.lsp
            cell.okLabel.text = decimalFormatter.string(from: NSNumber(value: ok))
            cell.opLabel.text = decimalFormatter.string(from: NSNumber(value: op))
            cell.lkLabel.text = decimalFormatter.string(from: NSNumber(value: lk))
            cell.lspLabel.text = decimalFormatter.string(from: NSNumber(value: lsp))
        } else {
            cell.okLabel.text = "-"
            cell.opLabel.text = "-"
            cell.lkLabel.text = "-"
            cell.lspLabel.text = "-"
        }
    }
    @IBAction func onMenuButtonDidTouch(_ sender: Any) {
//        performSegue(withIdentifier: BAD_SEGUE, sender: self)
//        performSegue(withIdentifier: UMUR_PIUTANG_SEGUE, sender: self)
//        performSegue(withIdentifier: CASH_FLOW_SEGUE, sender: self)
//        performSegue(withIdentifier: PROGNOSA_SEGUE, sender: self)
        showActionSheet()
    }
    
    private func showActionSheet() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let firstMenuButton = UIAlertAction(title: "Piutang & BAD", style: .default, handler: { (action) -> Void in
            self.performSegue(withIdentifier: self.BAD_SEGUE, sender: self)
        })
        
        let secondMenuButton = UIAlertAction(title: "Umur Piutang", style: .default, handler: { (action) -> Void in
            self.performSegue(withIdentifier: self.UMUR_PIUTANG_SEGUE, sender: self)
        })
        
        let thirdMenuButton = UIAlertAction(title: "Cash Flow RKAP", style: .default, handler: { (action) -> Void in
            self.performSegue(withIdentifier: self.CASH_FLOW_SEGUE, sender: self)
        })
        
        let fourthMenuButton = UIAlertAction(title: "Prognosa Piutang", style: .default, handler: { (action) -> Void in
            self.performSegue(withIdentifier: self.PROGNOSA_SEGUE, sender: self)
        })
        
        let  logoutButton = UIAlertAction(title: "Logout", style: .destructive, handler: { (action) -> Void in
            self.dismiss(animated: true, completion: {})
        })
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) -> Void in
            
//            print("Cancel button tapped")
        })
        
        alertController.addAction(firstMenuButton)
        alertController.addAction(secondMenuButton)
        alertController.addAction(thirdMenuButton)
        alertController.addAction(fourthMenuButton)
        alertController.addAction(logoutButton)
        alertController.addAction(cancelButton)
        
        self.navigationController!.present(alertController, animated: true, completion: nil)
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
