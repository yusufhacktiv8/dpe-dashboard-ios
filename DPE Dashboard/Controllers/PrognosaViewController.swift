//
//  PrognosaViewController.swift
//  DPE Dashboard
//
//  Created by Muhammad Yusuf on 1/5/18.
//  Copyright © 2018 Department Power Plant & Energy. All rights reserved.
//

import UIKit

class PrognosaViewController: UIViewController, MonthYearPickerDelegate {

    @IBOutlet weak var monthYearLabel: UIButton!
    
    @IBOutlet weak var pdpLabel: UILabel!
    @IBOutlet weak var tagBrutoLabel: UILabel!
    @IBOutlet weak var pUsahaLabel: UILabel!
    @IBOutlet weak var pRetensiLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var mainBackground: UIImageView!
    var selectedMonth: Int?
    var selectedYear: Int?
    let SHOW_MONTH_YEAR_PICKER_SEGUE = "ShowMonthYearPickerSegue"
    let decimalFormatter = NumberFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initFormatter()
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
    
    private func setMonthYearLabel() {
        self.monthYearLabel.setTitle("\(Constant.months[self.selectedMonth! - 1]), \(self.selectedYear!)", for: .normal)
    }

    @IBAction func monthYearLabelDidTouch(_ sender: Any) {
        showFilter()
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
        DashboardService.getPrognosaPiutangData(year: self.selectedYear!, month: self.selectedMonth!) { prognosa in
            let total = prognosa.pdp + prognosa.tagihanBruto + prognosa.piutangUsaha + prognosa.piutangRetensi
            self.pdpLabel.text = self.decimalFormatter.string(from: NSNumber(value: prognosa.pdp))
            self.tagBrutoLabel.text = self.decimalFormatter.string(from: NSNumber(value: prognosa.tagihanBruto))
            self.pUsahaLabel.text = self.decimalFormatter.string(from: NSNumber(value: prognosa.piutangUsaha))
            self.pRetensiLabel.text = self.decimalFormatter.string(from: NSNumber(value: prognosa.piutangRetensi))
            self.totalLabel.text = self.decimalFormatter.string(from: NSNumber(value: total))
        }
    }
}
