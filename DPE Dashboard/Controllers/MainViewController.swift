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
    
    @IBOutlet weak var chartContainer: UIView!
    @IBOutlet weak var scrollPageContainer: UIView!
    @IBOutlet weak var monthYearLabel: UIButton!
    
    let decimalFormatter = NumberFormatter()
    let numberFormatter = NumberFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initFormatter()
        initMonthYear()
        initChartView()
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
        setMonthYearLabel()

//        loadTableData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC  = segue.destination as? MonthYearPickerViewController
        destinationVC?.selectedYear = self.selectedYear
        destinationVC?.selectedMonth = self.selectedMonth
        destinationVC?.delegate = self
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
        
        setMonthYearLabel()
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
        
        let chartViewController = storyboard.instantiateViewController(withIdentifier: "chartViewController") 
        
        chartContainer.addSubview(chartViewController.view)
//        chartViewController.view.frame = chartContainer.bounds
        chartViewController.view.frame = CGRect(x: 0, y: 0, width: chartContainer.bounds.size.width, height: chartContainer.bounds.size.height)
//        chartViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        chartViewController.didMove(toParentViewController: self)
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
