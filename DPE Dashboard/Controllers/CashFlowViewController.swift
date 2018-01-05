//
//  CashFlowViewController.swift
//  DPE Dashboard
//
//  Created by Muhammad Yusuf on 1/5/18.
//  Copyright © 2018 Department Power Plant & Energy. All rights reserved.
//

import UIKit

class CashFlowViewController: UIViewController, MonthYearPickerDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var monthYearLabel: UIButton!
    @IBOutlet weak var tableView: UITableView!
    var selectedMonth: Int?
    var selectedYear: Int?
    let SHOW_MONTH_YEAR_PICKER_SEGUE = "ShowMonthYearPickerSegue"
    var cashFlows = [CashFlow]()
    
    let decimalFormatter = NumberFormatter()
    override func viewDidLoad() {
        super.viewDidLoad()
        initFormatter()
        initTableView()
        updateDashboardState()
    }

    private func initFormatter() {
        self.decimalFormatter.numberStyle = NumberFormatter.Style.decimal
        self.decimalFormatter.minimumFractionDigits = 2
        self.decimalFormatter.maximumFractionDigits = 2
    }
    
    private func setMonthYearLabel() {
        self.monthYearLabel.setTitle("\(Constant.months[self.selectedMonth! - 1]), \(self.selectedYear!)", for: .normal)
    }
    
    @IBAction func monthYearLabelDidTouch(_ sender: Any) {
        showFilter()
    }
    
    func monthYearSelected(month: Int, year: Int) {
        self.selectedMonth = month
        self.selectedYear = year
        updateDashboardState()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == SHOW_MONTH_YEAR_PICKER_SEGUE) {
            let destinationVC  = segue.destination as? MonthYearPickerViewController
            destinationVC?.selectedYear = self.selectedYear
            destinationVC?.selectedMonth = self.selectedMonth
            destinationVC?.delegate = self
        }
    }
    
    private func showFilter() {
        performSegue(withIdentifier: SHOW_MONTH_YEAR_PICKER_SEGUE, sender: self)
    }
    
    private func updateDashboardState() {
        setMonthYearLabel()
        updateTableData()
    }
    
    private func updateTableData() {
        DashboardService.getCashFlowData(year: self.selectedYear!, month: self.selectedMonth!) { cashFlows in
            self.cashFlows = cashFlows
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
        return self.cashFlows.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CashFlowTableViewCell") as! CashFlowTableViewCell
        let cashFlow = self.cashFlows[indexPath.row]
        cell.titleLabel.text = cashFlow.name
        cell.rkapLabel.text = self.decimalFormatter.string(from: NSNumber(value: cashFlow.rkap))
        cell.rencanaLabel.text = self.decimalFormatter.string(from: NSNumber(value: cashFlow.rencana))
        return cell
    }

}
