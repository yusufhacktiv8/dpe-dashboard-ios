//
//  OkDetailsViewController.swift
//  DPE Dashboard
//
//  Created by Muhammad Yusuf on 3/14/18.
//  Copyright © 2018 Department Power Plant & Energy. All rights reserved.
//

import UIKit

class OkDetailsViewController: UIViewController, MonthYearPickerDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var monthYearLabel: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var selectedMonth: Int?
    var selectedYear: Int?
    var projectType: Int?
    let SHOW_MONTH_YEAR_PICKER_SEGUE = "ShowMonthYearPickerSegue"
    let decimalFormatter = NumberFormatter()
    
    var okProjects = [OkProjectDetails]()

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
    
    private func initTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func monthYearLabelDidTouch(_ sender: Any) {
        showFilter()
    }
    private func setMonthYearLabel() {
        self.monthYearLabel.setTitle("\(Constant.months[self.selectedMonth! - 1]), \(self.selectedYear!)", for: .normal)
    }
    
    private func showFilter() {
        performSegue(withIdentifier: SHOW_MONTH_YEAR_PICKER_SEGUE, sender: self)
    }
    
    func monthYearSelected(month: Int, year: Int) {
        self.selectedMonth = month
        self.selectedYear = year
        updateDashboardState()
    }
    
    private func updateDashboardState() {
        setMonthYearLabel()
        updateData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == SHOW_MONTH_YEAR_PICKER_SEGUE) {
            let destinationVC  = segue.destination as? MonthYearPickerViewController
            destinationVC?.selectedYear = self.selectedYear
            destinationVC?.selectedMonth = self.selectedMonth
            destinationVC?.delegate = self
        }
    }
    
    private func updateData() {
        DashboardService.getOkProjectDetailsData(year: self.selectedYear!, month: self.selectedMonth!, projectType: self.projectType!) { okProjects in
            self.okProjects = okProjects
            self.tableView.reloadData()
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.okProjects.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OkDetailsTableViewCell") as! OkDetailsTableViewCell
        let okProject = self.okProjects[indexPath.row]
        cell.projectNameLabel.text = okProject.projectName
        
        return cell
    }

}
