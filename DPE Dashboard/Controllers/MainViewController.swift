//
//  MainViewController.swift
//  DPE Dashboard
//
//  Created by Muhammad Yusuf on 12/26/17.
//  Copyright © 2017 Department Power Plant & Energy. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, MonthYearPickerDelegate {
    
    var selectedMonth: Int = Constant.defaultMonth
    var selectedYear: Int = Constant.defaultYear
    let SHOW_MONTH_YEAR_PICKER_SEGUE = "ShowMonthYearPickerSegue"

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    private func showFilter() {
        performSegue(withIdentifier: SHOW_MONTH_YEAR_PICKER_SEGUE, sender: self)
    }
    
    @IBAction func searchButtonDidTouch(_ sender: Any) {
        showFilter()
    }
    
    func monthYearSelected(month: Int, year: Int) {
//        self.selectedMonth = month
//        self.selectedYear = year
//        setMonthYearLabel()
//
//        loadTableData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC  = segue.destination as? MonthYearPickerViewController
        destinationVC?.selectedYear = self.selectedYear
        destinationVC?.selectedMonth = self.selectedMonth
        destinationVC?.delegate = self
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
