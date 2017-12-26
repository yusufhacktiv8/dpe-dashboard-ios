//
//  MonthYearPickerViewController.swift
//  DPE Dashboard
//
//  Created by Muhammad Yusuf on 12/26/17.
//  Copyright © 2017 Department Power Plant & Energy. All rights reserved.
//

import UIKit

class MonthYearPickerViewController: UIViewController {

    @IBOutlet weak var monthYearPickerContainerView: UIView!
    var selectedMonth: Int?
    var selectedYear: Int?
    var delegate: MonthYearPickerDelegate?
    var monthYearPickerView: MonthYearPickerView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let monthYearPickerView = MonthYearPickerView()
        self.monthYearPickerView = monthYearPickerView
        monthYearPickerContainerView.addSubview(monthYearPickerView)
        
        if let theMonth = self.selectedMonth {
            monthYearPickerView.month = theMonth
        }
        
        if let theYear = self.selectedYear {
            monthYearPickerView.year = theYear
        } 
    }
    
    @IBAction func selectMonthYear(_ sender: Any) {
        if let theDelegate = self.delegate {
            theDelegate.monthYearSelected(month: monthYearPickerView!.month, year: monthYearPickerView!.year)
        }
        performSegueToReturnBack()
    }
}

protocol MonthYearPickerDelegate {
    func monthYearSelected(month: Int, year: Int)
}
