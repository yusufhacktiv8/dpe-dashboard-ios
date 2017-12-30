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
    
    @IBOutlet weak var chartContainer: UIView!
    @IBOutlet weak var scrollPageContainer: UIView!
    @IBOutlet weak var monthYearLabel: UIButton!
    @IBOutlet weak var monthScrollView: UIScrollView!
    @IBOutlet weak var monthSlider: MonthSlider!
    @IBOutlet weak var tableView: UITableView!
    
    var chartViewController: ChartViewController?
    
    let decimalFormatter = NumberFormatter()
    let numberFormatter = NumberFormatter()
    
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
    
    private func initTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
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
        if (indexPath.row == 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FirstTableViewCell") as! FirstTableViewCell
            return cell
        } else if (indexPath.row == 1) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SecondTableViewCell") as! SecondTableViewCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ThirdTableViewCell") as! ThirdTableViewCell
            return cell
        }
        
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
