//
//  OkDetailsViewController.swift
//  DPE Dashboard
//
//  Created by Muhammad Yusuf on 3/14/18.
//  Copyright © 2018 Department Power Plant & Energy. All rights reserved.
//

import UIKit
import SwiftSpinner

class OkDetailsViewController: UIViewController, MonthYearPickerDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var monthYearLabel: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var pageTitle: UILabel!
    @IBOutlet weak var mainBackground: UIImageView!
    var selectedMonth: Int?
    var selectedYear: Int?
    var dataType: String?
    var projectType: Int?
    let SHOW_MONTH_YEAR_PICKER_SEGUE = "ShowMonthYearPickerSegue"
    let decimalFormatter = NumberFormatter()
    
    var okProjects = [OkProjectDetails]()

    override func viewDidLoad() {
        super.viewDidLoad()
        initFormatter()
        initPageTitle()
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
    
    private func initTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func initPageTitle() {
        switch (projectType!) {
        case 1:
            self.pageTitle.text = "Total - \(dataType!)"
        case 2:
            self.pageTitle.text = "Sisa - \(dataType!)"
        case 3:
            self.pageTitle.text = "OK Lama - \(dataType!)"
        case 4:
            self.pageTitle.text = "OK Baru (Sudah Didapat) - \(dataType!)"
        case 5:
            self.pageTitle.text = "OK Baru (Dalam Pengusahaan) - \(dataType!)"
        case 6:
            self.pageTitle.text = "Klaim - \(dataType!)"
        default:
            self.pageTitle.text = "-"
        }
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
        
        SwiftSpinner.show("Loading data...").addTapHandler({
            SwiftSpinner.hide()
        }, subtitle: "")
        
        self.okProjects = []
        self.tableView.reloadData()
        
        DashboardService.getOkProjectDetailsData(year: self.selectedYear!, month: self.selectedMonth!, projectType: self.projectType!) { status, okProjects in
            
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
                self.okProjects = []
                for okProject in okProjects! {
                    if (self.projectType! == 3) {
                        if (okProject.projectType == 1 || okProject.projectType == 2 || okProject.projectType == 3) {
                            self.okProjects.append(okProject)
                        }
                    } else if (self.projectType! == 4) {
                        if (okProject.projectType == 4 || okProject.projectType == 5 || okProject.projectType == 6) {
                            self.okProjects.append(okProject)
                        }
                    } else if (self.projectType! == 5) {
                        if (okProject.projectType == 7 || okProject.projectType == 8 || okProject.projectType == 9) {
                            self.okProjects.append(okProject)
                        }
                    } else if (self.projectType! == 6) {
                        if (okProject.projectCode == "851E03") {
                            self.okProjects.append(okProject)
                        }
                    } else {
                        self.okProjects.append(okProject)
                    }
                    
                }
                self.tableView.reloadData()
            }
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.okProjects.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch self.projectType! {
        case 1:
            return 120.0
        case 2, 3, 4, 5, 6:
            return 90.0
        default:
            return 120.0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch self.projectType! {
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "OkDetailsTableViewCell") as! OkDetailsTableViewCell
            let okProject = self.okProjects[indexPath.row]
            cell.projectNameLabel.text = okProject.projectName
            
            switch(self.dataType!) {
            case "OK":
                cell.rkapLabel.text = self.decimalFormatter.string(from: NSNumber(value: okProject.rkapOk))
                cell.riLabel.text = self.decimalFormatter.string(from: NSNumber(value: okProject.realisasiOk))
                cell.progLabel.text = self.decimalFormatter.string(from: NSNumber(value: okProject.prognosaOk))
            case "OP":
                cell.rkapLabel.text = self.decimalFormatter.string(from: NSNumber(value: okProject.rkapOp))
                cell.riLabel.text = self.decimalFormatter.string(from: NSNumber(value: okProject.realisasiOp))
                cell.progLabel.text = self.decimalFormatter.string(from: NSNumber(value: okProject.prognosaOp))
            case "LK":
                cell.rkapLabel.text = self.decimalFormatter.string(from: NSNumber(value: okProject.rkapLk))
                cell.riLabel.text = self.decimalFormatter.string(from: NSNumber(value: okProject.realisasiLk))
                cell.progLabel.text = self.decimalFormatter.string(from: NSNumber(value: okProject.prognosaLk))
            case "LSP":
                cell.rkapLabel.text = self.decimalFormatter.string(from: NSNumber(value: okProject.rkapLk))
                cell.riLabel.text = self.decimalFormatter.string(from: NSNumber(value: okProject.realisasiLk))
                cell.progLabel.text = self.decimalFormatter.string(from: NSNumber(value: okProject.prognosaLk))
            default:
                cell.rkapLabel.text = "-"
                cell.riLabel.text = "-"
                cell.progLabel.text = "-"
            }
            return cell
        case 2, 3, 4, 5, 6:
            let cell = tableView.dequeueReusableCell(withIdentifier: "OkDetailsSisaTableViewCell") as! OkDetailsSisaTableViewCell
            let okProject = self.okProjects[indexPath.row]
            cell.projectNameLabel.text = okProject.projectName
            switch(self.dataType!) {
            case "OK":
                cell.valueLabel.text = self.decimalFormatter.string(from: NSNumber(value: okProject.prognosaOk - okProject.realisasiOk))
            case "OP":
                cell.valueLabel.text = self.decimalFormatter.string(from: NSNumber(value: okProject.prognosaOp - okProject.realisasiOp))
            case "LK":
                cell.valueLabel.text = self.decimalFormatter.string(from: NSNumber(value: okProject.prognosaLk - okProject.realisasiLk))
            case "LSP":
                cell.valueLabel.text = self.decimalFormatter.string(from: NSNumber(value: okProject.prognosaLk - okProject.realisasiLk))
            default:
                cell.valueLabel.text = "-"
            }
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "OkDetailsTableViewCell") as! OkDetailsTableViewCell
            return cell
        }
    }
}
