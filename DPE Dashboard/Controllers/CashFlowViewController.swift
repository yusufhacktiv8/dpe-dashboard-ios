//
//  CashFlowViewController.swift
//  DPE Dashboard
//
//  Created by Muhammad Yusuf on 1/5/18.
//  Copyright © 2018 Department Power Plant & Energy. All rights reserved.
//

import UIKit

class CashFlowViewController: UIViewController {

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
    
    private func setMonthYearLabel() {
        self.monthYearLabel.setTitle("\(Constant.months[self.selectedMonth! - 1]), \(self.selectedYear!)", for: .normal)
    }
    
    private func updateDashboardState() {
        setMonthYearLabel()
//        updateTableData()
    }

}
