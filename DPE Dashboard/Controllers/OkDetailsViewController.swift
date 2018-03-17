//
//  OkDetailsViewController.swift
//  DPE Dashboard
//
//  Created by Muhammad Yusuf on 3/14/18.
//  Copyright © 2018 Department Power Plant & Energy. All rights reserved.
//

import UIKit

class OkDetailsViewController: UIViewController, MonthYearPickerDelegate {
    
    @IBOutlet weak var monthYearLabel: UIButton!
    
    var selectedMonth: Int?
    var selectedYear: Int?
    let SHOW_MONTH_YEAR_PICKER_SEGUE = "ShowMonthYearPickerSegue"
    let decimalFormatter = NumberFormatter()

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
        
    }

}
